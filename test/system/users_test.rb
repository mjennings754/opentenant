require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "should create user and sign in automatically" do
    visit signup_url

    fill_in "Username", with: @user.username
    fill_in "Lastname", with: @user.lastname
    fill_in "Firstname", with: @user.firstname
    fill_in "Password", with: "secret"
    fill_in "Email", with: @user.email
    fill_in "Password confirmation", with: "secret"
    click_button "Create user"
    sleep(1)
    visit dashboard_url
    assert_current_path dashboard_path
  end
end
