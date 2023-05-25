---
title: "gestion de contenus : Netlify-cms"
slug: netlify-cms
collection: _docs
tags: [cms, netlify-cm]
date: 2022-06-04

source: https://cnly.github.io/2018/04/14/just-3-steps-adding-netlify-cms-to-existing-github-pages-site-within-10-minutes.html
---

Netlify-cms est un outil open-source qui permet de gérer le contenu des générateurs de sites statiques. Il se connecte au dépôt (par exemple Github), permet d'éditer / créer / suprimer des fichier markdown ou des entrées dans des fichiers yaml.

## Etape 1: créer une app Github Oauth

Direction là: <https://github.com/settings/developers>. Ou sinon, tu vas dans tes settings > Developer settings - ça se trouve tout en bas du menu gauche. Là, tu choisis dans le nouveau menu gauche `OAuth Aps`, y'a un gros bouton `New OAuth app`. Je vais créer une nouvelle app:

* **Application name**: l'app doit avoir un nom, mais je mets ce que je veux
* **Homepage url**: même chose, peu importe
* **Authorization callback url**: là faut pas mettre n'imp: `https://api.netlify.com/auth/done`.

Quand c'est fini, tu es sur la page de ton app, **tu ne la fermes surtout pas** sinon c'est la merde, tu vas devoir refaire cette étape (ou en tout cas une partie)

## Etape 2: créer un site Netlify

Et oui, même si on n'héberge pas chez eux, faudra quand même y avoir un compte et y créer un site. Tu crées le compte avec ton id Github, tant qu'à faire, ça simplifie la vie si tous les services d'authentifications utilisent la même API :). Tu crées un site depuis n'importe lequel de mes repo, ça n'a pas d'importance: *add new site > import an existing project* puis tu choisis Github et un dépôt au pif.
Une fois que c'est fait, tu selectionne ton site, tu vas dans les *Domain settings*, tu ajoutes un *domain alias* (dans la partie *Custom domians*): **pseudo.github.io**. Tu auras une alerte parce que tu ne possèdes pas le domaine *github.io* mais c'est pas grave.

Ensuite dans le menu de gauche, il y a un bouton **Access control**, qui te donne accès à une section OAuth. Tu installes *un nouveau* **provider**. Les infos à renseigner sont :

* **Github** dans la liste déroulante
* **client id** et **client secret** se trouvent sur la page *Github Oauth* que t'as surtout pas fermé. (**client secret** doit être généré et ne peut pas être récupéré après coup).

Mainteneant tu peux fermer ta page *Github Oauth* et ta page *Netlify* aussi.

## Etape 3: Installer le CMS

Enfin, c'est ce qui nous intéresse! tu crées un dossier `admin/` dans ton projet/dépôt. À l'intérieur de ce dossier, tu places 2 fichiers: un `index.html` qui contiendra la page d'admin en elle-même, et un `config.yml` qui servira à configurer ce qui se trouve sur la dite page:

### admin.html

```html
<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Content Manager</title>
</head>
<body>
  <!-- Include the script that builds the page and powers Netlify CMS -->
  <script src="https://unpkg.com/netlify-cms@^2.0.0/dist/netlify-cms.js"></script>
</body>
</html>
```

Pas très compliqué, c'est une page de base sur laquelle on appelle un fichier *javascript* qui va gérer ton admin sous forme de *SPA*.

### config.yml

Le fichier de config va un peu dépendre de la configuration du site et de ce que tu veux pouvoir y modifier, mais en l'état actuel des chose une bonne base serait:

```yaml
backend:
  name: github
  repo: you/you.github.io
  branch: master

media_folder: "images/uploads"

collections:
  - name: "blog" # Used in routes, e.g., /admin/collections/blog
    label: "Blog" # Used in the UI
    folder: "_posts/" # The path to the folder where the documents are stored
    create: true # Allow users to create new documents in this collection
    slug: "{{year}}-{{month}}-{{day}}-{{slug}}" # Filename template, e.g., YYYY-MM-DD-title.md
    fields: # The fields for each document, usually in front matter
      - {label: "Title", name: "title", widget: "string"}
      - {label: "Publish Date", name: "date", widget: "datetime"}
      - {label: "Tags", name: "tags", widget: "list"}
      - {label: "Body", name: "body", widget: "markdown"}
```

Dans la partie `backend`, le *repo* et la *branch* sont à personnaliser. tu n'as pas besoin de changer la partie `media_folder` pour l'instant, c'est là ou seront stocké les images et tous les fichiers uploadés sur le site en utilisant le backend de *Netlify-cms*. Enfin, tu ne modifies pas non plus la partie `collections`, puisqu'en l'état actuel du projet, ça fonctionne plutôt pas mal...

Allez, je vais quand même te faire un tweak que j'aime bien : activer le mode éditorial... C'est assez cool et supporté par Github, ça tombe bien: en gros, quand t'écris un post, au lieu de le publier direct dans la branche de déploiement, *Netlify-cms* crée d'abord une branche dans laquelle se trouvera ton post. Comme ça, tu pourras, après l'avoir écrit, le réviser, le reformuler, le modifier, avant sa publication sur la branche de déploiement:

```yaml
# admin/config.yml
backend:
  name: github
  repo: you/you.github.io
  branch: master

media_folder: "images/uploads"

# Publish mode
publish_mode: editorial_workflow

collections:
  - name: "blog" # Used in routes, e.g., /admin/collections/blog
...
```

Tu ajoutes pour cela une ligne `publish_mode` après le `media_folder` et tu passes la valeur à `editorial_workflow`, et voilà c'est tout. Après avoir écris le post, qui se trouve alors sur une branche spécifique, la publication déclenche une *pull request* sur la branche de déploiment qui est directement validé si possible dans l'interface de *Netlify-cms*. Il n'y a donc pas d'intervention directe sur Github.

## Conclusion

Tu vas pouvoir écrire tes postes sans utiliser d'éditeur sur ton ordi, ni l'éditeur de *Github* qui n'est pas toujours super pratique! je suis assez partisan d'intégrer ce genre de backend assez tôt dans le projet, parce qu'à mesure qu'il va grossir, tu vas vouloir mettre de plus en plus de choses dans le backend. Le problème c'est que *Netlify-cms* à une façon de fonctionner qui ne permet pas toujours de tout faire comme on veut, et il est assez difficile de l'intégrer quand le site a un peu grossi. Il faut alors modifier la façon dont on obtient les données, changer parfois l'architecture des templates, parce que les données doivent être structurées d'une certaine façon pour pouvoir être modifiables par *Netlify-cms*.