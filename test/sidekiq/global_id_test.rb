# frozen_string_literal: true

require "test_helper"

module Sidekiq
  class GlobalIDTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Sidekiq::GlobalID::VERSION
    end
  end
end
