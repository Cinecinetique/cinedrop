Feature: Project Crew Management

As a crew member
I want to access all the projects I need to work on
So that I can do the work expected by the projects creators

@ok
Scenario: A subscriber invite a user to a project
	Given I am logged in as "Subscriber"
	And a project "MyProject" created by me exists on the platform
	When I send an invite to a user for that project
	Then a crew registration link is created and emailed to the user


@ok
Scenario: A user receives an invitation to join a project
	Given I have received an invitation to a project
	And I have signed up
	And I have confirmed my email
	When I am logged in as "Member"
	Then I'm redirected to the crew registration page