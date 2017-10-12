class TopTracksController < ApplicationController
  before_action :retrieve_top_tracks, if: :user_signed_in?

  def index
    @top_tracks = FindTopTracks.find_all(spotify_user)
  end

  private

  def retrieve_top_tracks
    @top_tracks = FindTopTracks.find_all(spotify_user)
  end
end