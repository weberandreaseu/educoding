Given(/^a registred user$/) do
  @user = create(:user)
end

When(/^he visits the login page$/) do
  visit login_path
end

When(/^he fills his email and password$/) do
  fill_login_page @user
end

When(/^he presses the "([^"]*)" button$/) do |button|
  click_button button
end

Then(/^he should see his firstname$/) do
  expect(page).to have_content @user.firstname
end