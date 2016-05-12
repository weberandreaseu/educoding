When(/^I click sign up$/) do
  click_button "Sign up"
end

When(/^I fill the registration form$/) do
  fill_in "Firstname", with: "John"
  fill_in "Lastname", with: "Doe"
  fill_in "Email", with: "john@doe.com"
  fill_in "Password", with: "1234"
  fill_in "Password confirmation", with: "1234"
end

When(/^submit the form$/) do
  click_button "Submit"
end

 Then(/^I should get a confirmation$/) do
   expect(page).to have_content('successfully registred')
end