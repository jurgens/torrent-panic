require 'rails_helper'

describe Releases::Presenter do

  let(:release) { build :release, title: release_title, size: '1470' }

  context 'description' do
    let(:presenter) { Releases::Presenter.new nil }
    let(:release_title) { 'title' }

    specify 'with translation, rip and size' do
      expect(presenter).to receive(:translation).and_return('MVO')
      expect(presenter).to receive(:rip_type).and_return('HDRip')
      expect(presenter).to receive(:size).and_return('1.4 GB')

      expect(presenter.description).to eq 'MVO, HDRip - 1.4 GB'
    end
  end

  context 'with full details' do
    let(:release_title) { "Криминальное чтиво / Бульварное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, боевик, драма, криминал, BDRip-AVC] DUB + AVO (Гоблин) + Original + Subs" }

    specify 'translation' do
      expect(described_class.new(release).translation).to eq 'DUB + AVO (Гоблин) + Original + Subs'
    end

    specify 'rip_type' do
      expect(described_class.new(release).rip_type).to eq 'BDRip-AVC'
    end

    specify 'size' do
      expect(described_class.new(release).size).to eq '1.44 GB'
    end
  end

  context 'with full details 2' do
    let(:release_title) { "Криминальное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, триллер, криминал, BDRip] 3хMVO (West Video R5 / НТВ / Премьер Видео) + 3хAVO (А. Гаврилов / Д. Гоблин Пучков / Ю. Живов)" }

    specify 'translation' do
      expect(described_class.new(release).translation).to eq '3хMVO (West Video R5 / НТВ / Премьер Видео) + 3хAVO (А. Гаврилов / Д. Гоблин Пучков / Ю. Живов)'
    end

    specify 'rip_type' do
      expect(described_class.new(release).rip_type).to eq 'BDRip'
    end
  end

  context 'with less details' do
    let(:release_title) { "Криминальное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, криминальная драма, HDRip] Dub" }

    specify 'translation' do
      expect(described_class.new(release).translation).to eq 'Dub'
    end

    specify 'rip_type' do
      expect(described_class.new(release).rip_type).to eq 'HDRip'
    end
  end

  context 'with HD release' do
    let(:release_title) { "Криминальное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, триллер, комедия, криминал, BDRip 1080p]" }

    specify 'translation' do
      expect(described_class.new(release).translation).to eq ''
    end

    specify 'rip_type' do
      expect(described_class.new(release).rip_type).to eq 'BDRip 1080p'
    end
  end

end
