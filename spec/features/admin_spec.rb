require 'rails_helper'

describe 'Admin Area' do
  before { basic_auth 'admin', 'password' }

  specify 'dashboard' do
    visit '/admin/'

    within 'h1' do
      expect(page).to have_content 'Dashboard'
    end
  end
end
