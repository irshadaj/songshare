class SongsController < ApplicationController
  def search
    @songs = SearchSongs.search(query, page: page)
  end

  def show
    @song = Song.find(params[:id])
  end

  private

  def query
    @query ||= params[:q]
  end

  def page
    @page ||= params[:page].try(:to_i) || 1
  end
end
