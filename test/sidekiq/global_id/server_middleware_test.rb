# frozen_string_literal: true

require "test_helper"

module Sidekiq
  module GlobalID
    class ServerMiddlewareTest < Minitest::Test
      def setup
        @user = Fakes::User.new
        @middleware = ServerMiddleware.new
      end

      attr_reader :middleware
      attr_reader :user

      def test_deserializing_positional_arguments
        job = { "args" => [String(user.to_gid)] }

        call_middleware job

        assert_equal user, job["args"].first
      end

      def test_deserializing_global_id_arrays
        job = { "args" => [[String(user.to_gid), String(user.to_gid)]] }

        call_middleware job

        assert_equal [user, user], job["args"].first
      end

      def test_no_change_to_integers
        job = { "args" => [1] }

        call_middleware job

        assert_equal [1], job["args"]
      end

      def test_no_change_to_normal_strings
        job = { "args" => [String(user.to_gid), "Bilbo Baggins"] }

        call_middleware job

        assert_equal user, job["args"][0]
        assert_equal "Bilbo Baggins", job["args"][1]
      end

      def test_serializing_options_hashes
        gid = String(user.to_gid)
        job = { "args" => [gid, "Bilbo Baggins", { "user" => gid, gid => "1" }] }

        call_middleware job
        reloaded_user, _name, opts = job["args"]

        assert_equal user, reloaded_user
        assert user, opts.fetch("user")
        assert opts.key?(user)
      end

      def call_middleware(job)
        middleware.call("MyWorker", job, "default", &-> {})
      end
    end
  end
end
