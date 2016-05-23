Feature: Create a new Task
Some users (admins, lecturer) have the permissions to create new tasks
Tasks are part of an excercise an are solved by students

Scenario: New descriptive Task
# Given an authorized person is logged in
When a user visits the tasks overview
And he clicks "New Task"
And fills the new task from
And he clicks the "Create Task" button
Then he should see a confirmation "Task was created"
And page should have the task title	


Scenario: Edit existing Task
Given a Task "Old Task title"
When a user visits the tasks overview
And he clicks the edit link of the task
And he changes the title to "New Task Title"
And he clicks the "Update Task" button
Then he should see "New Task Title"

Scenario: Delete existing Task
Given a Task "Task to delete"
When a user visits the tasks overview
And he clicks the delete link of the task
# And he confirms the deletion
Then he should not see "Task to delete"