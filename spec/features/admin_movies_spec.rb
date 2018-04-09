require 'rails_helper'

describe 'Admin/Movies' do
  before { basic_auth 'admin', 'password' }

  specify 'Movies' do
    movie = create :movie
    visit '/admin/movies'

    expect(page).to have_content movie.title
  end
end
