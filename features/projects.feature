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

@ok
Scenario: A susbscriber is not allowed to delete a project she/he hasn't created
	Given I am logged in as "Subscriber"
	And I am crew on project "Project 1"
	Then I cannot request project "Project 1" to be deleted

@ok
Scenario: A member is not allowed to create a project
	Given I am logged in as "Member"
	Then I cannot request a new project to be created

@ok
Scenario: A member navigating to the dashboard is redirected to the plans page
	Given I am logged in as "Member"
	When I navigate to the project dashboard
	Then I am redirected to the plans selection page

@paused
Scenario: A member who is on a project navigating to the dashboard only see her project
	Given I am logged in as "Crew Member"
	When I navigate to the project dashboard
	Then I can see project "Project 1" on the dashboard

Scenario: A subscriber with the small plan cannot create more than one project

Scenario: A subscriber with the medium plan cannot create more than five projects

Scenario: A user who is a crew on a project and a subscriber can create a project

Scenario: A user who is a crew on a project and subscriber of medium plan cannot create more than five projects
