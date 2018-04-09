require 'rails_helper'

describe Operations::FindMovie do
  let(:user) { create :user }

  context 'when movie does not exist', :vcr do
    specify 'it should create a movie' do
      expect { described_class.new('pulp fiction', user).process }.to change(Movie, :count).to(1)

      movie = Movie.last
      expect(movie.tmdb_id).to eq 680
      expect(movie.title).to eq 'Pulp Fiction'
      expect(movie.year).to eq 1994
      expect(movie.poster).to be_truthy
    end
  end

  context 'when movie already exist' do
    before { create :movie, tmdb_id: 680, title: 'Pulp Fiction' }

    specify 'it should not create a new movie' do
      expect { described_class.new('Криминальное чтиво', user).process }.not_to change(Movie, :count)
    end
  end
end
