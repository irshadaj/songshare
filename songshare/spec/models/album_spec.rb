require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:album) { build_stubbed(:album) }

  describe '#external_id' do
    it 'is required' do
      album.external_id = nil
      expect(album).not_to be_valid
    end
  end

  describe '#name' do
    it 'is required' do
      album.name = nil
      expect(album).not_to be_valid
    end
  end

  describe '.from_spotify_album' do
    let(:spotify_params) { Hash.new }
    let(:spotify_album) { build(:spotify_album, spotify_params) }
    subject(:album) { described_class.from_spotify_album(spotify_album) }

    it { is_expected.to be_a(Album) }

    context 'when the album does not yet exist' do
      it 'maps the ID from the Spotify album to the external ID field' do
        expect(album.external_id).to eq(spotify_album.id)
      end

      it 'maps the name, genres and album type from the Spotify album' do
        %i(name genres album_type).each do |attr|
          expect(album.send(attr)).to eq(spotify_album.send(attr))
        end
      end

      it 'sets the year to the release date year' do
        spotify_params[:release_date] = '2016-05-10'
        spotify_params[:release_date_precision] = 'day'

        expect(album.year).to eq(2016)
      end
    end

    context 'when an album already exists with the given external ID' do
      let(:existing_album) { described_class.from_spotify_album(spotify_album) }
      before(:each) { existing_album }

      it 'pulls that album' do
        expect(album).to eq(existing_album)
      end
    end
  end
end
