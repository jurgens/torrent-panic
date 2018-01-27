require 'rails_helper'

describe Notifier do
  let(:movie) { create :movie }
  let!(:release) { create :release, movie: movie }
  let!(:wish) { create :wish, movie: movie }

  specify 'notify' do
    expect { Notifier.new(movie).process }.to change{ wish.reload.notified_at }.from(nil)
  end
end
