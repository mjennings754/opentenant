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

  test "should not save with same username" do
    user = User.create!(username: "testuser", firstname: "blank", lastname: "blank", email: "testuser@app.com", password:"secret", password_confirmation:"secret")
    user1 = User.new(username: "testuser", firstname: "blank", lastname: "blank", email: "testuser2@app.com", password:"secret", password_confirmation:"secret")
    user1.save
    assert_not user1.valid?, "saved with the same username"
  end

  test "should not save with same email" do
    user = User.create!(username: "testuser2", firstname: "blank", lastname: "blank", email: "testuser3@app.com", password:"secret", password_confirmation:"secret")
    user1 = User.new(username: "testuser3", firstname: "blank", lastname: "blank", email: "testuser3@app.com", password:"secret", password_confirmation:"secret")
    user1.save
    assert_not user1.valid?, "saved with the same username"
  end
end

