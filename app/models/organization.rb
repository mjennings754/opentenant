class Organization < ApplicationRecord
  validates_uniqueness_of :name, :email
  validates_presence_of :name
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :invitations, as: :invitable, dependent: :destroy

  def add_member(user, role: 'member')
    members.create(user: user, role: role)
  end
end