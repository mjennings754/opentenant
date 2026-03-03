class Issue < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :comments
  has_many_attached :images
  STATUSES = [:open, :assigned, :completed, :closed]
end
