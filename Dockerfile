FROM ruby:2.6.3-alpine

RUN apk add --update-cache --no-cache tzdata libxml2-dev sqlite-dev \
  make gcc libc-dev g++ linux-headers imagemagick \
  mysql-dev mysql-client nodejs git yarn && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /bookers1

WORKDIR /bookers1

ADD Gemfile /bookers1/Gemfile
ADD Gemfile.lock /bookers1/Gemfile.lock

RUN gem install bundle && \
  bundle install

RUN rm -rf /usr/local/bundle/cache/* /workdir/vendor/bundle/cache/*

ADD . /bookers1

RUN bundle exec rails assets:precompile