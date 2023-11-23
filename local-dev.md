---
title: local dev
intro: "Github pages n'utilise pas les dernières versions de jekyll et ruby; afin d'éviter le syndrome ça-marche-chez-moi, l'idéal est de reproduire localement en environnement identique à celui de la prod."
---

Github pages utilise Ruby 2.7.4 et Jekyll 3.9.3[^1]. Pour Jekyll et toutes les dépendances de versions, c'est facile, il y a un gem github-pages qui peut être installé. Pour Ruby, je peux passer soit par Docker, soit par un gestionnaire de version (j'utilise rbenv). J'exclue l'installation en dur sur le systèlme, trop de contraintes

## Docker

Ce que j'ai trouvé de plus proche par rapport à ce que je recherche, c'est une image ruby 2 basée sur alpine linux. C'est Ruby 2.7 mais ça fera bien l'affaire.

### Dockerfile

Vu que je peux utiliser bundler à l'intérieur du container ne image ruby:2-alpine, je peux me créer une image qui ne contient que le nécessaire à la compilation des gems Ruby.

```dockerfile
FROM ruby:2-alpine

RUN apk add --no-cache g++ gcc gcompat make musl-dev
```

### Construction du container

Dans le cas ou j'utilise l'image `ruby:2-alpine`, je ne détruirai pas le container automatiquement à la fin du docker run pour conserver mon environnement et reduire le temps de build quand je reprend le projet.

```bash
docker run -it --name ghpages --workdir /srv/jekyll -v .:/srv/jekyll ruby:2-alpine apk add --no-cache g++ gcc gcompat make musl-dev && bundle install
```

Je lui donne un petit nom pour faciliter sa réutilisation et lance le `bundle install` à la suite de l'installation des outils de compilation comme ça le container est prêt à l'usage.

### Usage du container

```bash
docker
```

[^1]https://pages.github.com/versions/
