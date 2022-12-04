# frozen_string_literal: true

require 'zeitwerk'
require 'rspec'
require 'active_support/all'

loader = Zeitwerk::Loader.new
loader.collapse('*')
loader.push_dir('app')
loader.setup

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
