# frozen_string_literal: true

require_relative "../lib/packwizard_parser/"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Exclude integration testing and runtime benchmarks as default
  config.filter_run_excluding :integration
  config.filter_run_excluding :benchmark unless ENV["RUN_BENCHMARKS"] == "1"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
