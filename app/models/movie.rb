class Movie < ApplicationRecord
  has_many :releases, dependent: :delete_all
  has_many :wishes, dependent: :delete_all

  CRAWL_INTERVAL = 24.hours

  def recently_crawled?
    return false if crawled_at.nil?
    crawled_at > CRAWL_INTERVAL.ago
  end
end
