When(/^I request a new project to be created$/) do
  click_link("New Project")
end

When(/^I fill in the project details$/) do
  fill_in('Name', :with => "MyProject")
  click_button("Create Project")
end

Then(/^a new project is created$/) do
  page.should have_content('MyProject')
end

Given(/^a project "(.*?)" created by me exists on the platform$/) do |arg1|
	step 'I request a new project to be created'
	step 'I fill in the project details'
	step 'a new project is created'
end

When(/^I request project "(.*?)" to be deleted$/) do |arg1|
  visit ("/projects/")
	within('tr', text: 'MyProject') do
		click_link("Delete")
	end
end

When(/^I confirm the request$/) do
	page.driver.browser.switch_to.alert.accept
end

Then(/^the project "(.*?)" is removed from the platform$/) do |arg1|
  page.should_not have_content('MyProject')
end

Given(/^I am crew on project "(.*?)"$/) do |arg1|
  visit("/projects")
  page.should have_content("Project 1")
end

Then(/^I cannot request project "(.*?)" to be deleted$/) do |arg1|
	page.should_not have_content("Delete")
end