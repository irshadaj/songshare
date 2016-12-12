require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:song) { build_stubbed(:song) }

  describe '#external_id' do
    it 'is required' do
      song.external_id = nil
      expect(song).not_to be_valid
    end
  end

  describe '#title' do
    it 'is required' do
      song.title = nil
      expect(song).not_to be_valid
    end
  end

  describe '#uri' do
    it 'is of the format "spotify:track:<external_id>"' do
      expect(song.uri).to eq("spotify:track:#{song.external_id}")
    end
  end

  describe '.create_from_spotify_track' do
    let(:spotify_track) { build(:spotify_track) }
    subject(:song) { described_class.create_from_spotify_track(spotify_track) }

    it { is_expected.to be_a(Song) }

    context 'when the song does not yet exist' do
      it 'has been persisted' do
        expect(song.id).to be > 0
      end

      it 'maps the ID from the Spotify track to the external ID field' do
        expect(song.external_id).to eq(spotify_track.id)
      end

      it 'maps the title from the Spotify track' do
        expect(song.title).to eq(spotify_track.name)
      end

      it 'maps the duration from the Spotify track' do
        expect(song.duration).to eq(spotify_track.duration_ms)
      end

      it 'maps disc/track number and explicit status from the Spotify track' do
        %i(disc_number track_number explicit).each do |attr|
          expect(song.send(attr)).to eq(spotify_track.send(attr))
        end
      end
    end

    context 'when a song already exists with the given external ID' do
      let(:existing_song) { described_class.create_from_spotify_track!(spotify_track) }
      before(:each) { existing_song }

      it 'has not been saved' do
        expect(song.id).to be_nil
      end
    end
  end

  describe '.create_from_spotify_track!' do
    let(:spotify_track) { build(:spotify_track) }
    subject(:song) { described_class.create_from_spotify_track!(spotify_track) }

    it { is_expected.to be_a(Song) }

    context 'when the song does not yet exist' do
      it 'maps the ID from the Spotify track to the external ID field' do
        expect(song.external_id).to eq(spotify_track.id)
      end

      it 'maps the title from the Spotify track' do
        expect(song.title).to eq(spotify_track.name)
      end

      it 'maps the duration from the Spotify track' do
        expect(song.duration).to eq(spotify_track.duration_ms)
      end

      it 'maps disc/track number and explicit status from the Spotify track' do
        %i(disc_number track_number explicit).each do |attr|
          expect(song.send(attr)).to eq(spotify_track.send(attr))
        end
      end
    end

    context 'when a song already exists with the given external ID' do
      let(:existing_song) { described_class.create_from_spotify_track!(spotify_track) }
      before(:each) { existing_song }

      it 'raises a validation error' do
        expect { song }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
