Feature: Login
A registred user
Wants to login
To be able to get personalized functionalities

Scenario: Valid login
Given a registred user
When he visits the login page
And he fills his email and password
And he clicks the "Login" button
Then he should see a confirmation "logged in"
And he should see his firstname