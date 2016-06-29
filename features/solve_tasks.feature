Feature: Solving Tasks
Students have to solve tasks. For completing the coding challenge, they earn points. The score depends on the quality of the solution, which is automatically calculated by test cases.

Scenario: Run Hello World
Given A task "Hello World"
And a student
When the student visits the task page
And he completes the scaffold
And he clicks the "Run" button
Then he should see an output "Hello World"
And all tests should be successful