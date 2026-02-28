require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do 
    @user = users(:one)
  end

  test "should sign in user" do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "secret"
    click_button "Sign in"
    visit dashboard_path
    assert_current_path dashboard_path
  end
end
