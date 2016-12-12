require 'factory_girl'
require 'simplecov'
require_relative 'support/spec_helper_methods'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include(FactoryGirl::Syntax::Methods)
  config.include(SpecHelperMethods)
end
