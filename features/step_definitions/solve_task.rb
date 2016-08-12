Given(/^A task "([^"]*)"$/) do |title|
  @task = create(:task_with_class_files, title: title)
end

When(/^the student visits the task page$/) do
  visit tasks_path
  click_link @task.title
end

When(/^he completes the scaffold$/) do
  # scaffold is already complete
end

When(/^he runs the code$/) do
  click_button('Run')
end

Then(/^he should see an output "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^all tests should be successful$/) do
  pending # Write code here that turns the phrase above into concrete actions
end