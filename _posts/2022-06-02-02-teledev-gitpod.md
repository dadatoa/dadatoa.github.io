---
title: "2. Télétrav-dev: Gitpod"
layout: post
descritption: "Rien à voir avec Jekyll... mais plus avec Github. Gitpod est un outil cool qui permet de coder avec un VSCode dans un navigateur, qui possède un terminal et qui technique tourne dans un container Docker. Si tu connais pas Docker, renseigne-toi, mais en attendant et en simplifiant fort, le principe c'est de te permettre de travailler comme si t'avais une machine virtuelle, sans avoir à installer de machine virtuelle."
--- 

## 1. créer un compte

Je perds pas de temps, direction [Gitpod](https://gitpod.io) et je me connect avec Github directement. Ça marche aussi avec Gitlab ou BitBucket.

## 2. Créer un workspace

Y'a un gros bouton new workspace... go. Normalement, il reconnais la technologie utilisée, mais là comme y'a pas grand chose dans mon repo, il fait riend e spécial, mais j'ai quand même accès à mon dépôt, sur sa branch pricipale, avec un terminal. Pur forcer le lancement de la configuration de *Gitpod*, je lance dans le terminal la commande `gp init`. J'avais bon espoir, mais ça crée juste un fichier de config `gitpod.io` avec des commandes de base, mais comme il voit pas quelles technos sont utilisées, c'est des commande qui font rien de spécial. J'ai une idée, je vais installer jekyll dans *Gitpod*.

## 3. Installer Jekyll

J'installe Jekyll sur mon container dans lequel tourne mon *Workspace Gitpod*. Go la [documentation oficielle](https://jekyllrb/docs/installation/) et je suis les consigne pour une installation sous Debian Linux. *En effet, Gitpod a un peu de mal avec les autres distributions, dans les container tourne en général avec Debian ou une distro dérivée (genre Ubuntu).*

D'abord les pré-requis/dépendances:

```bash
gitpod:$ sudo apt-get update
gitpod:$ sudo apt-get install ruby-full build-essential
```

Puis Jekyll en vrai:

```bash
gitpod:$ gem install jekyll bundler
```

## 4. Initialiser Jekyll dans mon repo

C'est une étape qui est un peu différente de ce qu'on trouve dans la doc officielle : comme on construit le site de zero, il y a des trucs à faire en plus mais c'est pas méchant. On va d'abord générer les fichier qui sont normalement produit au départ par la commande `jekyll new mon-super-site`:

```bash
gitpod:$ bundle init
gitpod:$ bundle add jekyll minima webrick rouge
```

* La commande `bundle init` permet d'itialiser mon dépôt comme un Gem Ruby, si tu comprends pas... rensignes-toi ! mais en attendant, c'est nécessaire pour que Jekyll fonctionne, elle va générer un fichier `Gemfile` (sans extension).
* La commande `bundle add jekyll minima webrick rouge` va ajouter ces dépendances aux Gemfile :
  * `jekyll`: le générateur de site statique, Jekyll ne peut fonctionner sans... Jekyll
  * `minima`: le thème de base, pas forcément toujours installé d'office avec Jekyll, donc autant le préciser
  * `webrick`: le serveur utilisé pour le développement de *Jekyll* par la commande `jekyll serve`
  * `rouge`: un *colorisateur syntaxique* utilisé par Jekyll pour mettre des jolies couleurs dans le rendu `html` du code écrit dans les fichier `markdown`.

Maintenant je lance un `bundle install` dans le terminal pour m'assurer que toutes les dépendances sont bien installées. Enfin je me fais un premier test en lancer un build du site `bundle exec jekyll build`. Le `bundle exec` permet de s'assurer au premier lancement que toutes les dépendances sont bien installée avant le lancement de la commande. Pour le sport, je lance un `jekyll serve` afin de voir comment ça rend, le serveur se lance, j'ai une petite alerte qui me demande si je veux ouvrir la page dans une fenêtre de prévisualisation ou dans un navigateur. Ça fonctionne, sauf que je me rends compte que j'ai oublié de créer mon fichier `index.md`. Je le crée donc de ce pas!

Et avant de faire le commit et d'envoyer le push, je me rends compte qu'il y a un autre fichier que j'ai oublié: le `.gitignore`. J'y remédie tout de suite (note qu'il y a un modèle de `.gitignore` pour *Jekyll/Github Pages* dans les gitignore par défaut disponibles à la création du dépôt sur Github - j'ai zappé, j'ai été con). Je peux maintenant envoyer mes modifications sur mon dépôt *Github*.

## 5. relancer la config de Gitpod

### Image personnalisée

Après avoir fait quelques tests, j'ai décidé d'utiliser une image perso. Je crée donc un `Dockerfile`, qui aura un nom particulier : `gitpod.Dockerfile` (c'est comme ça qu'il est nommé dans la doc de *Gitpod*). Je vais faire simple dans un premier temps. j'utilise une image ruby officielle (basée elle même sur Debian) et je passe quelques commandes pour installer *Jekyll*, *minima*, et les dépendances dont j'ai besoin. Comme ça pas besoin de refaire un `bundle install` à chaque lancement du *Workspace*:

```dockerfile
#.gitpod.Dockerfile
FROM ruby

RUN gem install --force bundler
RUN gem install jekyll jekyll-feed webrick jekyll-seo-tag rexml minima

WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
```

Ensuite, j'ajuste mon fichier `.gitpod.yml`. Je peux le faire à la main ou en semi-automatique en lançant une commande `gp init -i`. Quelque soit la méthode, je le paramètre pour se qu'il se base sur mon `.gitpod.Dockerfile` et lance un `jekyll serve --watch` à l'ouverture. Comme ça c'est fait! Voilà ce que ça peut donner:

```yaml
image: 
  file: .gitpod.Dockerfile
tasks:
- command: bundle exec jekyll serve --watch
```

Pour me faciliter un peu la tâche aussi, je configure un projet. Ça me permet entre autre de lancer des *workspace* directement sur une autre branche de mon dépôt que la branche principale (*master* dans mon cas). Le premier lancement est un peu long car Gitpod configure le *container*, mais ça sera un peu plus rapide par la suite.

## Conclusion

Me voilà avec un beau système qui fonctionne et qui peut être utilisé sans aucune installation locale. Je peux me connecter sur Gitpod depuis n'importe quel navigateur et continuer le développement de mon site sans rien installé localement. J'ajoute, si jamais tu en doutes, que c'est très confortable à l'usage. Gitpod à une offre gratuite, qui à mon sens et parfaitement suffisante pour un dev seul, ou pour des projets personnels comme c'est mon cas ici.
