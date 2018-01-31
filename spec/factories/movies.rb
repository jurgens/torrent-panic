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

FactoryBot.define do
  factory :movie do
    sequence(:title)  { |n| "movie #{n}" }
    year              { rand 1960..2018 }
  end
end
