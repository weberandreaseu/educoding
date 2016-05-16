module FormHelper
  def fill_login_page(user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
  end

  def fill_signup_page(user)
    fill_in "Firstname", with: user.firstname
    fill_in "Lastname", with: user.lastname
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
  end
end

World(FormHelper)