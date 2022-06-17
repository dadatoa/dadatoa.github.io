FROM ruby

RUN gem install --force bundler
RUN gem install jekyll jekyll-feed webrick jekyll-seo-tag rexml minima

WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000