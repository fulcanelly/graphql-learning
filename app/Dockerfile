FROM ruby:3.1.2-alpine3.15

RUN apk update && apk add --no-cache build-base
RUN apk add postgresql-dev

COPY Gemfile Gemfile

RUN bundle install

EXPOSE 4567


COPY . .

CMD ["ruby", "main.rb"]
