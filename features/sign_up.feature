Feature: Sign up
As a unregistred user
I want to sign up
So I can log me in

Scenario: Sign up
When I visit the home page
# And I am not logged in
And I click sign up
And I fill the registration form
And submit the form
Then I should get a confirmation