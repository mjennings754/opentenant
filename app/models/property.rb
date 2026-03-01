class Property < ApplicationRecord
  belongs_to :organization

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
