require 'rails_helper'

describe Broadcast do
  let(:user) { create :user, first_name: 'Jurgen' }

  specify '#personalized_message' do
    expect(Broadcast.personalized_message(user, "Hello, %first_name%.")).to eq 'Hello, Jurgen.'
  end

  specify '#personalized_message with no placeholders' do
    expect(Broadcast.personalized_message(user, "Hello, bro")).to eq 'Hello, bro'
  end
end
