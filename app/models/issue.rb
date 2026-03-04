class Issue < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  STATUSES = [:open, :assigned, :completed, :closed]
end
