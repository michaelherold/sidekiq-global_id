# frozen_string_literal: true

require_relative "serialization"

module Sidekiq
  module GlobalID
    # A simple Sidekiq server middleware that deserializes GlobalIDs as positional arguments.
    class ServerMiddleware
      using Serialization

      # Deserializes all eligible positional arguments from GlobalIDs
      #
      # @api private
      #
      # @yieldparam _worker [String] - the class name of the worker performing the work
      # @yieldparam job [Array] - the job arguments
      # @yieldparam _queue [String] - the queue in which the job was enqueued
      #
      # @return [void]
      def call(_worker, job, _queue)
        job["args"].map!(&:deserialize)
        yield
      end
    end
  end
end
