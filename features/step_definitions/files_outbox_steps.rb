Given(/^there is a document in my project$/) do
  visit("/projects/1/")
  click_link "New Document", :match => :first
  fill_in("Name", :with => 'My Cucumber Document')
  click_button "Create Document"
end

Given(/^there is a File Outbox area$/) do
  visit("/projects/1/")
  expect(page).to have_content 'FILES OUTBOX'
end

When(/^I drag and drop the document on that area$/) do
  drop_place = page.find_by_id("file_outbox_dropzone")
  selected_document = page.find_by_id("document_my-cucumber-document")
  # selected_document.drag_to(drop_place)

  selenium_webdriver = page.driver.browser
  selenium_webdriver.mouse.down(selected_document.native)
  selenium_webdriver.mouse.move_to(drop_place.native, 0, 10)
  selenium_webdriver.mouse.up
  save_and_open_page
end

Then(/^the document is listed in the File Outbox Area$/) do
  visit("/projects/1/")
  within("#file_outbox_dropzone") do 
    find_by_id("tosend_document_my-cucumber-document")
  end
end

Then(/^has a link to a unique download url$/) do
  pending # express the regexp above with the code you wish you had
end


Then(/^has a checkbox next to its name$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^there are documents listed under the File Outbox area$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I tick the checkbox of  one of them$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click the Send button$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a popup up appear asking for an email address$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have ticked the checkboxes for two of them$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I click the send button$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I input an email address in the popup window$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click the send button in the pop up window$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^an email is sent to that email address with the unique download link for each of the ticked documents in the email body$/) do
  pending # express the regexp above with the code you wish you had
end