class RecommendationsController < ApplicationController
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

  def like
    recommendation = Recommendation.find_by(id: params[:id])
    recommendation.update(liked: true)
    redirect_to '/recommendations'
  end

  def dislike
    recommendation = Recommendation.find_by(id: params[:id])
    recommendation.update(liked: false)
    redirect_to '/recommendations'
  end

  private

  def recommendation_params
  	params.require(:recommendation).permit(:from, :to, :song_id, :liked)
  end
end
