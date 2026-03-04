class Property < ApplicationRecord
  belongs_to :organization
  has_many :invitations, as: :invitable, dependent: :destroy
  has_many :tenants, dependent: :destroy
  has_many :users, through: :tenants
  has_many :issues, dependent: :destroy
  def address
    [
      address_line_one,
      address_line_two,
      city,
      state,
      postcode
    ].reject(&:blank?).join(', ')
  end

  def tenant?(user)
    users.exists?(user.id)
  end
end
