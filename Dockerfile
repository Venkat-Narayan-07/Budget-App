FROM ruby:3.0
ENV RAILS_ROOT /var/www/app
ENV RAILS_ENV production
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . .
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
