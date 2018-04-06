require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :wishes }

  specify 'locale' do
    user = create :user, language: 'en-UA'
    expect(user.reload.locale).to eq 'en'

    user = create :user, language: 'ru'
    expect(user.locale).to eq 'ru'

    user = create :user, language: 'ua-EN'
    expect(user.locale).to eq 'en'
  end
end
