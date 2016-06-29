Given(/^A task "([^"]*)"$/) do |title|
  @task = create(:task_with_class_files, title: title)
end

Given(/^a student$/) do
  @user = create(:user)
end

When(/^the student visits the task page$/) do
  visit task_path(id: @task.id)
end

When(/^he completes the scaffold$/) do
  # scaffold is already complete
end

Then(/^he should see an output "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^all tests should be successful$/) do
  pending # Write code here that turns the phrase above into concrete actions
end