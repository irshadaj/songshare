class AddCommentsToRecommendations < ActiveRecord::Migration[5.0]
  def change
    add_column :recommendations, :comments, :string
  end
end
