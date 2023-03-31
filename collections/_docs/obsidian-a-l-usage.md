---
title: "Obsidian: à l'usage"
slug: obsidian-a-l-usage
collection: _docs
tags: []
date: 2023-03-31
share: true
---

J'ai pondu quelques articles, il est temps de voir comment j'upload tout ça sur mon dépôt Github.

## Formater les articles

Avant de pousser les notes vers le dépôt, vérifie quand même le formatage de tes notes, en particulier des frontmatters. Rapelle-toi la [ configuration du plugin](obsidian-github-publisher-setup.md) et celle de ton site:
- **title:** *(string)* c'est le titre des posts et articles dans mon Jekyll, si pas de titre, pas d'affichage
- **collection:** *(string)* j'ai défini que cette clé indiquait le dossier ou allait être uploadée les notes
- **slug:** *(string)* c'est la clé de référence que j'ai choisi pour créer le nom de fichier sur le dépôt
- **tags:** *(array)* je n'ai pas indiqué que je voulais un reformatage des tags, il faudra bien les écrire sous forme de liste entre crochets pour permettre à Jekyll de les interpréter correctement
- **share:** *(boolean)* j'ai laissé la valeur par défaut dans le dernier onglet, c'est la clé qui défini si la not doit être uploadée ou non.
- Je rajoute une clé **date** qui doit être formattée *AAAA-JJ-MM* pour toutes les notes qui ne sont pas des posts de blog (pour les posts de blog, la date est dans le slug sous Jekyll) ainsi qu'une clé **update** *(même format)* facultative qui si elle est rensignée indique que la note a été mise à jour par rapport à sa date de publication

Ce qui fait que chaque note doit au minimum avoir toutes ces valeurs de frontmatter paramétrée si je veux que le système fonctionne, par exemple:

```yaml
---
title: "Mon super titre"
collection: _posts
slug: 2023-03-31-mon-super-titre
tags: [tag1, tag2, tag3]
share: false
---
```

J'aurais quelques petits paramétrages à faire côté Jekyll pour que mes clés date et update soient bien interprétées dans mes templates, mais rien méchant.

## Publier plusieurs notes

Pour se faire, tu t'assures déjà que tu as des notes avec les bonnes info dans leur frontmatter, et en particulier une clé **share** dont la valeur est à *true*. Ensuite tu clique sur le bouton `>_` qui ouvre la *command palette* et tu clique sur *Github publisher: Upload all shared notes* ce qui aura pour effet d'envoyer toutes les notes dont la clé *share* est à true vers ton dépôt Github sur la branche spécifiée.

## Ah oui mais non, j'ai publié trop vite

C'est pas grave, t'as activé *auto clean-up*! Dans ton *vault*, dans le frontmatter de toutes les notes que tu veux dépublier, tu passe la valeur de *share* à *false*. Ensuite, de nouveau *command palette* `>_`, et tu clique sur *Obsidian: Purge unpublished and deleted files*. Et là pouf, toutes les notes de ton vault que tu veux dépublier dégage de ton repo Github.

Alors par contre, en faisant le test, j'ai eu une mauvaise expérience... il se trouve que j'avais déjà des posts publiés d'avant dans mes collections, et quand le plugin fait le scan, en gros il synchronise avec ton *vault*. Du coup il a supprimer tout ce qu'i n'était pas dans le *vault*... J'ai bien fait de pas bosser sur ma branche principale! cependant, comme j'ai fait ça sur mon vrai dépôt, sur ma vrai branche de pubication, ça a fait sauter tout le contenu de mon site, ce qui n'est pas très grave, encore une fois, puisque tout est toujours sur ma branche master, mais enfin, c'est un peu relou.

Conclusion: si tu active *auto clean-up* dans le plugin Github Publisher, et que tu a déjà un site qui tourne, fait en sorte de rapatrier tout ce qui est déjà publier dans ton *vault* si tu ne veux pas avoir de sales surprises.

## Publier les notes une par une

Je pense qu'une fois que le site est lancé, c'est un peu plus safe: tu écris ta note, tu fait ton frontmatter bien propre, tu te relis pour être sûr, et une fois que tu est sûr de ton coup, tu peux publier:
- tu commences par passer la valeur de *share* à *true* dans le frontmatter de ta note
- `>_` (*command palette* ) > *Github Publisher: Upload single current active note*. Tu ne publiera comme cela que la note sur laquelle tu viens de finir de travailler. 
	**Observation:** si ta note n'est pas prête à être publier (dans mon cas, si la 
	valeur de *share* n'est pas à *true*, cette commande n'apparaît pas). 

## D'autres options

Github Publisher propose d'autres commandes utiles pour faire des actions groupées pour plusieurs notes: rafraîchir les notes déjà publier, ré-uploader toutes les notes, uploader les notes non publiées, uploader les nouvellees notes publiées et rafraîchir les anciennes, je te refais pas de topo.

Enfin, la dernière commande de Gitub Publisher pour Obsidian est:
*test the connexion to the configured repository* qui peut être bien pratique pour s'assurer qu'on ne s'est pas planté dans la config du plugin à l'ongelt *Github Configuration*