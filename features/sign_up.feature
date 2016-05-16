Feature: Sign Up
An unregistred user
Wants to sign up
So he can log in

Scenario: Sign up
When a user visits sign up
And fills the registration form
And submits the form
Then he should see a confirmation "successfully registred"