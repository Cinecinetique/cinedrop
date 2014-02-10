class PaypalNotificationsController < ApplicationController
  before_action :set_paypal_notification, only: [:show, :edit, :update, :destroy]
  #protect_from_forgery :except => [:create]
  skip_before_action :verify_authenticity_token

  # GET /paypal_notifications
  # GET /paypal_notifications.json
  def index
    @paypal_notifications = PaypalNotification.all
  end

  # GET /paypal_notifications/1
  # GET /paypal_notifications/1.json
  def show
  end

  # GET /paypal_notifications/new
  def new
    @paypal_notification = PaypalNotification.new
  end

  # GET /paypal_notifications/1/edit
  def edit
  end

  # POST /paypal_notifications
  # POST /paypal_notifications.json
  def create
    Rails.logger.info "IPN Message received!"
    response = PaypalNotification.validate_IPN_notification(::IPN_URL, request.raw_post)
    Rails.logger.info "Response from Paypal IPN: #{response}"
    case response
    when "VERIFIED"
      notification = PaypalNotification.new(status:"VERIFIED",message:request.raw_post)
      if request.params[:txn_type] == "subscr_signup"
        user = request.params[:custom]
        user_instance = User.find(user)
        plan = request.params[:item_number]
        amount = request.params[:mc_amount3]
        currency = request.params[:mc_currency]
        start_date = request.params[:subscr_date]
        plan_id = get_plan_id(plan)
        Rails.logger.debug("Plan Id: #{plan_id}")
        begin
          Subscription.create(start_date: DateTime.strptime(CGI.unescape(start_date), '%H:%M:%S %b %d, %Y %Z'),
                              amount: amount,
                              currency:currency,
                              status: Subscription::STATUSES["trial"],
                              user_id:user,
                              plan_id:plan_id
                              )
          notification.save
          user_instance.add_role :subscriber
        rescue ActiveRecord::RecordNotUnique
          Rails.logger.warn "Duplicate IPN message: #{request.raw_post}"
        end
      elsif request.params[:txn_type] == "subscr_payment"
        transaction_id = request.params[:txn_id]
        payment_status = request.params[:payment_status]
        payment_date = request.params[:payment_date]
        amount = request.params[:mc_gross]
        user = request.params[:custom]
        user_instance = User.find(user)
        plan = request.params[:item_number]
        currency = request.params[:mc_currency]
        begin
          instalment = Instalment.new(transaction_id: transaction_id, 
                                      payment_status: payment_status,
                                      status: Instalment.status_hash(payment_status),
                                      payment_date: DateTime.strptime(CGI.unescape(payment_date), '%H:%M:%S %b %d, %Y %Z'), 
                                      amount: amount, 
                                      currency: currency)
          plan_id = get_plan_id(plan)
          Rails.logger.debug("Plan Id: #{plan_id}")
          subscription = Subscription.find_by_user_id_and_plan_id_and_amount(user, plan_id, amount)

          if subscription
            instalment.subscription_id = subscription.id
            subscription.status = Subscription::STATUSES["paid"]
            Rails.logger.info "Updating subscription #{subscription.id} to status: #{Subscription::STATUSES["paid"]}"
            subscription.save
          end
          instalment.save

          if payment_status == "Completed" && user_instance
            user_instance.add_role :subscriber
          end
        rescue ActiveRecord::RecordNotUnique
          Rails.logger.warn "Duplicate IPN message: #{request.raw_post}"
        end
      elsif request.params[:txn_type] == "subscr_cancel"
        user = request.params[:custom]
        user_instance = User.find(user)
        amount = request.params[:mc_amount3]
        plan = request.params[:item_number]
        plan_id = get_plan_id(plan)
        subscription = Subscription.find_by_user_id_and_plan_id_and_amount(user, plan_id, amount)
        if subscription
          subscription.status = Subscription::STATUSES["cancelled"]
          Rails.logger.info "Updating subscription #{subscription.id} to status: #{Subscription::STATUSES["cancelled"]}"
          subscription.save
          user_instance.remove_role :subscriber
        else
          Rails.logger.error "No subscription found for #{user}, #{plan_id}, #{amount}"

        end

      else
        notification.save
      end

      render :nothing => true, :status => 200
    when "INVALID"
      PaypalNotification.create(status:"INVALID",message:request.raw_post)
      render :nothing => true, :status => 200
    else
      Rails.logger.error "Paypal responded with incorrect value (neither VERIFIED or INVALID)"
      render :nothing => true, :status => 400
    end
  end

  # PATCH/PUT /paypal_notifications/1
  # PATCH/PUT /paypal_notifications/1.json
  def update
    respond_to do |format|
      if @paypal_notification.update(paypal_notification_params)
        format.html { redirect_to @paypal_notification, notice: 'Paypal notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paypal_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paypal_notifications/1
  # DELETE /paypal_notifications/1.json
  def destroy
    @paypal_notification.destroy
    respond_to do |format|
      format.html { redirect_to paypal_notifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paypal_notification
      @paypal_notification = PaypalNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paypal_notification_params
      params.require(:paypal_notification).permit(:transaction_type, :transaction_id, :parent_transaction_id, :message, :payment_status, :receiver_email, :buyer_email, :status, :custom)
    end

    def get_plan_id(plan_ref)
      Rails.logger.debug("Rails env: #{Rails.env}")
      if Rails.env == "production"
        plan_id = Plan.find_by_paypal_prod_button(plan_ref).try(:id)
      elsif Rails.env == "test"
        plan_id = Plan.find_by_paypal_test_button(plan_ref).try(:id)
      else
        plan_id = Plan.find_by_paypal_dev_button(plan_ref).try(:id)
      end
    end
end
