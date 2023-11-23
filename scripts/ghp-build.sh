#!/bin/sh

docker container rm ghpages

docker run -it --name ghpages --workdir /srv/jekyll -v .:/srv/jekyll ruby:2-alpine apk add --no-cache g++ gcc gcompat make musl-dev && bundle install
