# frozen_string_literal: true

require_relative "lib/sidekiq/global_id/version"

Gem::Specification.new do |spec|
  spec.name    = "sidekiq-global_id"
  spec.version = Sidekiq::GlobalID::VERSION
  spec.authors = ["Michael Herold"]
  spec.email   = ["opensource@michaeljherold.com"]

  spec.summary     = "Sidekiq middleware for serializing via GlobalID"
  spec.description = spec.summary
  spec.homepage    = "https://github.com/michaelherold/sidekiq-global_id"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/michaelherold/sidekiq-global_id"
  spec.metadata["changelog_uri"] = "https://github.com/michaelherold/sidekiq-global_id"

  spec.files = %w[CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md]
  spec.files += %w[sidekiq-global_id.gemspec]
  spec.files += Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]
end
