Feature: Solving Tasks
Students have to solve tasks. For completing the coding challenge, they earn points. The score depends on the quality of the solution, which is automatically calculated by test cases.

Scenario: Run Hello World
Given: A task "Hello World"
And a student
When the student completes the scaffold
And he click the button "Run"
He should see an output "Hello World"
And all tests should be successful