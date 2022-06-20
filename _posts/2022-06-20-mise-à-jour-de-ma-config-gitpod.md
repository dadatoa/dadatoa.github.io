---
title: Mise à jour de ma config Gitpod
update: ""
date: 2022-06-20T10:05:50.944Z
layout: post
description: "J'ai mis à jour mon Dockerfile Gitpod : ça me fait une image un
  peu moins lourde, toujours basée sur Debian, sauf que maintnant, je pars d'une
  image Bookworm Slim. Ça fait un peu plus de trucs à installer, mais je gagne
  un peu d'espace, et je resouds au passage un problème que j'avais en local."
---
J'ai mis à jour mon Dockerfile Gitpod : ça me fait une image un peu moins lourde, toujours basée sur Debian, sauf que maintnant, je pars d'une image Bookworm Slim. Ça fait un peu plus de trucs à installer, mais je gagne un peu d'espace, et je resouds au passage un problème que j'avais en local. En plus, ma nouvelle image me permet d'avoir la même configuration de Jekyll localement (et sur Gitpod) que sur Github Pages.

## 1. Changer d'image et adapter la configuration

J'utilise maintenant une image de Debian 12 (nom de code: Bookworm) qui est pour l'instant encore en test mais qui est largement assez stable pour mon usage. L'image que j'utilise est `debian:bookworm-slim` qui a l'avantage de ne peser que 75 mo au départ. Par contre il n'y a vraiment aucun outils donc mon `Dockerfile` contient un peu plus de commandes.

### Configuration des paquets pour mon image slim

 La première étape consiste à installer les pré-requis de *Jekyll*.

```dockerfile
FROM debian:bookworm-slim

RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update
RUN apt-get install build-essential
RUN apt-get install ruby-dev \
    ruby \
    git
    ...
```

Précision : la commande `RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes` me permet de répondre Yes automatiquement lorsque `apt` me demande des trucs. Sans ça, il faut que je prcise un `-y` par exemple à chaque `apt-get install` sinon la construction de l'image plante puisqu'elle n'est pas prévu interagir avec un utilisateur. Et je n'oublie pas d'installer *git* également, sans quoi je vais galérer à pousser mes modifs dans *Github* depuis *Gitpod*.

### Ajouter les dépendance Github Pages et faire du ménage

Il existe un *Gem* `github-pages` qui permet d'installer la totalité des éléments nécessaire et des dépendances qui font tourner *Github Pages*, avec les versions utilisées par la plateforme. C'est très pratique. Une fois que c'est installé, on peu supprimer les paquets de dev qui ne servent qu'à la compilation des *Gems*. Ensuite, je fais un `apt-get purge` et j'efface tous les fichiers d'installations dont je n'ai pas besoin.

```dockerfile
...
RUN gem install github-pages && apt-get purge -y -q --autoremove \
    gcc \
    g++ \
    make \
    libc-dev \
    ruby-dev

RUN apt-get clean
RUN rm -rf /var/lib/apt-lists/* /tmp/* /var/tmp/*
```



### Finaliser la configuration du Dockerfile

Enfin, je configure mon environnement Docker pour pouvoir utiliser le serveur de développement et persister les fichiers Jekyll. Ça ne change pas par rapport à ce que j'avais précédemment. Voilà la tête de mon Dockerfile une fois fini :

```dockerfile
FROM debian:bookworm-slim

RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update
RUN apt-get install build-essential
RUN apt-get install ruby \
    ruby-dev \
    # ruby-execjs \
    # ruby-pygments.rb \
    # locales \
    git

RUN gem install github-pages && apt-get purge -y -q --autoremove \
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
```

## 2. La configuration de Gitpod

Étant donné que mon environnement a vocation à être relativement figé, et devant coller au mieux à la configuration de Github Pages, je n'ai pas besoin de gérer automatiquement les dépendances. Je n'ai donc pas installé *Bundler*, et ce faisant, la commande `bundle exec jekyll serve` présente dans mon fichier `gitpod.yml` plante.