# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  title      :string
#  poster     :string
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  crawled_at :datetime
#  tmdb_id    :integer
#

class Movie < ApplicationRecord
  include Recent

  has_many :releases, dependent: :delete_all
  has_many :wishes, dependent: :delete_all

  CRAWL_INTERVAL = 24.hours

  def full_title
    [title, year].compact.join(', ')
  end

  def recently_crawled?
    return false if crawled_at.nil?
    crawled_at > CRAWL_INTERVAL.ago
  end
end
