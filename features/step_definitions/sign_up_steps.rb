When(/^a user visits sign up$/) do
  visit signup_path
end

When(/^fills the registration form$/) do
  user = build(:user)
  fill_signup_page user
end

When(/^submits the form$/) do
  click_button "Submit"
end

Then(/^he should see a welcome message$/) do
   expect(page).to have_content('successfully registred')
end