---
title: docker node... où pas?
update: 2022-07-14T03:58:03.803Z
date: 2022-07-14T03:58:03.908Z
layout: post
---
J'envisage de me lancer dans l'apprentissage de Strapi et de Astro. Les deux projets sont basés sur Node JS, et je me suis naturellement dit que ça serait pas mal de Dockeriser les applications. J'ai eu un peu de mal à trouver de la doc, donc j'ai decidé de tester ça moi même. Sauf qu'en fait, les cas d'usage sont un peu limités...

## Pourquoi faire ?

L'idée, comme globalement quand on veut mettre une app dans un docker, c'est de packer toute le projet et sont système dans un truc indépendant de tout le reste de la machine sur laquelle tu bosses. En général, soit tu fais ça pour pas polluer ta bécanes avec des dépendances qui peuvent entrer en conflit avec d'autres dépendances d'autres projets, ça arrive, soit parce que tu veux reproduire le plus fidèlement possible ton environnement de deploiment. 

### NPM / Yarn

NPM est le gestionnaire de packages et dépendances livré d'office avec Node, et Yarn en est un autre, vers lequel de plus en plus de dev se tournent. L'avantage de ces machins là, c'est qu'ils installent les dépendances du projet ***à l'intérieur*** du projet. Pas sur le système, pas dans un environnement de travail dédié au projet, mais vraiment dedans. Quand on installe un projet NPM, on crée un répertoire `node_modules` qui contient l'ensemble de toutes les dépendances du projet. Du coup, l'argument de créer un truc indépendant pour pas polluer ton hôte, ben il tient plus.

### Plusieurs version de Node

J'ai aussi découvert qu'on pouvait assez facilement (très) installer plusieurs versions de Node sur sa machine, et décider quelle version on veut utiliser. Et du coup, ça rend l'argument qui vise à reproduire l'environnement de déploiement un peu obsolète, du coup, pour cela il suffit d'utiliser la même version de NodeJS en dev que sur son environnement de déploiement. 

### Laisse béton

Pas encore! Il y a un cas d'usage auquel je me suis confronté pour lequel ça vaut quand même le coup d'avoir un `Dockerfile` perso : ***Gitpod***.*Gitpod*, c'est cool, et ça permet de faire du développement sur n'importe quelle bécane, dès lors qu'on a Internet et un navigateur (et des projets hébergés sur *Github*, *Gitlab*, ou *BitBucket*). Moi j'aime bien *Gitpod*! Et les workspaces sur *Gitpod*, il se lancent dans des container Docker.

## Gitpod

*Gitpod*, quand tu le lance, il charge et configure une image par défaut et règle son `.gitpod.yml` en fonction des langages qu'il trouve dans le projet. Ben t'as qu'à utiliser l'image par défaut! Oui mais non: déjà elle pèse un âne mort, et en plus elle marche pas très bien.