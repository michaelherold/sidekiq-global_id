# frozen_string_literal: true

if ENV["COVERAGE"] || ENV["CI"]
  require "simplecov"

  SimpleCov.start do
    add_filter "/test/"
  end

  SimpleCov.command_name ENV.fetch("SUITE", "minitest")
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

begin
  require "pry"
rescue LoadError # rubocop:disable Lint/SuppressedException
end

require "sidekiq/global_id"

require_relative "support/assertions"
require_relative "support/fakes"
require_relative "support/sidekiq"

require "minitest/autorun"
