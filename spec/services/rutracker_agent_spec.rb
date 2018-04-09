require 'rails_helper'

RSpec.describe Rutracker::Agent, type: :model do

  describe '#search', :vcr do

    let(:keyword) { 'The Matrix' }
    let(:agent) { described_class.new('u', 'p') }

    before do
      allow(agent).to receive(:login)
      allow_any_instance_of(Mechanize).to receive_message_chain('page.search')
    end

    subject do
      agent.search(keyword)
    end

    it 'should call search only in Movie category' do
      expect_any_instance_of(Mechanize).to receive(:get)
      subject
    end
  end
end
