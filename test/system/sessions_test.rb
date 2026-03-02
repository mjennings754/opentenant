require "application_system_test_case"

class SessionsTest < ApplicationSystemTestCase
  setup do 
    @user = users(:one)
  end

  test "should sign in user" do
    login(@user)
    sleep(2)
    visit dashboard_url
    assert_current_path dashboard_path
  end
end
