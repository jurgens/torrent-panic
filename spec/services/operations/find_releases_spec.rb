require 'rails_helper'

describe Operations::FindReleases do
  let(:user) { create :user }
  let(:movie) { create :movie }
  let(:search) { create :search, user: user }

  subject { described_class.new(movie: movie, search: search).process }

  context 'when no releases found' do
    before do
      allow(Releases::Finder).to receive_message_chain(:new, :call)
    end

    specify 'it should add a movie to user wish list' do
      expect { subject }.to change(Wish, :count).by(1)
      expect(user.wishes.length).to eq 1
    end

    specify 'and only once' do
      subject
      subject
      expect(user.wishes.reload.length).to eq 1
    end
  end
end
