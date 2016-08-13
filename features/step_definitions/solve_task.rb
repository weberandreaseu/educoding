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

Then(/^he should see an output "([^"]*)"$/) do |output|
  expect(page).to have_content(output)
end

Then(/^all tests should be successful$/) do
  expect(page).to have_content("Test say hello")
  expect(page).to have_content("Passed successfully")
end