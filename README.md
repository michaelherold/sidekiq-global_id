# sidekiq-global_id

A simple Sidekiq middleware that allows you to transparently [de]serialize GlobalID-compatible objects as GlobalIDs. The benefit of this is that you can express your background jobs just like you do the rest of your code. No need to remember how you need to send them to Redis!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-global_id'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sidekiq-global_id

## Usage

TODO: Write usage instructions here

## Contributing

So you’re interested in contributing to sidekiq-global_id? Check out our [contributing guidelines](CONTRIBUTING.md) for more information on how to do that.

## Supported Ruby Versions

This library aims to support and is [tested against][actions] the following Ruby versions:

* Ruby 2.5
* Ruby 2.6
* Ruby 2.7
* Ruby 3.0
* JRuby 9.2
* JRuby 9.3

If something doesn't work on one of these versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby versions, however, we only support the versions listed above.

If you would like this library to support another Ruby version or implementation, you may volunteer to be a maintainer. Being a maintainer entails making sure all tests run and pass on that implementation. When something breaks on your implementation, you will be responsible for providing patches in a timely fashion. If critical issues for a particular implementation exist at the time of a major release, we may drop support for that Ruby version.

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver]. Report violations of this scheme as bugs. Specifically, if we release a minor or patch version that breaks backward compatibility, we will immediately yank that version and/or immediately release a new version that restores compatibility. We will only introduce breaking changes to the public API with new major versions after 1.0. As a result of this policy, you can (and should) specify a dependency on this gem using the [Pessimistic Version Constraint][pessimistic] with two digits of precision. For example:

    spec.add_dependency "ksuid", "~> 0.1"

[pessimistic]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[semver]: http://semver.org/spec/v2.0.0.html

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
