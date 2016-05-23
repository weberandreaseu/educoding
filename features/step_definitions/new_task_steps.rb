# Given(/^an authorized person is logged in$/) do
#   pending # Write code here that turns the phrase above into concrete actions
# end

When(/^a user visits the tasks overview$/) do
  visit tasks_path
end

When(/^fills the new task from$/) do
  @task = build(:task)
  fill_new_task_page @task
end

Then(/^page should have the task title$/) do
  expect(page).to have_content @task.title
end