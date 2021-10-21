# frozen_string_literal: true

if ENV["COVERAGE"] || ENV["CI"]
  require "simplecov"

  SimpleCov.start do
    add_filter "/test/"
  end

  SimpleCov.command_name "yard-doctest"
end

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

require "sidekiq/global_id"

require_relative "test/support/assertions"
require_relative "test/support/fakes"
require_relative "test/support/sidekiq"

User = Fakes::User

User.new
