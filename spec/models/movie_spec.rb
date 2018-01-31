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

require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'recently_crawled?' do
    specify 'for new movie' do
      movie = Movie.new
      expect(movie.recently_crawled?).to eq false
    end

    specify 'when crawled long ago' do
      movie = Movie.new crawled_at: 2.days.ago
      expect(movie.recently_crawled?).to eq false
    end

    specify 'when crawled recently' do
      movie = Movie.new crawled_at: 1.hours.ago
      expect(movie.recently_crawled?).to eq true
    end
  end
end
