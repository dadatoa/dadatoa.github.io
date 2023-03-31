---
title: "Obsidian: configurer le vault pour un site Jamstack"
slug: obsidian-jamstack-vault
collection: _docs
tags: [obsidian, jamstack, github, github-publisher]
date: 2023-03-30
share: true
---

Je vais m'attaquer à la configuration de mon *vault* en vue de la publication de mes notes sur mon site Github Pages. Ce qui marche ici pour Jekyll/Github-Pages devrait fonctionner pour n'importe quel système jamstack en tout cas pour la partie éditorial en markdown.

## Côté Jekyll / Github

Mon site est organisé avec des collections que j'ai configuré et qui définisse en gros les sections de mon site. Les posts de chaque collection sont situé dans un dossier `_nom-de-la-collection`. Pour me faciliter la tâche et améliorer la visibilité, j'ai rangé toutes mes collections dans un dossier `collections`. Tout le contenu éditorial de mon site se trouve donc dans ce dossier, à l'exception de celui de la page d'acceuil, qui grace à un plugin reprend ce que j'ai mis dans le `README.md` de mon dépôt, ce que je trouve pratique. Les collections sont configurées dans les settings de mon site avec quelques clés frontmatter par défaut, comme le layout à utiliser en fonction de chaque collection par exemple. 

Et c'est tout ce qui est important: identifier 1 dossier dans ton repo vers lequel le plugin pointera à la connexion, pour ne pas avoir de foutoir un peu partout à la racine du projet. Ce dossier peut contenir des dossiers ou non, en fonction de comment tu veux organiser ton contenu, on peut paramétrer le plugin *Github-publisher* par la suite pour positionner les bons articles aux bons endroits.

## Github Publisher - Upload configuration

Je survole vite fait, c'est plus pour avoir les principes. Si tu veux savoir comment je configure *Github publisher*, j'y reviens [ ici ](obsidian-github-publisher-setup.md). En gros, il y a trois mode d'uploads:
- **Fixed Folder:** toutes les notes sont uploadées dans un dossier unique dans le repo. Ça aurait pu le faire si au lieu de diviser mon site en collections j'avais décidé de mettre tous le contenu dans des posts, et d'organiser le site en catégories de posts. Mais c'est pas le choix que j'ai fait
- **YAML frontmatter:** c'est l'option que j'ai choisie; tu définis une clé dans ton frontmatter et Github Publisher va associé la clé à un dossier dans lequel publier les notes. Par exemple chez moi, si je veux que mes notes aillent dans ma collection Jekyll *posts*, je définie une clé, disons *collection*, dans le frontmatter de mes notes, et je le règle à *_posts* pour que la note soit uploadée dans le dossier `_posts` de mon dépot. Ça donnerait un truc comme ça: 
```yaml
---
title: "mon super titre"
collection: _posts
...
---
```
- **Obsidian Path:** dans ce cas là, Obsidian va chercher à uplader les notes dans les mêmes repertoire que sur le *vault*. C'est une option intéressante, tu peux y accoller un chemin racine, mais ça veut dire que tes repertoires s'appellent exactement comme les repertoires de tes collection, et ça ne me convenait pas.

## Du côté du Vault

Bien que je n'ai pas choisi d'utiliser la valeur *Obsidian Path* dans les réglages du plugin, j'ai recréé une arborescence dans mon *vault* à peu près similaire à ce que j'ai mis dans le dossier `collections` de mon dépôt sur Github, pour améliorer la lisibilité de mon *vault*. Pourquoi ne pas avoir choisi *Obsidian Path* alors? 

Déjà, les noms des dossiers dans mon *vault* sont, je trouve, plus lisible que les noms de dossiers des collections associés. 

Ensuite, si je dois faire des modifications dans les collections, ou si juste, je décide de changer d'avis sur la façon dont j'organise mes notes, ça fera probablement moin de taf.

Enfin, pour automatiser un peu le process de création de mes notes en particulier au niveau du frontmatter, je prévois de créer un système de templates. Pour cela, je vais enregistrer mes templates dans un dossier sur mon *vault*, mais je n'ai pas forcément envie que se dossier se retrouve sur le repo Github de mon site, parce qu'il n'y servira à rien, et ne fera que polluer la lisibilité de mon repo, qui est bien assez bordélique comme ça.

A la fin, l'arborescense de mon *vault* devrait dessembler à quelquechose comme ça:

```bash
.
├── blog
│   └── 2023-03-29-obsidian-jekyll-workflow.md
├── docs
│   ├── obsidian-github-publisher.md
│   ├── obsidian-jamstack-vault.md
│   └── obsidian-la-base.md
├── projets
│   ├── un-autre-projet.md
│   └── un-projet.md
└── templates
    └── un-template.md
```

Tu remarqueras que j'utilise Obsidian pour écrire cette série d'articles!

## Le plugin: Github Publisher

Maintenant que je t'ai fais le topo sur la base du projet, il est temps de regarder en détail comment je vais configurer le plugin Github Publisher.