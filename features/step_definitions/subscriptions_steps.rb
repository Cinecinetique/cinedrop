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
  page.current_url.should =~ /https:\/\/www\.sandbox\.paypal\.com/
end

Given(/^a member has payed with Paypal for the plan she has chosen$/) do
	@auth = "xxxx"
end

When(/^she is redirected to the platform$/) do
  visit("/subscriptions/complete_checkout?auth=@auth")
end

Then(/^she is shown a thank you and be patient message$/) do
  page.should have_content("Thank you for sign up for a plan. Your subscription will be processed shortly.")
end