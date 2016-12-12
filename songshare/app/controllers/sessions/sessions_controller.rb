module Sessions
  class SessionsController < Devise::SessionsController
    def destroy
      super
      session[:spotify_user] = nil
    end
  end
end