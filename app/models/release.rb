class Release < ApplicationRecord
  belongs_to :movie

  scope :popular, -> { order(:downloads => :desc) }
end
