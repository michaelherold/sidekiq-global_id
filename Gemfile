# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "yard", "~> 0.9"
  gem "yardstick", "~> 0.9"

  group :test do
    gem "minitest", "~> 5.0"
    gem "pry"
    gem "rake", "~> 13.0"
    gem "simplecov", "~> 0.21"

    group :linting do
      gem "yard-doctest", "~> 0.1"
    end
  end

  group :linting do
    gem "inch", "~> 0.8.0"
    gem "rubocop", "~> 1.7"
    gem "rubocop-minitest", "~> 0.15.2"
    gem "rubocop-rake", "~> 0.6.0"
  end
end
