require 'rails_helper'

RSpec.describe FindTopTracks do
  let(:user) { double('spotify_user') }

  let(:top_tracks) do
    tracks = JSON.parse(load_fixture('top_tracks.json'))
    tracks.map { |t| RSpotify::Track.new(t) }
  end

  describe '#find_all', vcr: { cassette_name: 'find_favorites-find_all', record: :new_episodes } do
    subject(:result) { described_class.find_all(user) }
    before(:each) { allow(user).to receive(:top_tracks).and_return(top_tracks) }

    context 'if tracks have yet to be loaded' do
      it 'adds the songs to the database' do
        expect { result }.to change { Song.count }
      end

      it 'adds the track albums to the database' do
        expect { result }.to change { Album.count }
      end

      it 'adds the track artists to the database' do
        expect { result }.to change { Artist.count }
      end
    end

    context 'if tracks have been loaded' do
      before(:each) { described_class.find_all(user) }

      it 'does not create songs' do
        expect { result }.not_to change { Song.count }
      end

      it 'does not create albums' do
        expect { result }.not_to change { Album.count }
      end

      it 'does not create artists' do
        expect { result }.not_to change { Artist.count }
      end
    end
  end
end
