# sidekiq-global_id benchmarks

To run any of the benchmarks in this directory, you will need a working Redis instance on the local host. To make this easier, we include a Docker Compose file that will allow you to easily run Redis.

## Running Redis

To use Docker Compose, run the following in a terminal window:

    cd benchmarks/
    docker-compose up

To run Redis with only Docker, run:

    docker run --rm -it -p 6379:6379 redis:6-alpine

Or with Podman:

    podman run --rm -it -p 6379:6379 docker.io/library/redis:6-alpine

## Running a benchmark

The benchmark scripts are pure Ruby scripts. You can run them with `bundle exec ruby`, for instance:

    bundle exec ruby benchmarks/client.rb

Since the gem works via middleware, we need to configure the middleware or not to benchmark them. We do this by using benchmark-ips' hold functionality, so **run the benchmark twice** to generate a comparison.
