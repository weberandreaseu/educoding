When(/^a user visits sign up$/) do
  visit signup_path
end

When(/^fills the registration form$/) do
  user = build(:user)
  fill_signup_page user
end

When(/^submits the form$/) do
end

When(/^clicks button "([^"]*)"$/) do |button|
  click_button button
end

Then(/^he should see a welcome message$/) do
   expect(page).to have_content('successfully registred')
end