require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  test "should not save without email" do
    invitation = Invitation.new
    assert_not invitation.save
  end
end
