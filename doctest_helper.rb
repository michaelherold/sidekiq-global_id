# frozen_string_literal: true

if ENV["COVERAGE"] || ENV["CI"]
  require "simplecov"

  SimpleCov.start do
    add_filter "/test/"
  end

  SimpleCov.command_name "yard-doctest"

  YARD::Doctest.after_run do
    SimpleCov.set_exit_exception
    SimpleCov.run_exit_tasks!
  end
end

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

require "sidekiq/global_id"
