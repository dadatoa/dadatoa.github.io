FROM ruby:2-alpine

RUN apk add --no-cache g++ gcc gcompat make musl-dev

WORKDIR /srv/jekyll

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--incremental"]
