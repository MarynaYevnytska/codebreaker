# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  minimum_coverage 95
end

require 'bundler/setup'
require 'codebreaker'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  #config.include Aruba::Api
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
