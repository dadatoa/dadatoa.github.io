# Un nouveau projet

J'ai décidé de changer l'orientation de ma page [dadatoa.github.io](dadatoa.github.io). Plutôt qu'un site blog/page perso/documentation perso, je vais plutôt l'utiliser comme un genre de portfolio pour documenter mes futurs projets hébergés sur Github. Le premier d'entre eux, ça va être celui-ci.

## Jekyll

J'ai un objectif de relative simplicité et de possibilité d'évolution futures... Je vais donc utiliser Jekyll et le rendu automatique Github Pages dans un premier temps. On vera par la suite les améliorations possibles. J'ai un petit cahier des charges préalable, qui va me permettre de savoir ou je vais sur mon projet :

- Je vais utiliser les plugins suivant supportés par Github Pages :
  - _github-readme-index_ : permet d'utiliser le README.md du projet comme page d'index du site
  - _github-optional-front-matter_ : permet de ne pas être obligé de spécifier un front-matter sur tous les fichiers. Dans mon cas, avec le plugin précédent, ça me permet de ne pas ajouter de front-matter à mon fichier README, ce qui facilite un peu la lecture s'il est consulté directement sur [github](https://github.com/dadatoa/dadatoa.github.io)
  - _github-default-layout_ : permet d'avoir un layout par défault lorsque qu'aucun layout n'est spécifié. Là encore, dans le cas de mon README, je peux avoir un layout par défaut pour l'afficher même si je n'ai pas de front-matter dans le fichier
- je souhaite pouvoir utiliser des wikilinks pour les liens internes, il y a un plugin en cours de développement ([là](https://github.com/manunamz/jekyll-wikilinks)) mais il n'est pas intégré à la liste de plugin supporté par Github Pages, je vais donc utiliser la méthode qui consiste à implémenter la conversion des wikilinks directement dans les templates liquid d'après [ce projet](https://github.com/jhvanderschee/brackettest)
- pour le css, Jekyll intègre par défaut la gestion de _sass_. Néamoins, avec les dernières avancées de css, et notemment l'ajout des variables, _sass_ n'est plus aussi intéressant qu'avant. du coup je vais m'en passer et utiliser du css classique pour ce projet. J'aurais bien testé _post-css_ maisune nouvelle fois, le plugin n'est pas supporté par Github Pages.

## Developpement

### Environnement local

Github Pages utilise des [versions anciennes](https://pages.github.com/versions/) des applications, notamment en ce qui concerne Ruby et Jekyll. Pour ne pas avoir à gérer d'éventuels conflits avec d'autres projets et applications en local, je vais utiliser un conteneur Docker pour mon application en local.
