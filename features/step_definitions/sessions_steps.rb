Kernel.require_relative "../support/fixtures"

Given(/^I am logged in as "(.*?)"$/) do |arg1|
	@current_user = User.find_by_email('sarah@foo.com')
	visit("/login")
	fill_in("email", :with => 'sarah@foo.com')
	fill_in("password", :with => 'secret')
	click_button("Login")
end