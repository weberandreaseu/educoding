Feature: Sign in
As a registred user
I want to login
To be able to get personalized functionalities

Scenario: Sign in
Given a registred user
When I visit the home page
And I click login
And I fill my email and password
Then I should see an login confirmation
And I should be logged in
And I should see my firstname