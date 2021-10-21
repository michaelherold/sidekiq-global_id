# frozen_string_literal: true

require "sidekiq"

require_relative "global_id/client_middleware"
require_relative "global_id/server_middleware"
require_relative "global_id/version"

module Sidekiq # :nodoc:
  # A gem for adding transparent GlobalID serialization to Sidekiq
  #
  # @example Using the serialization middleware
  #
  #   require "sidekiq/global_id"
  #
  #   Sidekiq.client_middleware do |chain|
  #     chain.add Sidekiq::GlobalID::ClientMiddleware
  #   end
  #
  #   Sidekiq.server_middleware do |chain|
  #     chain.add Sidekiq::GlobalID::ServerMiddleware
  #   end
  #
  #   class MyWorker
  #     include Sidekiq::Worker
  #
  #     def perform(user)
  #       raise ArgumentError if user.is_a?(User)
  #     end
  #   end
  #
  #   user = User.create!
  #   MyWorker.perform_async(user)
  #
  #   job = MyWorker.jobs.last
  #   job["args"] == [String(user.to_global_id)] #=> true
  module GlobalID
  end
end
