require 'rails_helper'

describe Releases::Finder do
  let(:movie) { create :movie, title: 'Blade Runner 2049', year: 2017 }
  let(:tracker) { double :tracker }
  let(:releases) do
    [
        Rutracker::Item.new({
                                title: 'Blade Runner 2049 version 1',
                                link: 'page1',
                                seeds: 10,
                                status: 'not_approved',
                                size: 99,
                                downloads: 50,
                                topic_id: 1
                            }),
        Rutracker::Item.new({
                                title: 'Blade Runner 2049 version 2',
                                link: 'page2',
                                seeds: 2,
                                status: 'not_approved',
                                size: 99,
                                downloads: 50,
                                topic_id: 2
                            })
    ]
  end

  before do
    expect_any_instance_of(described_class).to receive(:tracker).twice.and_return(tracker)
  end

  context 'process' do
    subject { described_class.new(movie).call }

    context 'with results' do
      before do
        allow(tracker).to receive(:search).with('Blade Runner 2049 2017').and_return(releases)
        allow(tracker).to receive(:search).with('Blade Runner 2049 2016').and_return(releases)
      end

      specify 'should store releases', :skip do
        expect { subject }.to change(Release, :count).to(2)
      end

      specify 'should update movie.crawled_at', :skip do
        expect { subject }.to change { movie.crawled_at }
      end

      specify 'should create release with all right attributes', :skip do
        subject

        release = Release.last
        expect(release.title).to eq 'Blade Runner 2049 version 2'
        expect(release.link).to eq 'https://rutracker.org/forum/page2'
        expect(release.seeds).to eq 2
        expect(release.status).to eq 'not_approved'
        expect(release.size).to eq 99
        expect(release.downloads).to eq 50
      end
    end

    context 'with no results' do
      before do
        expect(tracker).to receive(:search).with('Blade Runner 2049 2016').and_return([])
        expect(tracker).to receive(:search).with('Blade Runner 2049 2017').and_return([])
      end

      it 'should not create releases' do
        expect { subject }.not_to change(Release, :count)
      end

      it 'should not change movie.crawled_at' do
        expect { subject }.not_to change { movie.crawled_at }
      end
    end
  end
end
