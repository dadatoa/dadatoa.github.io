---
title: 01. Jekyll minimal sur Github Pages
original_date: 2022-06-01T09:21:01.069Z
date: 2022-06-01T09:21:01.108Z
layout: post
description: Quelques étapes pour créer un site github pages ultre minimaliste
  et ultra vite en utilisant les fonctionnalités de Jekyll fourni par Github
  Pages.
---
## Etape 1: Créer le dépôt

Le nom du dépôt importe peu. L'adresse du site aura la forme : pseudo.github.io/nom-du-repo. Si le nom de ton dépôt est pseudo.github.io, ton site sera disponible directement à l'adresse `https://pseudo.github.io`.

## Etape 2: Créer les premiers fichiers

### _config.yml

c'est le fichier de configuration de Jekyll. Au départ le plus important est de spécifier le thème : minima. Tu peux aussi tout dr suite ajouter un titre et une description à ton site:

```yaml
title: "mon super site"
description: "une description de l'espace"
theme: minima
```

### index.md

Ton site a besoin d'une page d'acceuil. Minima à un layout pour cela, mais sinon, comme Jekyll est sympa, tu peux aussi mettre un `index.html`. Pour ma part, j'utilise les fonctionnalités fournies, je crée donc un `index.md` dans lequel j'écris un Front Matter pour qu'il soit traité par jekyll:

```yaml
layout: index
```

Et c'est tout. Y'a rien besoin d'autre dans ce fichier, mais si t'as envie d'écrire une intro à ton site, libre à toi. Cela dit, en principe, le mieux si tu veux écrire une intro à ton site est de la coller dans la description que t'as mis dans le fichier `_config.yml`.

### about.md

Dans son installation de base, minima contient une page `about.md`. Ce n'est pas obligé, mais ça une première page. N'oublie pas de lui mettre un Front Matter (pour ma part, le front matter du `about.md` contient le layout page, le titre about/à propos et un permalink pour avoir un lien propre).

```yaml
---
title: "à propos"
layout: "page"
permalink: /about/
---
```

### posts/

Jekyll possède une collection prédéfinie qui s'appelle posts, dont les fichier se trouve dans le repertoire `_posts`, ont une convention de nommage : `date(YYYY-MM-JJ)-titre-du-post(slug).md`. Minima possède une fonction sur son layout home pour afficher les *posts* sous forme de liste, un layout post pour les afficher individuellement. A noter que le thème possède aussi une fonction qui récupère toutes les pages qui ont un `title:` dans leur front matter pour le reférencer dans le menu du site.

J'en profite pour créer un premier post histoire d'avoir du contenu. N'oublie pas le *Front Matter* pour que tes fichiers soient traités par *Jekyll/Github Pages* :

```yaml
---
title: "mon super post"
layout: post
```

Evidemment tu peux en mettre plus. Ensuite tu rédige ton post. Inutile de mettre un titre de prmier niveau: le layout post du thème minima affichera le `title` dans un `h1` pour chaque page affichant un post.

## Etape 3: Configurer Github page

Pour envoyer tes fichiers, je te fais pas de topo: soit tu édite direct sur Github, jusqu'ici c'est pas trop embêtant, soit tu crée tes fichiers en local et tu pousse tout vers Github, c'est comme ça que je préfère faire. Tu peux aussi utiliser un éditeur en ligne connecté à Github, avec Vscode en ligne ou son appli Chrome, j'ai testé, c'est pas mal! Par contre y'a pas de terminal, il faut utiliser les outils graphiques de VSCode pour ajouter/commit/pousser les modif qu'on apporte au dossier/repository.

Ensuite y'a deux technique :

### Sur la branche principale

depuis ton repo, tu vas dans les settings > page (menu de gauche) et tu choisis la branche sur laquelle tu veux configurer gh-pages. Normalement à ce niveau t'en a qu'une et c'est ta branche princpale.

### La branche gh-pages

C'est un héritage de l'ancien fonctionnement de gh-pages : si tu crée une branche gh-pages à ton repo, Github va automatiquement déployer un site à partir de cette branche. C'est l'option que je choisi.

## Conclusion

Me voilà avec un blog minima de test fonctionnel, il est temps d'essayer des trucs.
