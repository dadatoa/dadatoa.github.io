---
title: "Jekyllisation d'un thème html5up : Hyperspace"
section: docs
categories:
tags:
date: 2022-06-28T10:48:54.416Z
layout: post
---
J'ai décidé de Jekylliser un thème HTML fourni par [html5up](https://html5up.net/). Le thème est sous licence Creative Commons Attribution et je le trouve assez sympa. N'hésite pas à faire un tour sur le [dépôt Github](https://github.com/dadatoa/hyperspace-html5up-jekyll) du projet !

## Un thème html5

C'est assez facile à intégrer finalement avec *Jekyll*. Celui-ci se compose essentiellement d'une *landing-page* et d'une page générique. La *landing-page* contient 4 section : 

* une intro
* une partie avec une liste d'éléments avec une illustration
* une partie avec une liste d'éléments avec une icône *Font-Awesome*
* une partie contact

## 1. Structure

Pour structurer ma *landing-page*, j'ai décidé de m'appuyer sur un *Front Matter* assez costaud sur ma page index.md. J'ai essayé de faire autrement, mais c'est ce qui me semblait le moins chiant à maintenir. Donc le front Matter contient un objet pour chaque section de la page d'acceuil, avec quelques caractéristiques dont le layout home aura besoin :

1. `id`: correspond à l'id de l'id de la section sur la page d'accueil qui permettra de mettre ne place les anchor links
2. `title`: le titre de la section, qui sera repris dans la navigation
3. `template`: comme chaque section aura des différence d'affichage, ça permet au layout de repérer comment afficher les données. 

Pour le reste, ça va dépendre de ce qu'on mets dans chaque section. L'avantage de la technique c'est qu'elle permet un peu de personnalisation sur la *landing-page*, sans forcément toucher aux `layouts`.

Je passe vite sur l'intro qui est assez courte: j'ai décidé d'y intégrer des éléments qui seront défini dans le fichier de config *Jekyll*: une description et le titre du site. Voilà, rien de particulier. Ensuite se trouve un lien *scroll down* auquel je ne touche pas, il me va bien comme ça.

## 2. *one* et *two*

Ce sont les principales section de ma *landing page* : comme elles vont lister des éléments, j'ai besoin de spécifier la source des objets qui vont être listés. Pour me simplifier la vie, j'utilise la collection Jekyll posts pour la section `one`. Pour la section `two`, j'y ai mis comme source la collection jekyll pages, mais on pourra créer une collection adaptée. Les valeurs assignée à `color-style` et `animate` correspondent à des classes du thème *Hyperspace* qui définissent un style de couleur et la façon dont les éléments *html* apparaissent lors du l*asy loading*. 

Comme l'exemple proposé par html5up affiche une phrase introductive à ces sections, j'ai ajouté une clé description qui sera récupérée dans le *layout* si il y a besoin d'une introduction.

## 3. *three*

Il s'agit du bloc de contact. J'ai préparé deux `templates`: un qui reprend strictement le thème *hyperspace* avec le formulaire, et un second, ou le formulaire est remplacé par un lien de type `mailto`. Ça permettra de ne pas s'emmerder à rajouter du code et une connexion à une base de donnée ou à une API.

## Conclusion

Après avoir galéré un peu, mon thème est utilisable avec *Jekyll* sur *Github Pages*. Cependant, il n'est pas super adapté pour un blog, plutôt sur un site vitrine de tech. J'ai pas essayé de connecter le formulaire de contact à une API, et je me rend comte que globalement, le thème ne répond pas trop à mes besoins... je vais donc essayer autre chose.