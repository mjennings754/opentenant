class Invitation < ApplicationRecord
  belongs_to :invitable, polymorphic: true
  belongs_to :inviter, polymorphic: true
  belongs_to :invited_user, class_name: "User"

  before_validation :generate_token, on: :create
  before_validation :set_default_role, on: :create
  validates_presence_of :email, :token

  def accepted?
    accepted_at.present?
  end

  def accept!(user)
    return false if accepted?

    if invitable.respond_to?(add_member)
      invitable.add_member(user, role: role)
    end

    update!(accepted_at: Time.current)
  end

  private

  def set_default_role
    self.role ||= "member"
  end

  def generate_token
    self.token ||= SecureRandom.hex(20)
  end
end
