class RecommendationsIndex < ActiveRecord::Migration[5.0]
  def change
  	remove_index(:recommendations, :name => 'index_recommendations_on_to_and_from')
  	add_index :recommendations, [:to, :from, :song_id], :unique => true
  end
end
