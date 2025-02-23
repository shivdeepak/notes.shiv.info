FROM ruby:3.3.4

WORKDIR /app

COPY . .

RUN bundle install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--host", "0.0.0.0"]
