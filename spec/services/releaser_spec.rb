require 'rails_helper'

describe Releaser do
  let(:movie) { create :movie, title: 'Blade Runner 2049' }
  let(:tracker) { double :tracker }
  let(:releases) do
    [
        Rutracker::Item.new({
            title: 'Blade Runner 2049 version 1',
            link: 'http://rutracker.com/page1',
            seeds: 10,
            status: :not_approved
        }),
        Rutracker::Item.new({
            title: 'Blade Runner 2049 version 2',
            link: 'http://rutracker.com/page2',
            seeds: 2,
            status: :not_approved
        })
    ]
  end

  before do
    expect_any_instance_of(Releaser).to receive(:tracker).and_return(tracker)
  end

  context 'process' do
    context 'with results' do
      before { expect(tracker).to receive(:search).with('Blade Runner 2049').and_return(releases) }

      specify 'should store releases' do
        expect { Releaser.new(movie).process }.to change(Release, :count).to(2)
      end

      specify 'should trigger notifications' do
        wish = create :wish, movie: movie
        expect(Notifier).to receive_message_chain(:new, :process)
        Releaser.new(movie).process
      end

      specify 'should update movie.crawled_at' do
        expect { Releaser.new(movie).process }.to change { movie.crawled_at }
      end

      specify 'should fulfill a wish' do
        create :release, movie: movie
        wish = create :wish, movie: movie

        expect { Releaser.new(movie).process }.to change{ wish.reload.notified_at }.from(nil)
      end
    end

    context 'with no results' do
      before { expect(tracker).to receive(:search).with('Blade Runner 2049').and_return([]) }

      specify 'with empty results should not create releases' do
        expect { Releaser.new(movie).process }.not_to change(Release, :count)
      end

      specify 'with empty results should not change movie.crawled_at' do
        expect { Releaser.new(movie).process }.not_to change { movie.crawled_at }
      end
    end
  end
end
