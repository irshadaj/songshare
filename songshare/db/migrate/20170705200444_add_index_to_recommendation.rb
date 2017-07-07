class AddIndexToRecommendation < ActiveRecord::Migration[5.0]
  def change
  	add_index :recommendations, [:to, :from], :unique => true
  end
end
