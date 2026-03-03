class Organization < ApplicationRecord
  validates_uniqueness_of :name, :email
  validates_presence_of :name, :email
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :invitations, as: :invitable, dependent: :destroy
  has_many :properties
  def add_member(user, role: 'member')
    members.create(user: user, role: role)
  end

  def owner?(user)
    user.present? && user_id == user.id
  end
end