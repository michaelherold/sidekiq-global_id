# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "yard", "~> 0.9"
  gem "yardstick", "~> 0.9"

  group :test do
    gem "activerecord", require: false
    gem "activerecord-jdbcsqlite3-adapter", platforms: %i[jruby], require: false
    gem "minitest", "~> 5.0"
    gem "pry"
    gem "railties", require: false
    gem "rake", "~> 13.0"
    gem "simplecov", "~> 0.21"
    gem "sqlite3", platforms: %i[mri mingw x64_mingw], require: false

    group :linting do
      gem "yard-doctest", "~> 0.1"
    end
  end

  group :benchmarking do
    gem "benchmark-ips"
  end

  group :linting do
    gem "inch", "~> 0.8.0"
    gem "rubocop", "~> 1.7"
    gem "rubocop-minitest", "~> 0.15.2"
    gem "rubocop-rake", "~> 0.6.0"
  end
end
