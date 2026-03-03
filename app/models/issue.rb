class Issue < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :comments
  STATUSES = [:open, :assigned, :completed, :closed]
end
