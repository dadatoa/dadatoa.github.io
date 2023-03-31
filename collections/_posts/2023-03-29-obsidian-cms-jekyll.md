---
title: "Utiliser Obsidian comme CMS pour Github Pages"
slug: 2023-03-29-obsidian-cms-jekyll
collection: _posts
tags: [obsidian, jekyll, github-pages]
share: true
update: 2023-03-31
---

Je suis toujours à la recherche du workflow ultime pour éditer posts sur Github Pages sans trop galérer. Je teste Obsidian et moyennant quelques plugins, ça semble  pas trop mal.

J'avais testé Notion, mais c'est trop gros, c'est le bordel à prendre en main, et c'est pas pratique pour sortir des fichiers markdown de l'application... Je voulais quelque chose de plus simple. 

Jusqu'à maintenant j'utilisait *Netlify CMS* rebrandé [*Decap CMS*](https://decap-cms.org) (le domaine d'origine [netlifycms.org](https://netlifycms.org), redirige désormais vers la page d'acceuil de *Decap*). C'est vachement bien, hyper personnalisable mais... un peu lourd de configuration déjà, et pour écrire du markdown, c'est pas confortable, j'aime pas. Je suis donc toujours à la recherche d'une alternative, au moins pour la partie publication (*Decap* pour l'administration du site reste pas mal si Jekyll et Decap sont configurés aux petits oignons, et Obsidian ne gère pas les données yaml en dehors des frontmatter des fichiers markdown).

## Obsidian

Obsidian est une application closed sources de prise de notes. Elle fonctionne avec de simples fichiers markdown, supporte les frontmatter en Yaml, et dispose de pas de plugin et d'une communauté assez dynamique sur la question. Ce qui en fait une excellente candidate de prime abord pour satisfaire mon besoin. Y'en a qui diront "c'est pas open source", ils ont pas complètement tort, mais j'ai pas trouvé de truc qui soit open source et qui me satisfasse. 

### Markdown comfortable

Franchement l'éditeur est cool, bien personnalisable, on peu ajouter de thème. Le frontmatter Yaml dispose de la coloration syntaxique, ce qui est apréciable, et on peu le masqué quand on est en mode vissualisation. Franchement, si j'avais trouvé cet outil avant de débuter mon blog Jekyll, je me serais peut-être contenter de ça... Puisqu'à l'origine, mon Jekyll Github Pages a surtout vocation à me servir d'auto-doc/wiki/je sais plus comment on fait tel truc et j'ai pas envie de chercher 3 heures sur le net.

### Des plugins

C'est là que ça devient cool: y'a des plugins pour un peu tout, et notamment y'en a plusieurs qui se connectent à Github. Il y a entre autre un plugin dédié pour la publication de notes sur un blog  statique dont le dépôt est hébergé sur Github... est ce que ce serait pas exactment mon cas? 

## Le workflow (espéré...)

### Le principe

En gros je crée un *vault* dans un dossier sur ma bécane qui va héberger un certain nombre de notes, que je peux organiser en sous dossiers. Je peux aussi crée plusieurs *vaults* qui sont un peu comme des espaces indépendants.

### Workfow

Du coup l'idée c'est de créer un *vault* connecté à mon repo [dadatoa.github.io](https://dadatoa.github.io) et comme ça quand je crée une note, avec un bouton paf je la publie sur le blog. Idéalement avec sépartion dans les différentes collections sans que j'ai à refaire toute l'orga que je viens déjà de modifier...

## Et alors, ça donne quoi?

J'ai encore quelques essais à faire, mais j'ai écrit ce poste avec Obsidian, ça marche plutôt bien! J'ai aussi fait quelques essais avec le plugin *Github Publisher* et c'est assez satisfaisant. Y'a pas besoin de clôner le repo en local, le plugin est configuré por faire les modification nécessaires pour transformer, et pousser les publications directement sur Github. On peut publier un post, le modifier, mais ~~j'ai pas réussi à dépublier... Dans ce cas il faudra sûrment faire la supression à la main sur le dépôt, à voir, je dois encore faire quelques tests~~. *Update (31/03/2023): après avoir fais le test ([ voir ici](obsidian-a-l-usage.md)), il y a une option de configuration qui active une commande permettant de supprimer tout les fichiers qui ne sont pas publiés ou pas dans le vault*. Je vais me faire un petit guide d'ailleurs pour configurer le plugin correctement.