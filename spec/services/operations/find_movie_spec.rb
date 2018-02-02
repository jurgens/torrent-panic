require 'rails_helper'

describe Operations::FindMovie do
  let(:user) { create :user }
  let(:tmdb_result) do
    Tmdb::Movie.new adult: false,
                    id: 680,
                    backdrop_path: "/9rZg1J6vMQoDVSgRyWcpJa8IAGy.jpg",
                    original_title:"Pulp Fiction",
                    overview: "A burger-loving hit man, his philosophical partner, a drug-addled gangster's moll and a washed-up boxer converge in this sprawling, comedic crime caper. Their adventures unfurl in three stories that ingeniously trip back and forth in time.",
                    popularity: 58.380511,
                    poster_path: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg",
                    release_date: "1994-09-10",
                    title: "Pulp Fiction",
                    vote_average: 8.3,
                    vote_count: 10134
  end

  before do
    allow(Tmdb::Movie).to receive(:find).and_return([tmdb_result])
  end

  context 'when movie does not exist' do
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
