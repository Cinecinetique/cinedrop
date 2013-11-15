Kernel.require_relative "../support/fixtures"


Given(/^I am logged in as "(.*?)"$/) do |type_of_user|
	login_details = user_details_for_a(type_of_user)
	@current_user = User.find_by_email(login_details[:email])
	visit("/users/sign_in")
	fill_in("user_email", :with => login_details[:email])
	fill_in("user_password", :with => login_details[:password])
	click_button("Sign in")

end