require 'rails_helper'

describe Releases::Presenter do

  let(:release) { create :release, title: release_title, size: '1470' }

  context 'description' do
    let(:presenter) { Releases::Presenter.new release }
    let(:release_title) { 'title' }

    before { expect(release).to receive(:has_link?).and_return(false) }

    specify 'with translation, rip and size' do
      allow(presenter).to receive(:translation).and_return('MVO')
      allow(presenter).to receive(:rip_type).and_return('HDRip')
      allow(presenter).to receive(:size).and_return('1.4 GB')

      expect(presenter.description).to eq '1.4 GB - MVO, HDRip'
    end

    specify 'with rip and size' do
      allow(presenter).to receive(:translation).and_return('')
      allow(presenter).to receive(:rip_type).and_return('HDRip')
      allow(presenter).to receive(:size).and_return('1.4 GB')

      expect(presenter.description).to eq '1.4 GB - HDRip'
    end

    specify 'with size only' do
      allow(presenter).to receive(:translation).and_return('')
      allow(presenter).to receive(:rip_type).and_return('')
      allow(presenter).to receive(:size).and_return('1.4 GB')

      expect(presenter.description).to eq '1.4 GB'
    end
  end

  context 'with full details' do
    subject { described_class.new(release) }

    let(:release_title) { "Криминальное чтиво / Бульварное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, боевик, драма, криминал, BDRip-AVC] DUB + AVO (Гоблин) + Original + Subs" }

    specify 'translation' do
      expect(subject.translation).to eq 'DUB + AVO (Гоблин) + Original + Subs'
    end

    specify 'rip_type' do
      expect(subject.rip_type).to eq 'BDRip-AVC'
    end

    specify 'size' do
      expect(subject.size).to eq '1.44 GB'
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

  context 'with extended info' do
    let(:release_title) { "Властелин колец: Братство кольца / The Lord of the Rings: The Fellowship of the Ring (Питер Джексон / Peter Jackson) [2001, США, Новая Зеландия, фэнтези, боевик, приключения, BDRip-AVC] [Extended Edition] MVO (Позитив) + Original + Sub (Rus, Eng)" }

    specify 'translation' do
      expect(described_class.new(release).translation).to eq '[Extended Edition] MVO (Позитив) + Original + Sub (Rus, Eng)'
    end

    specify 'rip_type' do
      expect(described_class.new(release).rip_type).to eq 'BDRip-AVC'
    end
  end

  context 'with a link' do
    let(:release_title) { "Криминальное чтиво / Pulp Fiction (Квентин Тарантино / Quentin Tarantino) [1994, США, триллер, комедия, криминал, BDRip 1080p]" }
    let(:release) { create :release, title: release_title, size: '1470' }

    it 'should render a link around size' do
      expect(described_class.new(release).link_with_size).to eq "<a href=\"#{ENV['BOT_URL']}/releases/#{release.id}\">1.44 GB</a>"
    end
  end
end
