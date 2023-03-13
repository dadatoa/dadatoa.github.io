---
pubdate: 2023-03-10T11:50:14.721Z
layout: post
pubate: 2022-07-14T03:58:03.803Z
upddate: false
title: Docker node... Ou pas?
description: "J'envisage de me lancer dans l'apprentissage de Strapi et de
  Astro. Les deux projets sont basés sur NodeJS, et je me suis naturellement dit
  que ça serait pas mal de Dockeriser les applications. J'ai eu un peu de mal à
  trouver de la doc, donc j'ai décidé de tester ça moi même. "
category: blog
tags: null
---
## Pourquoi faire ?

L'idée, comme globalement quand on veut mettre une app dans un docker, c'est de packer toute le projet et sont système dans un truc indépendant de tout le reste de la machine sur laquelle tu bosses. En général, soit tu fais ça pour pas polluer ta bécanes avec des dépendances qui peuvent entrer en conflit avec d'autres dépendances d'autres projets, ça arrive, soit parce que tu veux reproduire le plus fidèlement possible ton environnement de deploiement. 

### NPM / Yarn

NPM est le gestionnaire de packages et dépendances livré d'office avec Node, et Yarn en est un autre, vers lequel de plus en plus de dev se tournent. L'avantage de ces machins là, c'est qu'ils installent les dépendances du projet ***à l'intérieur*** du projet. Pas sur le système, pas dans un environnement de travail dédié au projet, mais vraiment dedans. Quand on installe un projet NPM, on crée un répertoire `node_modules` qui contient l'ensemble de toutes les dépendances du projet. Du coup, l'argument de créer un truc indépendant pour pas polluer ton hôte, ben il tient plus.

### Plusieurs version de Node

J'ai aussi découvert qu'on pouvait assez facilement (très) installer plusieurs versions de Node sur sa machine, et décider quelle version on veut utiliser. Et du coup, ça rend l'argument qui vise à reproduire l'environnement de déploiement un peu obsolète, du coup, pour cela il suffit d'utiliser la même version de NodeJS en dev que sur son environnement de déploiement. 

### Laisse béton

Pas encore! Il y a un cas d'usage auquel je me suis confronté pour lequel ça vaut quand même le coup d'avoir un `Dockerfile` perso : ***Gitpod***. *Gitpod*, c'est cool, et ça permet de faire du développement sur n'importe quelle bécane, dès lors qu'on a Internet et un navigateur (et des projets hébergés sur *Github*, *Gitlab*, ou *BitBucket*). Moi j'aime bien *Gitpod*. Et les workspaces sur *Gitpod*, il se lancent dans des container Docker. Donc en fait si, on va quand même y aller. 

## Gitpod

*Gitpod*, quand tu le lances, il charge et configure une image par défaut et règle son `.gitpod.yml` en fonction des langages qu'il trouve dans le projet. Ben t'as qu'à utiliser l'image par défaut! Oui mais non: déjà elle pèse un âne mort, et en plus elle marche pas très bien.

### 1. Dockerfile : lancement du projet

