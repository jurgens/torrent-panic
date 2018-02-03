require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should have_many :releases }

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
