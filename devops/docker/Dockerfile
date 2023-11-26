# This is example of single Dockerfile which can be used for production, test and develpment environments.

# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2

# Default to production environment if not specified
ARG RAILS_ENV=production
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set environment based on build argument
ENV RAILS_ENV=$RAILS_ENV \
    BUNDLE_PATH="/usr/local/bundle"

# Conditional installation of gems based on environment
FROM base as build
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config
COPY Gemfile Gemfile.lock ./

# Bundle install with or without development and test groups
RUN if [ "$RAILS_ENV" = "production" ]; then \
        bundle install --deployment --without development test; \
    else \
        bundle install; \
    fi

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Additional steps for production
RUN if [ "$RAILS_ENV" = "production" ]; then \
        SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile; \
    fi

# Final stage for app image
FROM base
RUN apt-get update -qq && apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
