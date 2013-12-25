class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:payment_notifications]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def complete_checkout
    # if current_user is subscriber, redirect to dashboard
    if Subscription.where("user_id = #{current_user.id} and start_date < '#{Time.now}'").count > 0
      Rails.logger.debug "completed check out for user_id: #{current_user.id}"
      redirect_to projects_url
    else
    # otherwise render empty page with a message
      render action: 'complete_checkout'
    end
  end

  # POST /subscriptions/payment_notifications
  def payment_notifications
    # if current_user is subscriber, redirect to dashboard
    # otherwise process the IPN message

    response = IpnMessage.validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      IpnMessage.create(status:"VERIFIED",message:request.raw_post)
      render :nothing => true, :status => 200
    when "INVALID"
      IpnMessage.create(status:"INVALID",message:request.raw_post)
      render :nothing => true, :status => 200
    else
      Rails.logger.error "Paypal responded with incorrect value (neither VERIFIED or INVALID)"
      render :nothing => true, :status => 400
    end

  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subscription }
      else
        format.html { render action: 'new' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:start_date, :end_date, :amount, :currency, :billing_frequency, :status, :user_id, :plan_id, :initial_amount, :initial_currency, :initial_billing_frequency, :previous_amount, :previous_currency, :previous_billing_frequency, :last_plan_price_change_date)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipn_params
      params.require(:subscription).permit(:mc_gross, :payer_id, :custom, :item_number, :quantity, :protection_eligibility, :payment_type, :mc_fee, :mc_currency, :payment_status, :payment_gross, :payment_fee, :payment_date, :receiver_email, :receiver_id, :txn_id, :payer_status, :payer_email, :txn_type)
    end

    protected 
    

end
