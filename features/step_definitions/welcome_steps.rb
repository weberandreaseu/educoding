# Tutorial by Cezar Halmagean
# https://semaphoreci.com/community/tutorials/introduction-to-writing-acceptance-tests-with-cucumber
# Visited 27.04.16

When(/^(?:he|a user) visits the home page$/) do
  visit root_path
end

Then(/^he should see a confirmation "([^"]*)"$/) do |msg|
  expect(page).to have_content msg
end