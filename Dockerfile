FROM ruby:2.4

RUN apt-get update -qq && apt-get install -y nodejs vim less
RUN gem install bundler -v 1.17.3

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4
