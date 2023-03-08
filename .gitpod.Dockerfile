FROM debian:bookworm-slim

RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update
RUN apt-get install zsh git build-essential ruby ruby-dev

RUN gem install bundler github-pages && apt-get purge -y -q --autoremove \
    gcc \
    g++ \
    make \
    libc-dev \
    ruby-dev

RUN apt-get clean
RUN rm -rf /var/lib/apt-lists/* /tmp/* /var/tmp/*

WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000