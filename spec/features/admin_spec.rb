require 'rails_helper'

describe 'Admin Area' do
  before { basic_auth 'admin', 'password' }

  specify 'dashboard' do
    visit '/admin/'

    within 'dl' do
      expect(page).to have_content 'Users'
      expect(page).to have_content 'Movies'
    end
  end
end
