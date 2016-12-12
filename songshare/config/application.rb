require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Songshare
  class Application < Rails::Application
    config.autoload_paths += %w(app/decorators app/interactors)

    config.generators do |g|
      g.template_engine nil
      g.test_framework :rspec, controller_specs: false, view_specs: false
      g.assets false
      g.helper false
      g.stylesheets false
    end
  end
end
