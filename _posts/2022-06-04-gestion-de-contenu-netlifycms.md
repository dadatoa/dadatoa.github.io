---
title: "03. gestion de contenus : Netlify-cms"
update: 2022-06-04T09:22:40.807Z
date: 2022-06-04T09:22:40.807Z
layout: post
source: https://cnly.github.io/2018/04/14/just-3-steps-adding-netlify-cms-to-existing-github-pages-site-within-10-minutes.html
---
Netlify-cms est un outil open-source qui permet de gérer le contenu des générateurs de sites statiques. Il se connecte au dépôt (par exemple Github), permet d'éditer / créer / suprimer des fichier markdown ou des entrées dans des fichiers yaml.

## Etape 1: créer une app Github Oauth

Direction là: <https://github.com/settings/developers>. Ou sinon, vas dans tes settings > Developer settings - ça se trouve tout en bas du menu gauche. Là, tu choisi dans le nouveau menu gauche `OAuth Aps`, y'a un gros bouton `New OAuth app`. Je vais créer une nouvelle app:

* **Application name**: l'app doit avoir un nom, mais je mets ce que je veux
* **Homepage url**: même chose, peu importe
* **Authorization callback url**: là faut pas mettre n'imp: `https://api.netlify.com/auth/done`.

Quand c'est fini, je suis sur la page de mon app, **je ne la ferme surtout pas** sinon c'est la merde, je vais devoir refaire cette étape (ou en tout cas une partie)

## Etape 2: créer un site Netlify

Et oui, même si on n'héberge pas chez eux, faudra quand même y avoir un compte et y créer un site. Je crée le compte avec mon id Github, tant qu'à faire, ça me simplifie la vie si tous les services d'authentifications utilisent la même API :). Je crée un site depuis n'importe lequel de mes repo, ça n'a pas d'importance: *add new site > import an existing project* puis je choisi Github et un dépôt au pif.
Une fois que c'est fait, je selectionne mon site, je vais dans les *Domain settings*, j'ajoute un *domain alias* (dans la partie *Custom domians*): **pseudo.github.io**. J'aurais une alerte parce que je ne possède pas le domaine *github.io* mais c'est pas grave.

Ensuite dans le menu de gauche, il y a un bouton **Access control**, qui me donne accès à une section OAuth. J'installe *un nouveau* **provider**. Les infos à renseigner sont :

* **Github** dans la liste déroulante
* **client id** et **client secret** se trouvent sur la page *Github Oauth* qu'on n'a surtout pas fermé. (**client secret** doit être généré et ne peut pas être récupéré après coup).

Mainteneant je peux fermer ma page *Github Oauth* et ma page *Netlify* aussi.

## Etape 3: Installer le CMS

Enfin, c'est ce qui nous intéresse! Je crée un dossier `admin/` dans mon projet/dépôt. À l'intérieur de ce dossier, je place 2 fichiers: un `index.html` qui contiendra la page d'admin en elle-même, et un `config.yml` qui servira à configurer ce qui se trouve sur la dite page:

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

Pas très compliqué, c'est une page de base sur laquelle on appelle un fichier *javascript* qui va gérer notre admin sous forme de *SPA*.

### config.yml

le fichier de config va un peu dépendre de la configuration du site et de ce que je veux pouvoir y modifier, mais en l'état actuel des chose une bonne base serait:

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

Dans la partie `backend`, le *repo* et la *branch* sont à personnaliser. Je ne change pas pour l'instant la partie `media_folder`, c'est là ou seront stocké les images et tous les fichiers uploadés sur le site en utilisant le backend de *Netlify-cms*. Enfin, je ne vais pas modifier non plus la partie `collections`, puisqu'en l'état actuel du projet, ça fonctionne plutôt pas mal avec ce que souhaite pouvoir changer...

Allez, je vais quand même me faire un tweak que j'aime bien : activer le mode éditorial... C'est assez cool et supporté par Github, ça tombe bien: en gros, quand j'écris un post, au lieu de le publier direct dans la branche de déploiement, *Netlify-cms* crée d'abord une branche dans laquelle se trouvera mon post. Comme ça, je pourrais, après l'avoir écrit, le réviser, le reformuler, le modifier, avant sa publication sur la branche de déploiement:

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

J'ajoute pour cela une ligne `publish_mode` après le `media_folder` et je passe la valeur à `editorial_workflow`, et voilà c'est tout. Après avoir écris le post, qui se trouve alors sur une branche spécifique, la publication déclenche un *pull request* sur la branche de déploiment qui est directement validé si possible dans l'interface de *Netlify-cms*. Il n'y a donc pas d'intervention directe sur Github.

## Conclusion

Je vais pouvoir écrire mes postes sans utiliser d'éditeur sur mon ordi, ni l'éditeur de *Github* qui n'est pas toujours super pratique! je suis assez partisan d'intégrer ce genre de backend assez tôt dans le projet, parce qu'à mesure qu'il va grossir, je vais vouloir mettre de plus en plus de choses dans le backend. Le problème c'est que *Netlify-cms* à une façon de fonctionner qui ne permet pas toujours de tout faire comme on veut, et il est assez difficile de l'intégrer quand le site a un peu grossi. Il faut alors modifier la façon dont on obtient les données, changer parfois l'architecture des templates, parce que les données doivent être structurées d'une certaine façon pour pouvoir être modifiables par *Netlify-cms*.
