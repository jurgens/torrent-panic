class Search < ApplicationRecord
  belongs_to :user
  belongs_to :movie, optional: true

  enum status: { no_movie: 0, no_releases: 1, error: 2, ok: 3 }

  delegate :id, to: :user, prefix: true
  delegate :full_name, to: :user

  scope :ordered, -> { order(created_at: :desc) }

  def movie_title
    movie.present? ? movie.title : '-'
  end
end
