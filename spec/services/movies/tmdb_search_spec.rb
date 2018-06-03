require 'rails_helper'

describe Movies::TmdbSearch, :vcr do
  specify 'search with a title' do
    movie = subject.find_best('Robocop')
    expect(movie).to be_a Movie
    expect(movie.title).to eq 'RoboCop'
    expect(movie.year).to eq 1987
  end

  specify 'search with a title and a year' do
    movie = subject.find_best('Robocop 2014')
    expect(movie).to be_a Movie
    expect(movie.year).to eq 2014
  end
end
