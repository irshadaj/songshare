#!/usr/bin/env ruby

require 'sinatra/base'
require_relative 'lib/safe'
require_relative 'lib/safe_presenter'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    haml :index, locals: { safe: safe_presenter, safe_error: nil }
  end

  get '/new' do
    build_safe
    persist_safe
    redirect to('/')
  end

  post '/lock' do
    redirect to('/') unless safe
    error = nil

    begin
      safe.lock(combination)
    rescue ArgumentError, IncorrectStateError => e
      error = e.message
    end

    persist_safe
    haml :index, locals: { safe: safe_presenter, safe_error: error }
  end

  post '/unlock' do
    redirect to('/') unless safe
    error = nil

    begin
      error = "Invalid code (#{safe.remaining_attempts} attempts remaining)" unless safe.unlock(combination)
    rescue ArgumentError, IncorrectStateError => e
      error = e.message
    end

    persist_safe
    haml :index, locals: { safe: safe_presenter, safe_error: error }
  end

  private

  def build_safe
    @safe = Safe.new
  end

  def combination
    return params[:combination] if params[:combination] && !params[:combination].empty?
  end

  def safe
    @safe ||= session[:safe]
  end

  def safe_presenter
    return unless safe
    SafePresenter.new(safe)
  end

  def persist_safe
    session[:safe] = @safe
  end

  run! if app_file == $PROGRAM_NAME
end
