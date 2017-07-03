class HomeController < ApplicationController
  before_action :retrieve_top_tracks, if: :user_signed_in?
  before_action :retrieve_friends, if: :user_signed_in?

  def index
    if user_signed_in?
      @recommendation = Recommendation.where('"from" = ? OR "to" = ?', current_user.id, current_user.id)
      render :index_user
    else
      render :index_guest
    end
  end

  private

  def retrieve_top_tracks
    @top_tracks = FindTopTracks.find_all(spotify_user)
  end

  def retrieve_friends
    friends = current_user.friends
    inverse_friends = current_user.inverse_friends

    @friends = friends.select { |f| f.in?(inverse_friends) }
    @incoming = inverse_friends.reject { |f| f.in?(friends) }
    @pending = friends.reject { |f| f.in?(inverse_friends) }
  end
end
