require 'rails_helper'

RSpec.describe Rutracker::Agent, type: :model do

  describe '#search' do

    let(:keyword) { 'The Matrix' }
    let(:agent) { described_class.new('u', 'p') }

    before do
      allow(agent).to receive(:login)
      allow_any_instance_of(Mechanize).to receive_message_chain('page.search')
    end

    let(:expected_searh_url) do
      "https://rutracker.org/forum/tracker.php?f=124,2198,22,33,352,4,7,921,93&nm=#{keyword}"
    end

    subject do
      agent.search(keyword)
    end

    it 'should call search only in Movie category' do
      expect_any_instance_of(Mechanize).to receive(:get).with(expected_searh_url)
      subject
    end

  end

end
