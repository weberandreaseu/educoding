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

  def fill_new_task_page(task)
    fill_in "Title", with: task.title
    find(:xpath, "//input[@id='task_description']").set task.description
    fill_in "Score", with: task.score
  end
end

World(FormHelper)