FROM ruby:2.1.5

RUN apt-get update && apt-get install -y \
  nodejs \
  mysql-client \
  postgresql-client \
  sqlite3 \
  ca-certificates \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

ADD . /usr/src/app

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server"]
