When(/^he clicks the delete link of the task$/) do
  find('.table tr', text: @task.title).click_link("delete")
end

# When(/^he confirms the deletion$/) do
#   page.accept_confirm do
#     click_link 'Delete'
#   end
# end

Then(/^he should not see "([^"]*)"$/) do |title|
  expect(page).to_not have_content(title)
end
