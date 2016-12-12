module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def spotify
      @user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in(@user, event: :authentication)
      create_spotify_user(request.env['omniauth.auth'])

      set_spotify_success_message if is_navigational_format?
      redirect_to root_path
    end

    def failure
      set_spotify_failure_message if is_navigational_format?
      redirect_to root_path
    end

    private

    def create_spotify_user(auth)
      @spotify_user = RSpotify::User.new(auth)
      save_spotify_user
    end

    def save_spotify_user
      session[:spotify_user] = @spotify_user.to_hash
    end

    def set_spotify_failure_message
      message = request.env['omniauth.error.type'].to_s
      message = message.humanize(capitalize: false)
      set_flash_message(:alert, :failure, kind: 'Spotify', reason: message)
    end

    def set_spotify_success_message
      set_flash_message(:notice, :success, kind: 'Spotify')
    end
  end
end