S'agissant de projet *NodeJs*, je me suis basé sur une image `node:16-bullseye`, *Node 16* étant la dernière version *LTS* de *NodeJS*, et je prend une image *Debian* car *Gitpod* n'aime pas (d'après leur documentation) les images autre que Debian. Je crée donc un fichier Dockerfile (sans extension) à la racine de mon dépôt:

```dockerfile
# Dockerfile
FROM node:16-bullseye

RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update
RUN apt-get install git sudo

RUN apt-get clean
RUN rm -rf /var/lib/apt-lists/* /tmp/* /var/tmp/*

#WORKDIR /opt/
#VOLUME  /opt/
#EXPOSE 3000
```

C'est assez simple, on pourrait presque utiliser une *Node16* de base sans la configurer. Les dernières lignes, `WORKDIR`, `VOLUME` et `EXPOSE` sont utiles quand on utilise Docker normalement, mais dans mon cas, c'est paramétré par *Gitpod*, donc techniquement tu peux les enlever ou les commenter. Moi j'ai choisi de les commenter, des fois que pour une raison que j'ignore je doive configurer un *Docker Node* localement. Pour info, Git et Sudo ne sont pas installés par défaut sur l'image *Node*, donc je les installe via `apt-get`. La première ligne `RUN echo...` sert à esquiver les questions auxquelles il faut répondre oui en y répondant automatiquement Yes... Sinon ça fait planter la génération de l'image Docker.

Pour info, j'utilise un `Dockerfile`, et pas l'image de base `node:16-bullseye` toute nue directement, à cause de l'absence de *sudo*: ça rend l'installation des paquets *Debian* problématique, puisque le terminal *Gitpod* s'ouvre automatiquement avec un utilisateur standard n'ayant pas de droit d'administration. Pas possible donc d'utiliser *apt* sans *sudo*. Comme ça, avec ces deux paquets, je peux lancer mon projet, et installer des paquets Debian si besoin (en principe ça ne doit pas arriver, mais on ne sait jamais).

### 2. .gitpod.yml

`.gitpod.yml` est le fichier de configuration de *Gitpod.* Au démarrage, je spécifie juste l'image sur laquelle je veux démarrer, qui est dans mon cas à construire d'après un `Dockerfile`:

```yaml
image:
  file: Dockerfile
```

Je compléterai plus tard. C'est le moment de lancer *Gitpod,* on va pouvoir s'amuser un peu. Une fois sur mon *workspace*, je configure mon projet *Node* dans un dossier à la racine du dépôt en suivant la doc de l'appli que je veux installer.

### 3. .gitpod.Dockerfile et .gitpod.yml V2

Jusqu'ici, tout se passe bien. Je vais cependant faire quelques modif. La configuration de base de Gitpod utilise un fichier `.gitpod.Dockerfile` (qui est un `Dockerfile` classique, il est juste préfixé par `.gitpod`). Je duplique mon `Dockerfile` et le renomme `.gitpod.Dockerfile`, puis je fais quelques modifs:

```dockerfile
# .gitpod.Dockerfile
FROM node:16-bullseye-slim

RUN echo "APT::Get::Assume-Yes "true";" >> /etc/apt/apt.conf.d/90forceyes

RUN apt-get update
RUN apt-get install git
RUN npm install -g npm@8.13.2

RUN apt-get clean
RUN rm -rf /var/lib/apt-lists/* /tmp/* /var/tmp/*

#WORKDIR /opt/
#VOLUME  /opt/
#EXPOSE 3000
```

Il n'y pas grand chose en plus, surtout des trucs en moins! J'avais buildé mon image localement pour voir, elle éclate le Go! Donc je fais avec plus light: on passe à une image node:16-bullseye-slim,Si j'ai bien configuré mon truc, je n'ai plus besoin de sudo, donc je le vire.

En parlant de bien configurer, et ça justifie le premier lancement avec la grosse image: quand j'ai installé mon package NodeJS avec npm, j'ai eu un message me disant que je devais mettre à jour npm. C'est une installation globale, pas un dépendance, j'ai donc eu besoin des droits administrateur pour l'installer, d'où l'importance de sudo. Maintenant, je configure mon Dockerfile pour que mon module soit installé dès le départ dans mon image, et je ferai de même à chaque fois que je devrai faire une install ou une MAJ d'un paquet / logiciel / whatever globale sur mon système.

On passe au .gitpod.yml:

```yaml
image:
  file: .gitpod.Dockerfile

tasks:
  - name: Astro_Yarn
    init: cd astro && yarn install
    command: cd astro && yarn dev
  - name: Git_root
    command: echo "terminal localisé à la racine - pour commandes git"

ports:
- port: 3000

github:
  prebuilds:
    # enable for the master/default branch (defaults to true)
    master: true
    # enable for all branches in this repo (defaults to false)
    branches: true
    # enable for pull requests coming from this repo (defaults to true)
    pullRequests: true
    # enable for pull requests coming from forks (defaults to false)
    pullRequestsFromForks: true
    # add a "Review in Gitpod" button as a comment to pull requests (defaults to true)
    addComment: true
    # add a "Review in Gitpod" button to pull requests (defaults to false)
    addBadge: false
    # add a label once the prebuild is ready to pull requests (defaults to false)
    addLabel: prebuilt-in-gitpod
```

C'est un peu plus chargé... En dessous du bloc image, j'ai mis un bloc tasks. Y'a une très bonne documentation [sur le site de *Gitpod*](https://www.gitpod.io/docs/configure), mais en gros, c'est pour lancer des commande avant ou au moment du lancement du *workspace* (en l’occurrence, ici, l'installation du module *npm Astro*).

Ensuite, le bloc ports. C'est ce que j'ai commenté dans mon `Dockerfile` en indiquant que c'était pris en charge par la configuration de *Gitpod*... Voilà.

Enfin le troisième bloc ne te sera utile que si tu héberge ton code sur *Github:* ça permet de déclencher les *Prebuilds*... c'est quoi ce truc? ben en fait, la génération de l'image *Gitpod*, et le lancement des première commande sont parfois méchamment longue... Du coup, moyennant un peu de config chez ton hébergeur de code et quelques commandes supplémentaires, tu peux automatiser tout ça. En gros, ce que ça fait ici: après chaque modifications sur n'importe laquelle de tes branches de ton repo, il se met sur la branche main et lance la génération de l'image Docker et le lancement des commandes `init` et `before` (bon là j'ai pas mis de `before`) ce qui fait que ton *workspace* se lancera beaucoup plus vite par la suite!

## Un petit mot sur le workflow

Je cherchais un peu comment j'allais organiser tout ça, étant donné que j'aime encore bien utiliser mon éditeur en local et que je n'ai pas besoin dans ce cas là de tout le bordel de Gitpod, et que j'ai envie que mon code soit encore à peu près clean. Ce que je vais faire, c'est que je vais créer 1 dépôt à partir de mon dépôt template Node, que je vais appeler *podnode16* en référence à la version de *NodeJS* que j'utilise. Je vais inclure dans ce dépôt tous les projets Node16 que je vais développer, en créant une branche par projet, et en utilisant submodule. Comme ça, je garde une base locale propre, et je n'ai pas besoin de faire des copier/coller dans tous les sens. Il me suffira de switcher d'une branche à l'autre pour changer de projet. En plus, *Gitpod* permet de créer un *workspace* associé à une branche spécifique, donc je peux créer un *workspace* différent par projet *Node*.

Pour les commandes du .gitpod.yml, qui peuvent varier d'un projet à l'autre, je vais créer 3 scripts:

* `before.sh` qui lancera les commandes à exécuter à l'état before
* `init.sh` qui lancera les commandes à exécuter à l'état init
* `command.sh` qui lancera les commandes à exécuter au lancement du *workspace*

Le bloc task du fichier `.gitpod.yml` ressemblera ensuite à ça:

```yaml
tasks:
  - before: sh before.sh
    init: sh init.sh
    command: sh command.sh
  - command: echo "lancement d'un terminal"
  
```

J'ai retiré `name` qui n'est pas indispensable, chaque objet Yaml (les tirets) correspond à un terminal, il est possible de lancer plusieurs terminaux en paralèlle et donc plusieurs commande (j'ai donc ici 2 terminaux). Je lance un premier terminal pour passer d'abord tout ce qui est *prebuild*, puis le script `command.sh` qui comportera les commandes pour démarrer le serveur de développement. C'est la raison pour laquelle je lance un deuxième terminal, ou je pourrai saisir les autres commandes que je souhaite passer à la main.