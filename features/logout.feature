Feature: Logout
When I am logged in
I always want to be able to log me out

Scenario: Logout
Given a logged in user
When he clicks "Logout"
Then he should see a confirmation "logged out"