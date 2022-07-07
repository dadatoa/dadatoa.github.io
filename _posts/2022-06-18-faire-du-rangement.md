---
title: Faire du rangement
section: docs
categories:
tags: 
date: 2022-06-08T14:13:52.720Z
layout: post
---
Mon projet commence à grossir tranquillement. L'utilisation de plusieurs outils rend le repo un peu bordélique : y'a plein de fichiers qui n'ont rien à voir avec mon site Jekyll. 

En plus Jekyll à tendance à recopier tout le contenu du projet vers le dossier de déploiment, et peut-être qu'il y a des fichiers qui n'ont pas besoin d'être déployés.
## Technique n°1: créer un répertoire source

*Jekyll* permet de spécifier dans le fichier `_config.yml` un dossier qui contiendra toutes les sources nécessaires à la construction du site. Je dois juste ajouter une ligne `source: repertoire_source/` dans le fichier de config. *Jekyll* ira chercher les fichiers dans ce repertoire uniquement pour construire le site, ignorant tout ce qui se trouve à la racine du projet. Du coup, tout ce qui ne concerne pas le site n'est pas déployé. C'est trop cool... 

Sauf que... Ça ne marche pas avec *Github Pages*, il faut trouver une autre solution. Cela dit, j'ai testé en local, ça marche trop bien, sonc si tu déploies ton site autrement qu'avec *Github Pages*, ça me semble être une très bonne méthode pour ordonner un peu ton dépôt.

## Technique n°2: spécifier des fichiers à exclure

A défaut de pouvoir ranger proprement, je peux au moins dire à *Jekyll* que certains fichiers ne doivent pas tre déployés. Par défaut, c'est déjà le cas de tout ce qui commence par un *_underscore.* Mais je peux aller un petit peu plus loin : je peux mettre une liste d'éléments à exclure du déploimment dans le fichier de config. Ça se présentera sous la forme d'un tableau dans le fichier `_config.yml`:

```yaml
exclude: [
  fichier_1,
  dossier_1,
  fichier_2,
  etc...,
]
```

C'est un peu fastifdieux, je doit lister tous les fichiers à exclure, mais ça marche.

## Technique 3: ranger les pages dans des dossiers

Par défaut, tout les fichiers `markdown` qui ont un *Front Matter*, ainsi que toutes les pages `html` sont considérées par *Jekyll* comme des pages. Rien n'empêche de toutes les regrouper au même endroit dans un dossier page, à l'exception de la page `index.md` cependant.

Je peux même aller plus loin grace aux collections : je peux spécifier une collection *page* dans le `_config.yml`qui contiendra toutes les pages de mon site. Ce faisant, je peux aussi différencier les types de pages, créer une collection blog différente de la collection posts, voir réinitialiser les réglages de la collections posts par défaut.

## Bonus: J'affine les réglages de mon _config.yml

Tant que j'y suis, je vais modifier quelques trucs dans la configuration de mon site. Je jette un oeil au dépôt *Github* de minima pour avoir la documentation d'abord. Attention, je suis sur *Github Pages*, du coup je ne suis pas sur la dernière version de minima 3.X, mais sur une 2.X. Certaines options diffèrent un peu, voilà à quoi ressemble mon `_config.yml`:

```yaml
title: "dadatoa.github.io"

description: "mon site/blog de test Jekyll/Github Pages. J'utilise le thème minima fourni par défaut avec Github Pages"

site.authot: dadatoa
# site.email: ton@email.com

# reseaux sociaux:
github_username: dadatoa
twitter_username: RI_dadatoa

theme: minima

plugins:
  - jekyll-seo-tag # reprend la description du site pour générer un tag html meta SEO
  - jemoji # les émojis de github

# décommenter la ligne source pour que jekyll ne compile le site qu'à partir du contenu du dossier spécifié
# source: dossier/ 

# exclude : contient tout les fichier non nécessaire à Jekyll pour éviter qu'ils ne soient copier ds le repertoire de deploy
exclude : [
  .jekyll-cache,
  .gitignore,
  .gitpod.Dockerfile,
  .gitpod.yml,
  docker-compose.yml,
  Gemfile,
  Gemfile.lock,
  ]

# disable_disk_cache: BOOL - évite la création d'un repertoire de cache type .jekyll-cache
disable_disk_cache: true
```

Y'a pas grand chose à dire. J'ai ajouté une ligne pour éviter la génération d'un répertoire de cache à chaque génération de site, ça économise un peu de place. J'ai aussi ajouté quelques plugins. Pour les plugins, tout n'est pas possible sur Github Pages. Il y a une liste de plugins pré-installés par défaut sur la page [About Github Pages and Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll) disponnible sur *Github*. Par ailleurs, on pourra trouver l'ensemble de plugins utilisables sur Github Pages sur la page [Dependency versions](https://pages.github.com/versions/) fournie par la plateforme.