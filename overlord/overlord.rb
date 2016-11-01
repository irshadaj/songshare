# run `ruby overlord.rb` to run a webserver for this app
require 'sinatra/base'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    "Time to build an app around here. Start time: " + start_time
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  run! if app_file == $0
end
