When(/^I request a new project project to be created$/) do
  click_link("New Project")
end

When(/^I fill in the project details$/) do
  fill_in('Name', :with => "MyProject")
  click_button("Create Project")
end

Then(/^a new project is created$/) do
  page.should have_content('MyProject')
end