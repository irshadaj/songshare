namespace :db do
  namespace :spotify do
    desc 'Clears the database of all Spotify data'
    task clear: :environment do
      ActiveRecord::Base.transaction do
        puts 'Clearing join tables...'
        ActiveRecord::Base.connection.execute('DELETE FROM albums_artists; DELETE FROM artists_songs;')

        puts "Deleting #{Artist.count} artists..."
        Artist.delete_all

        puts "Deleting #{Song.count} songs..."
        Song.delete_all

        puts "Deleting #{Album.count} albums..."
        Album.delete_all

        puts 'Done.'
      end
    end
  end
end
