# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path(Pathname.new(__dir__) / ".."))

# Must be loaded before test_helper so ActiveRecord::Relation exists
ENV["RAILS_ENV"] = "test"

require "rails"
require "active_record"

require "test_helper"

# In a Rails app, this is done by global_id/railtie but we don't have that luxury
ActiveRecord::Base.include(GlobalID::Identification)

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)
ActiveRecord::Base.logger = Logger.new(IO::NULL)
ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  # rubocop:disable Lint/EmptyBlock
  create_table :posts, force: true do |table|
  end
  # rubocop:enable Lint/EmptyBlock
end

class Post < ActiveRecord::Base
end

module Sidekiq
  module GlobalID
    class ActiveRecordIntegrationTest < Minitest::Test
      include Assertions

      class TestWorker
        include Sidekiq::Worker

        def perform(_users); end
      end

      def setup
        @middleware = ServerMiddleware.new
      end

      attr_reader :middleware
      attr_reader :user

      def test_serializing_relations
        2.times { Post.create! }
        posts = Post.all
        enqueue(posts)

        job = TestWorker.jobs.first
        reloaded_posts = job["args"].first

        assert_equal posts.map { |post| String(post.to_global_id) }, reloaded_posts
      end

      def test_deserializing_relations
        2.times { Post.create! }
        post_gids = Post.all.map { |post| String(post.to_global_id) }
        job = { "args" => [post_gids] }

        call_middleware job

        assert_equal Post.all, job["args"].first
      end

      private

      def call_middleware(job)
        middleware.call("MyWorker", job, "default", &-> {})
      end

      def enqueue(users)
        assert_change -> { TestWorker.jobs.size }, from: 0, to: 1 do
          TestWorker.perform_async(users)
        end
      end
    end
  end
end
