When(/^I send an invite to a user for that project$/) do
  	visit("/users/new")
	fill_in("name", :with => 'Random User 1')
	fill_in("email", :with => 'random_user_1_ccq@rijam.sent.as')
	click_button("Send invite")
end

Then(/^a crew registration link is created and emailed to the user$/) do
  page.should have_content("An invite was successfully sent to random_user_1_ccq@rijam.sent.as")
end

Given(/^I have received an invitation to a project$/) do
  visit("/workers/new?p=0")
end

Given(/^I have signed up$/) do
  step "a user is visiting the signup page"
	step "the user submit the sign up form"
	step "the user is redirected to the sign in page"
	step "a message is displayed asking the user to check her email"
end

Given(/^I have confirmed my email$/) do
	visit("http://localhost:4567/")
	confirmation_token_pattern = /confirmation_token=(.*)"/
	matched = page.body.scan(confirmation_token_pattern)
	Rails.logger.debug("Matched token: #{matched.last[0]}")
  visit("/users/confirmation?confirmation_token=#{matched.last[0]}")
  page.should have_content("Your account was successfully confirmed")
end

Then(/^I'm redirected to the crew registration page$/) do
  page.current_url.should eq('http://localhost:3000/workers/new?p=0')
end