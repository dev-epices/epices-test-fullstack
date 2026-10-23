# .devcontainer/Dockerfile
FROM ruby:3.4

# Install essential packages, PostgreSQL client libraries, and netcat
RUN apt-get update && apt-get install -y \
    nodejs \
    yarnpkg \
    build-essential \
    libpq-dev \
    netcat-traditional \
 && rm -rf /var/lib/apt/lists/*

# Install Rails and Bundler
RUN gem install rails bundler

# Set working directory
WORKDIR /app

# copy Gemfile for bundler 
COPY Gemfile Gemfile.lock /app

RUN bunndle check || bundle install

EXPOSE 3000

# Set the entrypoint (no CMD here to auto-run Rails)
ENTRYPOINT ["bin/docker-entrypoint"]

