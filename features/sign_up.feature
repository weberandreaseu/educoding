Feature: Sign up
As a unregistred visitor
I want to sign up for educoding
So I can use the full functionality of the service

Scenario: Sign up
When I visit the home page
# And I am not logged in
And I click sign up
And I fill the registration form
And submit the form
Then I should get a confirmation