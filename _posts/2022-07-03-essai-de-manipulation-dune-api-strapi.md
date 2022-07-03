---
update: 2022-07-03T12:33:31.722Z
date: 2022-07-03T12:33:31.737Z
layout: post
slugname: "{{year}}-{{month}}-{{day}}-{{slug}}"
title: "Essai de manipulation d'une API : Strapi"
tags:
  - strapi
  - api
---
Je vais tenter de déployer strapi sur un mutualisé. D'abord, un docker en local, et ensuite, c'est parti.

## Installation en un click chez l'hébergeur

En réalité, mon hébergeur me propose une install en 1 click de Strapi. J'ai essayé vite fait pour voir, le problème c'est que la config de strapi ne peut se faire qu'en développement. Je vais donc essayer de cloner mon répertoire Strapi chez l'hébergeur en local, en l'initialisant comme un repo Git. Ensuite, je vais me monter des images Docker pour pouvoir reproduire l'environnement de mon hébergeur en local. Pour les images, je veux du Debian car je veux pouvoir les utiliser sans bug sous Gitpod. L'image Docker de Strapi officielle est sous Alpine Linux, pas de bol !