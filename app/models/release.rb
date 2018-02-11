class Release < ApplicationRecord
  belongs_to :movie

  scope :popular, -> { order(:downloads => :desc) }

  def has_link?
    true
  end
end
