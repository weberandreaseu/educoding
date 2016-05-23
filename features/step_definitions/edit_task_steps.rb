Given(/^a Task "([^"]*)"$/) do |old_title|
  @task = create(:task, title: old_title)
end

When(/^he clicks the edit link of the task$/) do
  find('.table tr', text: @task.title).click_link("edit")
end

When(/^he changes the title to "([^"]*)"$/) do |new_title|
  fill_in "Title", with: new_title
end

Then(/^he should see "([^"]*)"$/) do |new_title|
  expect(page).to have_content(new_title)
end
