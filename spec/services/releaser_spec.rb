require 'rails_helper'

describe Releaser do
  let(:movie)   { create :movie, title: 'Blade Runner 2049' }
  let(:release) { create :release, movie: movie }
  let(:wish)    { create :wish, movie: movie }

  context 'check' do

    context 'when there are releases' do
      before do
        expect(Releases::Finder).to receive_message_chain(:new, :call)
      end

      before { wish; release }

      specify 'should trigger notifications' do
        expect(Notifier).to receive_message_chain(:new, :process)
        Releaser.check(movie)
      end

      specify 'should fulfill a wish' do
        expect { Releaser.check(movie) }.to change{ wish.reload.notified_at }.from(nil)
      end
    end
  end

  context 'pending' do
    before { wish; release }

    specify 'pending' do
      another_movie = create :movie
      create :wish, movie: another_movie, notified_at: 1.day.ago

      expect(Releaser.pending_movies).to include(movie)
      expect(Releaser.pending_movies).to_not include(another_movie)
    end
  end
end
