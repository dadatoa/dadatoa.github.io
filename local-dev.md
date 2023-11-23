---
title: local dev
intro: "Github pages n'utilise pas les dernières versions de jekyll et ruby; afin d'éviter le syndrome ça-marche-chez-moi, l'idéal est de reproduire localement en environnement identique à celui de la prod."
---

Github pages utilise Ruby 2.7.4 et Jekyll 3.9.3[^1]. Pour Jekyll et toutes les dépendances de versions, c'est facile, il y a un gem github-pages qui peut être installé. Pour Ruby, tu peux passer soit par Docker, soit par un gestionnaire de version (j'utilise rbenv). J'exclue l'installation en dur sur le systèlme, trop de contraintes

## Environnement local

Installe l'environnement et les outils sur ma machine localement pour la faire matcher avec l'environnement de déploiement.

### Rbenv

Pour pas tout casser, utilise un gestionnaire de versions pour Ruby : rbenv, disponible sur Github : (https://github.com/rbenv/rbenv). Je ne connais que celui là, il est possible qu'il en existe d'autre. Je l'ai installé avec Homebrew[^2] sur mon mac, il est dispo aussi pour Linux, mais visiblement pas pour Windows... Une fois installé tu peux récupérer la version de Ruby qui t'intéresses :

```bash
rbenv install -l # installe la dernière version stable de Ruby
rbenv install 3.2.2 # installe Ruby 3.2.2
rbenv install 2.7.4 # Ruby 2.7.4 est la version de Github Pages

```

Ensuite tu peux définir une version par défaut de Ruby pour ta machine :

```bash
rbenv versions # indique toutes les versions de Ruby installées sur la machine
rbenv global 3.2.2 # si tu souhaites utiliser Ruby 3.2.2 par défaut

```

Tu peux aussi définir une version spécifique de Ruby pour mon projet.

```bash
cd my-jekyll-website # go le projet en question
rbenv local 2.7.4 # utilise localement Ruby 2.7.4 (la version de Github Pages)

```

### Bundler

Bundler est le gestionnaire de dépendances et de package de pour les projets Ruby, il va me permettre de packager mon app Jekyll un peu comme on ferait avec npm, pnpm ou yarn dans un projet Node/Javascript. Les packages Ruby s'appel des Gems. Bundler est lui même un package Ruby:

```bash
gem update --system # mets à jour tous les Gems du système
gem install bundler

```

Bon en principe Bundler est livré d'office avec Ruby, normalement il n'y a pas besoin de l'installer.

Ensuite tu peux suivre la doc Jekyll (https://jekyllrb.com/tutorials/using-jekyll-with-bundler/) :

```bash
cd my-jekyll-website # Go le dossier du projet
bundle init # pour initialiser le projet

# tu peux définir le dossier dans lequel seront stockées les gems du projet
bundle config set --local path 'vendor/bundle'

# là ça diffère un peu : installe gh-pages au lieu de Jekyll
# gh-pages contient toutes les gems installées par défaut sur Github Pages
bundle add gh-pages

# Si tu utilises Ruby 3 pour mon projet, le serveur webrick qui est le serveur de
# dev de Jekyll n'est pas installé par défaut.
bundle add webrick

```

C'est prêt, tu peux commencer à bosser.

## Docker

Docker va permettre d'isoler complètement l'environnement de dev du système local. Je suis parti d'une image ruby 2 basée sur alpine linux. C'est Ruby 2.7 mais ça fera bien l'affaire.

Comme toute la config Docker est spécifique au projet, tous les fichiers relatifs à mon environnement Docker peuvent aller à la racine du projet Jekyll.

### Construction de l'image

Pour utiliser Bundler à l'intérieur du container ne image ruby:2-alpine, je me suis créé une image qui ne contient que le nécessaire à la compilation des gems Ruby. Le reste du `Dockerfile` c'est essentiellement de la config pour ne pas avoir à passer des commandes docker à rallonge.

```dockerfile
FROM ruby:2-alpine

RUN apk add --no-cache g++ gcc gcompat make musl-dev

WORKDIR /srv/jekyll

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--incremental"]

```

J'ai un peu galéré pour que tout fonctionne bien. J'ai crée un script `entrypoint.sh`
dans lequel j'ai mis la commande pour l'entrypoint justement :

```bash
#!/bin/sh
set -e

bundle install --retry 5 --jobs 20

exec "$@"

```

Je sais, y'a pas grand chose. J'utilise ce script pour pouvoir placer le `exec "$@"` qui permet d'exécuter le contenu de `CMD` comme une commande séparée, au lieu que docker le traite comme des paramètres de l'entrypoint.

### Construction du container

Je viens de découvrir qu'on pouvait build l'image directement depuis un fichier docker compose. Ça tombe bien, ça t'éviteras de devoir passer une commande `docker build` supplémentaire à chaque fois que tu vas reconstruire mon image. Le fichier `docker-compose.yaml` ressemble à ça :

```yaml
services:
  jekyll:
	build: .
	container_name: jekyll
	working_dir: /srv/jekyll
	volumes:
	  - .:/srv/jekyll
	ports:
	  - "4000:4000"

```

Pour le build de l'image, il suffit d'ajouter une ligne `build:` qui indique ou chercher le `Dockerfile`, dans mon cas dans le répertoire courant. Pour le reste c'est du classique.

### Initialisation du projet

Si le projet n'a pas déjà été initialisé avec Bundler, c'est un peu chiant. D'ici, je vois deux options possible pas trop lourdes :

#### 1. Manuellement

Si tu as accès à un projet qui ressemble, tu peux recopier le Gemfile à la racine de ton projet. Pour un projet Github Pages c'est pas trop difficile, y'a qu'une Gem à ajouter, c'est gh-pages:

```Gemfile
source "https://rubygems.org"
# gem "rails"
gem "github-pages", "~> 228"

```

#### 2. Avec Docker

Sinon, un peu plus technique, tu peux ouvrir un terminal et utiliser ta config docker que je viens de te préparer :

```bash
cd my-jekyll-website # go le dossier du projet

# Lance un conteneur d'après ton docker-compose mais en modifiant l'entrypoint
docker compose run --rm --entrypoint /bin/sh jekyll

# /bin/sh te donnera l'accès à un shell dans ton container dans le dossier du projet

bundle init # initialise le projet avec bundler
bundle add github-pages # ajoute la dépendance github-pages
# défini le dossier dans lequel seront stockées les gems de ton projet
bundle config set --local path 'vendor/bundle'

exit # quitte le shell du container

```

### Usage du container

Une fois que tout est paramétré, c'est plutôt simple; tout passe par des commandes docker compose dans un terminal :

```bash
docker compose up # build le projet et lance jekyll serve
## un appui sur ctrl + C arrête le serveur et le container sans le supprimer
docker compose start # démarre le container (en tâche de fond cette fois)
docker compose restart # redémarre le container
docker compose stop # arrête le container sans le supprimer
docker compose down # arrête et supprime le container

```

Arrêter le container avec la commande `stop` plutôt que `down` permet de ne pas détruire le container et donc de ne pas avoir à relancer le `bundle install` de l'entrypoint. De plus l'option `--incremental` permet de gagner beaucoup de temps sur la génération du site, et le `docker compose restart` redémarre le serveur très rapidement.

## Conclusion

Y'a pas de meilleure méthode. j'ai galéré à faire marcher mon environement avec Docker, mais une fois que c'est en route, c'est plutôt simple à l'usage. L'avantage est que l'environnement est reproductible en une seule commande si tu pars d'un repo cloné, pratique si tu veux bosser sur différentes machines, ou si tu travailles en équipe.

En revanche, si tu bosses toujours sur la même machine et que t'es tout seul sur ton side project, configurer tout le bazar avec Docker c'est un peu bourrin, un rbenv et un bundler bien réglé seront peut-être plus facile à mettre en place, surtout si tu n'as pas docker sur ta machine et que tu dois l'installer spécifiquement pour ce projet.

Au final c'est aussi pas mal de préférences personnelles : moi je vais continuer avec Docker parce que j'aime bien et que ça me permet d'apprendre des trucs que je maîtrise pas trop, mais toi tu fais ce que tu veux.

[^1]https://pages.github.com/versions/
[^2] gestionnaire de packages en ligne de commande sur mac
