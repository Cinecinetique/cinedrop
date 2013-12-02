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
    response = PaypalNotification.validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      notification = PaypalNotification.new(status:"VERIFIED",message:request.raw_post)
      if request.params[:txn_type] == "subscr_signup"
        user = request.params[:custom]
        plan = request.params[:item_number]
        amount = request.params[:mc_gross]
        currency = request.params[:mc_currency]
        start_date = request.params[:subscr_date]
        begin
          Subscription.create(start_date:start_date,
                              amount: amount,
                              currency:currency,
                              status: 1,
                              user_id:user,
                              plan_id:plan
                              )
          notification.save
        rescue ActiveRecord::RecordNotUnique
          Rails.logger.warn "Duplicate IPN message: #{request.raw_post}"
        end
      elsif request.params[:txn_type] == "recurring_payment"
        transaction_id = request.params[:txn_id]
        payment_status = request.params[:payment_status]
        payment_date = request.params[:payment_date]
        amount = request.params[:mc_gross]
        user = request.params[:custom]
        plan = request.params[:item_number]
        currency = request.params[:mc_currency]
        begin
          instalment = Instalment.new(transaction_id: transaction_id, 
                                      payment_status: payment_status,
                                      status: Instalment.status_hash(payment_status),
                                      payment_date: DateTime.strptime(CGI.unescape(payment_date), '%H:%M:%S %b %d, %Y %Z'), 
                                      amount: amount, 
                                      currency: currency)
          subscription = Subscription.find_by_user_id_and_plan_id_and_amount(user, plan, amount)
          instalment.subscription_id = subscription.id if subscription
          instalment.save
        rescue ActiveRecord::RecordNotUnique
          Rails.logger.warn "Duplicate IPN message: #{request.raw_post}"
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
end
