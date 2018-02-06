require 'rails_helper'

describe Rutracker do
  let(:rutracker)   { described_class.new(dummy_agent) }
  let(:dummy_agent) { double(:agent) }
  let(:content)     { Nokogiri::HTML(html.force_encoding("cp1251").encode("utf-8", undef: :replace)) }

  context 'detect' do
    let(:keyword) { 'Blade Runner 2049' }

    let(:html) { file_fixture('search_results.html').read }

    before do
      expect(dummy_agent).to receive(:search).with(keyword).and_return(content)
    end

    subject do
      rutracker.search(keyword)
    end

    context 'when RuTracker return good response' do
      it 'returns proper structure of "releases"' do
        expect(subject.count).to eq(5)
        expect(subject.first).to have_attributes(
          topic_id: 5512328,
          title: 'Бегущий по лезвию 2049 / Blade Runner 2049 (Дени Вильнёв / Denis Villeneuve) [2017, США, фантастика, триллер, драма, детектив, DTS-HD MA] Dub',
          status: :not_approved,
          seeds: 7,
          link: 'https://rutracker.org/forum/viewtopic.php?t=5512328',
          size: 4936,
          downloads: 36
        )
      end
    end

    context 'when RuTracker return empty result' do
      let(:html) do
        file_fixture('empty_search_results.html').read
      end

      it 'return empty array' do
        expect(subject.count).to eq(0)
      end
    end
  end

  context 'topic page' do
    let(:html) { file_fixture('topic.html').read }
    let(:topic_id) { 5512328 }

    before { expect(dummy_agent).to receive(:topic).with(5512328).and_return(content) }

    subject { rutracker.topic_data(topic_id) }

    specify 'should return topic page' do
      expect(subject.keys).to include :magnet
      expect(subject[:magnet]).to match /^magnet\:/
    end
  end
end
