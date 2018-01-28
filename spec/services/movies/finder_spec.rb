require 'rails_helper'

describe Movies::Finder do
  let(:user) { create :user }

  specify "process" do
    expect { described_class.new('pulp fiction', user).process }.to change(Movie, :count).to(1)

    movie = Movie.last
    expect(movie.tmdb_id).to eq 680
    expect(movie.title).to eq 'Pulp Fiction'
    expect(movie.year).to eq 1994
    expect(movie.poster).to be_truthy
  end
end
