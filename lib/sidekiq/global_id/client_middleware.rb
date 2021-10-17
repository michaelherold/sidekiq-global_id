# frozen_string_literal: true

require_relative "serialization"

module Sidekiq
  module GlobalID
    # A simple Sidekiq client middleware that serializes arguments as GlobalIDs
    class ClientMiddleware
      using Serialization

      # Serializes all eligible positional arguments as GlobalIDs
      #
      # @api private
      #
      # @yieldparam _worker [String] - the class name of the worker performing the work
      # @yieldparam job [Array] - the job arguments
      # @yieldparam _queue [String] - the queue in which the job was enqueued
      # @yieldparam _pool [ConnectionPool<Redis::Client>] - the pool of Redis connections
      #
      # @return [void]
      def call(_worker, job, _queue, _pool)
        job["args"].map!(&:serialize)
        yield
      end
    end
  end
end
