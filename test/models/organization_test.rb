require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  test "should not save without name" do
    org = Organization.new(name: nil, email:"testuser@app.com", user_id:1)
    assert_not org.valid?, "organization name is empty"
  end

  test "should not save without email" do
    org = Organization.new(name: "acme-org", email: nil, user_id:1)
    assert_not org.valid?, "organization email is empty"
  end
end
