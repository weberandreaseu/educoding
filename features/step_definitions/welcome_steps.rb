# Tutorial by Cezar Halmagean
# https://semaphoreci.com/community/tutorials/introduction-to-writing-acceptance-tests-with-cucumber
# Visited 27.04.16

When(/^I visit the home page$/) do
  visit root_path
end

Then(/^I should see a welcome message$/) do
  expect(page).to have_content("Welcome")
end