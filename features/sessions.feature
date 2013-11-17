Feature: Management of user sessions

As a user of the system
I want to sign up, sign in and sign out from the system
So that I can safely conduct my business as allowed by the system

@ok
Scenario: Signing Up as a member
Given a user is visiting the signup page
When the user submit the sign up form
Then the user is redirected to the sign in page
And a message is displayed asking the user to check her email

@ok
Scenario: Signing In as a member
Given a user is confirmed
When the user signs in
Then the user is redirected to the plans page

