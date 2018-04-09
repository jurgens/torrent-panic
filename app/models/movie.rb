class Movie < ApplicationRecord
  include Recent

  has_many :releases, dependent: :delete_all
  has_many :wishes, dependent: :delete_all
  has_many :pending_wishes, -> { Wish.pending }, class_name: 'Wish'

  CRAWL_INTERVAL = 24.hours

  scope :ordered, -> { order(crawled_at: :desc) }

  def full_title
    [title, year].compact.join(', ')
  end

  def recently_crawled?
    return false if crawled_at.nil?
    crawled_at > CRAWL_INTERVAL.ago
  end
end
