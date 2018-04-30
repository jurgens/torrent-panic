class Search < ApplicationRecord
  belongs_to :user

  enum status: { no_movie: 0, no_releases: 1, error: 2, ok: 3 }

  delegate :id, to: :user, prefix: true
end
