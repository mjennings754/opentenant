class Property < ApplicationRecord
  belongs_to :organization
  has_many :invitations, as: :invitable
  has_many :tenants
  has_many :users, through: :tenants
  def address
    [
      address_line_one,
      address_line_two,
      city,
      state,
      postcode
    ].reject(&:blank?).join(', ')
end
end
