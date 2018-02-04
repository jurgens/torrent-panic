require 'rails_helper'

describe Size do
  context 'parse' do
    it 'should parse GB numbers' do
      expect(Size.parse('0.1 GB')).to eq 102
      expect(Size.parse('1.11 GB')).to eq 1137
      expect(Size.parse('45.678 GB')).to eq 46774
    end

    it 'should parse MB numbers' do
      expect(Size.parse('1 MB')).to eq 1
      expect(Size.parse('10MB')).to eq 10
      expect(Size.parse('478 MB')).to eq 478
      expect(Size.parse('999  MB z')).to eq 999
    end
  end

  context 'print' do
    it 'should print numbers' do
      expect(Size.print(1)).to eq '1 MB'
      expect(Size.print(20)).to eq '20 MB'
      expect(Size.print(300)).to eq '300 MB'
      expect(Size.print(4567)).to eq '4.46 GB'
    end
  end
end
