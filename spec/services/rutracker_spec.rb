require 'rails_helper'

describe Rutracker do
  let(:rutracker) { described_class.new(dummy_agent) }

  let(:dummy_agent) { double(:agent) }

  context 'detect' do
    let(:keyword) { 'Blade Runner 2049' }

    let(:fake_html) do
      file_fixture('search_results.html').read

    end

    before do
      expect(dummy_agent).to receive(:search).with(keyword).and_return(
                Nokogiri::HTML(fake_html.force_encoding("cp1251").encode("utf-8", undef: :replace))
      )
    end

    subject do
      rutracker.search(keyword)
    end

    context 'when RuTracker return good response' do

      it 'returns proper structure of "releases"' do
        expect(subject.count).to eq(35)
        expect(subject.first).to have_attributes(
          title: 'Бегущий по лезвию 2049 / Blade Runner 2049 (Дени Вильнёв / Denis Villeneuve) [2017, США, фантастика, триллер, драма, детектив, DTS-HD MA] Dub',
          status: :not_approved,
          seeds: '7',
          link: 'https://rutracker.org/forum/viewtopic.php?t=5512328'
        )
      end
    end

    context 'when RuTracker return empty result' do
      let(:fake_html) do
        file_fixture('empty_search_results.html').read
      end

      it 'return empty array' do
        expect(subject.count).to eq(0)
      end
    end
  end

end
