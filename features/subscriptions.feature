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

@ok @use-test-env
Scenario: A member is redirected to the site after paying on Paypal
Given a member has payed with Paypal for the plan she has chosen
And a member is signed in
When she is redirected to the platform
Then she is shown a thank you and be patient message

@ok @use-test-env
Scenario: A member's signup to a plan is confirmed by paypal
Given a member is signed in
And paypal has sent a subscription notification to our platform
And paypal has sent a payment notification to our platform
When our platform has validated the authenticity of the message
Then our platform has processed the message for completed payment

@ok @use-test-env
Scenario: A member subscription is activated upon subscription notification
Given a member is signed in
And a subscription has been created
When a member reload the completed_checkout page
Then the member is redirected to the project page
And the subscribtion status change to "trial"

@ok @use-test-env
Scenario: A member signed up for a plan make first payment
Given a member is signed in
And a subscription has been created
And the first instalment has been paid
Then the subscribtion status change to "paid"


Scenario: A member signed up for a plan cancels her subscription

Scenario: A member signed up for a plan changes her subscription

Scenario: A member signing up for a plan fails due to insufficient fund

Scenario: A member signed up for a plan has an instalment rejected due to insufficient fund

Scenario: A member chargeback her payment

