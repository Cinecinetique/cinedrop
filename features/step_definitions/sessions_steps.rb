Kernel.require_relative "../support/fixtures"


Given(/^I am logged in as "(.*?)"$/) do |type_of_user|
	login_details = user_details_for_a(type_of_user)
	@current_user = User.find_by_email(login_details[:email])
	visit("/users/sign_in")
	fill_in("user_email", :with => login_details[:email])
	fill_in("user_password", :with => login_details[:password])
	click_button("Sign in")

end

Given(/^a user is visiting the signup page$/) do
  visit("/users/sign_up")
end

When(/^the user submit the sign up form$/) do
	login_details = user_details_for_a("New User")
  fill_in("user_email", :with => login_details[:email])
  fill_in("user_password", :with => login_details[:password])
  fill_in("user_password_confirmation", :with => login_details[:password])
  click_button("Sign up")
end

Then(/^the user is redirected to the sign in page$/) do
	page.current_url.should == "http://localhost:3000/users/sign_in"
end

Then(/^a message is displayed asking the user to check her email$/) do
  page.should have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
  # from devise: A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
end