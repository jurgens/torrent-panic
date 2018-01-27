require 'spec_helper'
require_relative '../../app/services/rutracker'

describe Rutracker do
  let(:rutracker) { Rutracker.new }

  context 'detect' do
    let(:keyword) { 'Blade Runner 2049' }

    specify 'with existing keyword' do
      expect(rutracker.detect(keyword)).to eq true
    end
  end

end