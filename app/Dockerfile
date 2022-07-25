FROM ruby:3.0-alpine3.15

RUN apk update && apk add --no-cache build-base
RUN apk add postgresql-dev

COPY Gemfile Gemfile

RUN bundle install



COPY . .

CMD ["ruby", "main.rb"]
