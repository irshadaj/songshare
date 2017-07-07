class SongsController < ApplicationController
  def search
    @songs = SearchSongs.search(query, page: page)
  end

  def show
    @song = Song.find(params[:id])
    @recommendation = Recommendation.new(params.permit(:from, :to, :song_id, :liked))
  end

  private

  def query
    @query ||= params[:q]
  end

  def page
    @page ||= params[:page].try(:to_i) || 1
  end
end
