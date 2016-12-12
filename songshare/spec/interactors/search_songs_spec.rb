require 'rails_helper'

RSpec.describe SearchSongs do
  let(:search_query) { 'The Greatest Show On Earth' }
  let(:search_results) { load_fixture('track_search.json') }

  describe '.search', vcr: { cassette_name: 'search_songs-search', record: :new_episodes } do
    subject(:result) { described_class.search(search_query) }

    it 'is paginated' do
      expect(result.current_page).to eq(1)
    end

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
      before(:each) { described_class.search(search_query) }

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
