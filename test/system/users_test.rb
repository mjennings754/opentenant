require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "should create user" do
    visit new_user_url

    fill_in "Username", with: @user.username
    fill_in "Lastname", with: @user.lastname
    fill_in "Firstname", with: @user.firstname
    fill_in "Password", with: "secret"
    fill_in "Email", with: @user.email
    fill_in "Password confirmation", with: "secret"
    click_button "Create user"
    @user.reload
    visit user_url(@user)
    assert_text "Success!"
    assert_current_path user_url(@user)
  end
end
