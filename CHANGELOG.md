# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.1.0](https://github.com/michaelherold/sidekiq-global_id/tree/v0.1.0) - 2021-10-23

### Added

* A client-side middleware and accompanying server-side middleware for [de]serializing GlobalID-eligible objects as GlobalIDs when you use them as arguments to a Sidekiq worker. The middleware incur approximately a 30% penalty versus serializing a simple property, such as an ID.
