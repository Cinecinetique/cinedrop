Feature: Sharing files with a partner

As a producer
I want to share the documents of my choice from my project with a partner
So that the partner can do the required work on the document


Background: Logged in
	Given I am logged in as "Rija"

Scenario: Preparing a file to be sent to a partner
	Given there is a document in my project
	And there is a File Outbox area
	When I drag and drop the document on that area
	Then the document is listed in the File Outbox Area
	And has a link to a unique download url
	And has a checkbox next to its name


Scenario: Selecting documents to send and to whom
	Given there are documents listed under the File Outbox area
	When I tick the checkbox of  one of them
	And I click the Send button
	Then a popup up appear asking for an email address


Scenario: Sending selected document to a partner
	Given there are documents listed under the File Outbox area
	And I have ticked the checkboxes for two of them
	And I click the send button
	When I input an email address in the popup window
	And I click the send button in the pop up window
	Then an email is sent to that email address with the unique download link for each of the ticked documents in the email body