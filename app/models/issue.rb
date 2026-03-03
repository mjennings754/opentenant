class Issue < ApplicationRecord
  belongs_to :property
  belongs_to :user
  STATUSES = [:open, :assigned, :completed, :closed]
end
