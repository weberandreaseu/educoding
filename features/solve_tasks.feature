Feature: Solving Tasks
Students have to solve tasks. For completing the coding challenge, they earn points. The score depends on the quality of the solution, which is automatically calculated by test cases.

Scenario: Run Hello World
Given A task "Hello World Test"
And a logged in student
When the student visits the task page
And he completes the scaffold
And he runs the code
Then he should see an output "Hello World"
And all tests should be successful