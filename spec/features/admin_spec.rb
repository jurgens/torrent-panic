require 'rails_helper'

describe 'Admin Area' do
  before { basic_auth 'admin', 'password' }

  specify 'dashboard' do
    visit '/admin/'
    expect(page).to have_content 'Welcome, Admin'
  end
end
