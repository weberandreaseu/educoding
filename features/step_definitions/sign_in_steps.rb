Given(/^a registred user$/) do
  User.create(firstname: "John", lastname: "Doe", email: "john@doe.com", password: "1234")
end

When(/^I click login$/) do
  click_link "Login"
end

When(/^I fill my email and password$/) do
  fill_in "Email", with: "john@doe.com"
  fill_in "Password", with: "1234"
end

When(/^I submit my login data$/) do
  click_button "Login"
end

Then(/^I should see an login confirmation$/) do
  expect(page).to have_content("You are logged in")
end

# Then(/^I should be logged in$/) do
#   pending # Write code here that turns the phrase above into concrete actions
# end

Then(/^I should see my firstname$/) do
  expect(page).to have_content("John")
end