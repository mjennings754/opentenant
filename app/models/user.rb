class User < ApplicationRecord
  has_secure_password
  before_create :generate_verification_token
  validates_presence_of :username, :email, :firstname, :lastname
  has_many :members
  has_many :organizations, through: :members
  has_many :created_organizations, class_name: "Organization", foreign_key: :user_id
  has_many :tenants
  has_many :properties, through: :tenants
  def all_organizations
    organizations.or(created_organizations).distinct
  end

  def generate_verification_token
    self.verification_token = SecureRandom.hex(10)
  end

  def verify_email(token)
    if self.verification_token == token
      update(verified: true, verification_token: nil)
    end
  end

  def verified?
    self.verified == true
  end

  def unverified?
    self.verified == false
  end
end
