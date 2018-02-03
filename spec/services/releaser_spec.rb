require 'rails_helper'

describe Releaser do
  let(:movie)   { create :movie, title: 'Blade Runner 2049' }
  let(:release) { create :release, movie: movie }
  let(:wish)    { create :wish, movie: movie }

  before do
    expect(Movies::FindReleases).to receive_message_chain(:new, :call)
  end

  context 'call' do
    context 'when there are releases' do
      before { wish; release }

      specify 'should trigger notifications' do
        expect(Notifier).to receive_message_chain(:new, :process)
        Releaser.new(movie).process
      end

      specify 'should fulfill a wish' do
        expect { Releaser.new(movie).process }.to change{ wish.reload.notified_at }.from(nil)
      end
    end
  end
end
