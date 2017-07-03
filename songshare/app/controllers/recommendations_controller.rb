class RecommendationsController < ApplicationController
  def create
  	Recommendation.create(recommendation_params.merge(from: current_user.id))
  	redirect_to '/recommendations'
  end

  def list
    @recommendation = Recommendation.where('"from" = ? OR "to" = ?', current_user.id, current_user.id)
    @current_user = current_user
  end

  def like
    recommendation = Recommendation.find_by(id: params[:id])
    recommendation.update(liked: true)
    redirect_to '/recommendations'
  end

  private

  def recommendation_params
  	params.permit(:from, :to, :song_id, :liked)
  end
end
