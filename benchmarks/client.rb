# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(__dir__, "..", "lib"))

require "benchmark/ips"
require "fileutils"
require "sidekiq/global_id"

require_relative "../test/support/fakes"

tmp_dir = File.join(__dir__, "..", "tmp").tap(&FileUtils.method(:mkdir_p))
hold_file = File.join(tmp_dir, "client.jsonl")

# Enable the middleware on the second run
if File.exist?(hold_file)
  Sidekiq.client_middleware do |chain|
    chain.add Sidekiq::GlobalID::ClientMiddleware
  end
end

# A no-op worker for benchmarking the client middleware
class MyWorker
  include Sidekiq::Worker

  def perform(user_or_id); end
end

user = Fakes::User.new

Benchmark.ips do |bench|
  bench.report("without GlobalID") { MyWorker.perform_async(user.id) }
  bench.report("with GlobalID") { MyWorker.perform_async(user) }

  bench.compare!
  bench.hold!(hold_file)
end
