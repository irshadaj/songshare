class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    redirect_to user_spotify_omniauth_authorize_path unless user_signed_in?
  end

  def new_session_path(_scope)
    new_user_session_path
  end

  def spotify_user
    @spotify_user ||= build_spotify_user
  end

  private

  def build_spotify_user
    attrs = session[:spotify_user]
    return nil unless attrs

    RSpotify::User.new(attrs)
  end
end
