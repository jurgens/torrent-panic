class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  scope :pending, -> { where(notified_at: nil) }
end
