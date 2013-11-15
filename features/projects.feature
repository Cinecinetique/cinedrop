Feature: Accessing And Managing Projects

As a subscriber
I want to manage my allocated number of projects
So that I can create, delete the project
And change its information

	
@ok
Scenario: A subscriber can create one project
	Given I am logged in as "Subscriber"
	When I request a new project to be created
	And I fill in the project details
	Then a new project is created

@ok
Scenario: A subscriber can delete a project she/he has created
	Given I am logged in as "Subscriber"
	And a project "MyProject" created by me exists on the platform
	When I request project "MyProject" to be deleted
	And I confirm the request
	Then the project "MyProject" is removed from the platform

@wip
Scenario: A susbscriber cannot delete a project she/he hasn't created
	Given I am logged in as "Subscriber"
	And a project "Not Mine" not created by me exists on the platform
	When I request project "Mine" to be deleted
	And I confirm the request
	Then the project "Not Mine" is not removed from the platform
	And an error message is displayed

Scenario: A subscriber with the small plan cannot create more than one project

Scenario: A subscriber with the medium plan cannot create more than five projects

Scenario: A member cannot create a project

Scenario: A user who is a crew on a project and a subscriber can create a project

Scenario: A user who is a crew on a project and subscriber of medium plan cannot create more than five projects
