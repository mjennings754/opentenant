class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username, :email, :firstname, :lastname
  has_many :members
  has_many :organizations, through: :members
  has_many :created_organizations, class_name: "Organization", foreign_key: :user_id
  has_many :tenants
  has_many :properties, through: :tenants
  def all_organizations
    organizations.or(created_organizations).distinct
  end
end
