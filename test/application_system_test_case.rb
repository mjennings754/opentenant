require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :safari, screen_size: [ 700, 700 ]

  def login(user)
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'secret'
    click_button "Sign in"
  end
end
