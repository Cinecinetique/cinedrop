Kernel.require_relative "../support/fixtures"


Given(/^I am logged in as "(.*?)"$/) do |arg1|
	@current_user = User.find_by_email('vera_ccq@rijam.sent.as')
	visit("/users/sign_in")
	fill_in("user_email", :with => 'vera_ccq@rijam.sent.as')
	fill_in("user_password", :with => '12345678')
	click_button("Sign in")

end