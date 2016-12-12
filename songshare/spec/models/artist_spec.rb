require 'rails_helper'

RSpec.describe Artist, type: :model do
  let(:artist) { build_stubbed(:artist) }

  describe '#external_id' do
    it 'is required' do
      artist.external_id = nil
      expect(artist).not_to be_valid
    end
  end

  describe '#name' do
    it 'is required' do
      artist.name = nil
      expect(artist).not_to be_valid
    end
  end

  describe '.from_spotify_artist' do
    let(:spotify_params) { Hash.new }

    let(:spotify_artist) do
      build(:spotify_artist, spotify_params).tap do |a|
        allow(a).to receive(:albums).and_return([])
      end
    end

    subject(:artist) { described_class.from_spotify_artist(spotify_artist) }

    it { is_expected.to be_a(Artist) }

    context 'when the artist does not yet exist' do
      it 'maps the ID from the Spotify artist to the external ID field' do
        expect(artist.external_id).to eq(spotify_artist.id)
      end

      it 'maps the name and genres from the Spotify artist' do
        %i(name genres).each do |attr|
          expect(artist.send(attr)).to eq(spotify_artist.send(attr))
        end
      end
    end

    context 'when an artist already exists with the given external ID' do
      let(:existing_artist) { described_class.from_spotify_artist(spotify_artist) }
      before(:each) { existing_artist }

      it 'pulls that artist' do
        expect(artist).to eq(existing_artist)
      end
    end
  end
end
