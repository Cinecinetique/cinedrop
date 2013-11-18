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