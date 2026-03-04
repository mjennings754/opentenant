require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should not save without username" do
    @user.username = nil
    assert_not @user.save, "User doesn't have a username"
  end

  test "should not save without email" do
    @user.email = nil
    assert_not @user.save, "User doesn't have a email"
  end

  test "user should have verification token" do
    user = User.new

    user.generate_verification_token

    assert_not_nil user.verification_token
  end

  test "user token is 20 characters" do
    user = User.new

    user.generate_verification_token

    assert_equal 20, user.verification_token.length
  end
end
