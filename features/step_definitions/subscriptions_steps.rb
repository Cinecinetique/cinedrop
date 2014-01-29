Given(/^a user is a confirmed member$/) do
  step  'I am logged in as "Member"'
end

When(/^she visits the plans page$/) do
  visit("/plans")
end

When(/^select one of the plan$/) do
 #  within("#indies") do
	#   click_on("Subscribe")
	# end
	find('#indies').click
end

Then(/^the user is redirect to Paypal for payment$/) do
  page.current_url.should =~ /#{PAYPAL_URL}/
end

Given(/^a member has payed with Paypal for the plan she has chosen$/) do
	@auth = "xxxx"
end

When(/^she is redirected to the platform$/) do
  get("/subscriptions/complete_checkout?auth=@auth")
end

Then(/^she is shown a thank you and be patient message$/) do
  last_response.body.should have_content("Thank you for sign up for a plan. Your subscription will be processed shortly.")
end


Given(/^paypal has sent a subscription notification to our platform$/) do
  @subscription_message="mc_amount3=19.95&protection_eligibility=Eligible&address_status=confirmed&payer_id=LPLWNMTBWMFAY&tax=0.00&address_street=1+Main+St&payment_date=20%3A12%3A59+Jan+13%2C+2009+PST&payment_status=Completed&charset=windows-1252&address_zip=95131&first_name=Test&mc_fee=0.88&address_country_code=US&address_name=Test+User&notify_version=2.6&custom=1&payer_status=verified&address_country=United+States&address_city=San+Jose&quantity=1&verify_sign=AtkOfCXbDm2hu0ZELryHFjY-Vb7PAUvS6nMXgysbElEn9v-1XcmSoGtf&payer_email=gpmac_1231902590_per%40paypal.com&txn_id=61E67681CH3238416&payment_type=instant&last_name=User&address_state=CA&receiver_email=gpmac_1231902686_biz%40paypal.com&payment_fee=0.88&receiver_id=S8XGHLYDW9T3S&txn_type=subscr_signup&subscr_date=20%3A12%3A59+Jan+13%2C+2009+PST&item_name=&mc_currency=USD&item_number=1741&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=19.95&shipping=0.00&subscr_id=dfsadfa77"
  post("/paypal_notifications",@subscription_message)
end


Given(/^paypal has sent a payment notification to our platform$/) do
	@payment_message="mc_gross=19.95&protection_eligibility=Eligible&address_status=confirmed&payer_id=LPLWNMTBWMFAY&tax=0.00&address_street=1+Main+St&payment_date=20%3A12%3A59+Jan+13%2C+2009+PST&payment_status=Completed&charset=windows-1252&address_zip=95131&first_name=Test&mc_fee=0.88&address_country_code=US&address_name=Test+User&notify_version=2.6&custom=1&payer_status=verified&address_country=United+States&address_city=San+Jose&quantity=1&verify_sign=AtkOfCXbDm2hu0ZELryHFjY-Vb7PAUvS6nMXgysbElEn9v-1XcmSoGtf&payer_email=gpmac_1231902590_per%40paypal.com&txn_id=61E67681CH3238416&payment_type=instant&last_name=User&address_state=CA&receiver_email=gpmac_1231902686_biz%40paypal.com&payment_fee=0.88&receiver_id=S8XGHLYDW9T3S&txn_type=subscr_payment&item_name=&mc_currency=USD&item_number=1741&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=19.95&shipping=0.00&subscr_id=dfsadfa77"
  post("/paypal_notifications",@payment_message)
end


When(/^our platform has validated the authenticity of the message$/) do
	# 1. our platform makes a POST call to paypal endpoint with identical message
	# 2. paypal return status to our endpoint
	doubles_serialized = RestClient.get "http://localhost:4578/doubles.json"
	doubles = JSON.parse(doubles_serialized)
	double_id = doubles[0]['double']['id']
	double_serialized = RestClient.get "http://localhost:4578/doubles/#{double_id}.json"
	double_data = JSON.parse(double_serialized)
	double_data['double']['requests'].length.should == 2
	double_data['double']['requests'][0]['body'].should == @subscription_message
	double_data['double']['requests'][1]['body'].should == @payment_message
end

When(/^our platform has processed the message for completed payment$/) do
  page.should have_content("")
  last_response.status.should == 200
end

Then(/^the member's subscription plan is activated$/) do
  visit('/subscriptions/complete_checkout')
  page.current_url.should eq projects_url
  save_and_open_page
end

Given(/^a member is signed in$/) do
  User.create!(name:"Rocky", 
  						email: 'racktest_ccq@rijam.sent.as',
  						password:'12345678',
  						confirmed_at: Time.now)
  login_as(User.first, :run_callbacks => false)
end

Given(/^a subscription has been created$/) do
  step 'paypal has sent a subscription notification to our platform'
  subscription = Subscription.find_by_user_id(1)
  plan_id = Plan.find_by_paypal_dev_button('1741').try(:id)
  subscription.amount.should eq(19.95)
  subscription.plan_id.should eq(plan_id)
end

When(/^a member reload the completed_checkout page$/) do
  get("/subscriptions/complete_checkout")
end

Then(/^the member is redirected to the project page$/) do
  last_response.should be_redirect
  follow_redirect!
  last_request.path.should == projects_path
end

Given(/^the first instalment has been paid$/) do
  step 'paypal has sent a payment notification to our platform' # express the regexp above with the code you wish you had
end

Then(/^the subscribtion status change to "(.*?)"$/) do |status|
  subscription = Subscription.find_by_user_id(1)
  subscription.status.should eq(Subscription::STATUSES[status])
end
