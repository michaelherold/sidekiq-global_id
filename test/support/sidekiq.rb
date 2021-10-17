# frozen_string_literal: true

require "sidekiq"
require "sidekiq/testing"

Sidekiq.client_middleware do |chain|
  chain.add Sidekiq::GlobalID::ClientMiddleware
end

Sidekiq.server_middleware do |chain|
  chain.add Sidekiq::GlobalID::ServerMiddleware
end

Sidekiq::Testing.fake!
