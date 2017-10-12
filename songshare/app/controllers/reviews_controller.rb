class ReviewsController < ApplicationController
  def create
    @recommendation = Recommendation.new(recommendation_params.merge(from: current_user.id))
    @song = Song.find(recommendation_params[:song_id])
    if @recommendation.save
        redirect_to recommendations_path
    else
        logger.error(@recommendation.errors.inspect)
        flash.now[:alert] = "Could not recommend song"
        render '/songs/show'
    end
  end
      
  def index
    @recommendations = Recommendation.where('"from" = ? OR "to" = ?', current_user.id, current_user.id)
  end
end
