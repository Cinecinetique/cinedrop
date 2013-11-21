Feature: Subscriptions

As a new member
I want to sign up to my chosen subscription plan
So that I can enjoy the features allocated by the subscription plan

@ok
Scenario: A member with enough fund signs up for a plan
Given a user is a confirmed member
When she visits the plans page
And select one of the plan
Then the user is redirect to Paypal for payment

@ok
Scenario: A member is redirected to the site after paying on Paypal
Given a member has payed with Paypal for the plan she has chosen
When she is redirected to the platform
Then she is shown a thank you and be patient message

@wip
Scenario: A member's signup to a plan is confirmed by paypal
Given paypal has sent a notification to our platform
When our platform has valided the authenticity of the message
Then the member's subscription plan is activated

Scenario: A member signed up for a plan cancels her subscription

Scenario: A member signed up for a plan changes her subscription

Scenario: A member signing up for a plan fails due to insufficient fund

Scenario: A member signed up for a plan has an instalment rejected due to insufficient fund

Scenario: A member chargeback her payment

