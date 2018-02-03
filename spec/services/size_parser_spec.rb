require 'rails_helper'

describe Rutracker::SizeParser do
  subject { Rutracker::SizeParser }

  specify 'it should parse GB numbers' do
    expect(subject.parse('0.1 GB')).to eq 100
    expect(subject.parse('1.11 GB')).to eq 1110
    expect(subject.parse('45.678 GB')).to eq 45678
  end

  specify 'it should parse MB numbers' do
    expect(subject.parse('1 MB')).to eq 1
    expect(subject.parse('10MB')).to eq 10
    expect(subject.parse('478 MB')).to eq 478
    expect(subject.parse('999  MB z')).to eq 999
  end
end
