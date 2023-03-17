# [Mon blog perso avec github pages](https://dadatoa.github.io)

J'héberge sur ce blog mes expériences de noob dans le monde merveilleux du développement web. Le projet est hébergé sur Github Pages via un [dépôt github](https://github.com/dadatoa/dadatoa.github.io). Il tourne sous Jekyll dans sa version Github Pages afin de pouvoir servir le site sans produire de scripts de dev-ops. L'inconvénient est la limitation des possibilités d'ajouter des plugins, mais l'avantage c'est que ça simplifie vachement la tache!

## Une Roadmap

### Modifier la structure du site

Je vais créer une collection par section sur le site, et je mettrai la navigation dans un fichier `__data/navigation`. Ça me permettra de différencier les catégories du blog des sections du site.

- [ ] garder les collection *sections* et *posts*

- [ ] créer les collections *archives*, *projets* et *docs*

- [ ] créer un fichier `_data/navigation`qui contient les items de ma navigation principale *home*, *blog (posts)*, *docs*, *projets*, *archives* avec les urls/permalink correspondants

- [ ] adapter les layout *blog* et *sections* probablement en ayant qu'un seul layout, ou créer directement les pages d'accueil de section en html et les mettre dans un dossier (une collection?) *pages*

- [ ] pour la section *archives*, créer une page spécifique avec concaténation des contenus de toutes les sections (possible avec liquid)

### Déplacer les contenus dans leurs sections respectives

### Personnaliser le style du site

Je dois me débarrasser définitivement de *minima* et créer mes propres css.


















