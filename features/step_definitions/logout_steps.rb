Given(/^a logged in user$/) do
  user = create(:user)
  visit login_path
  fill_login_page user
end

When(/^he clicks "([^"]*)"$/) do |link|
  click_link link
end