---
title: "Obsidian: configurer et installer le plugin Github Publisher"
slug: obsidian-github-publisher-setup
collection: _docs
tags: [obsidian, github, github-publisher, github-pages]
date: 2023-03-30
share: true
---

Pour pouvoir gérer le contenu de mon site Jekyll avec Obsidian, j'utilise le plugin Github Publisher, qui permet de créer des posts et des articles à partir des notes de ton *vault*.

## Ce que ça fait

Github Publisher te permet de prendre les notes qui sont dans ton *vault* et de les publier sur ton site Jekyll déployé à partir d'un repo Github. A priori je dis Jekyll, mais rien n'empêche de gérer comme ça n'importe quel contenu de site Jamstack que tu déploierais à partir d'un repo Github, qu'il soit hébergé sur Github-Pages, Vercel, Netlify ou un autre...

Par contre, ça transforme les fichier pour les publier dans ton repos, ce n'est pas un clône de ton *vault* sur Github, ce n'est donc pas adapté pour faire de la sauvegarde. 

Github Publisher va lire les notes qui sont dans ton blog, se connecter à ton repo Github, et les copier dans les dossiers de ton dépôt en fonction des règles que tu auras défini dans les settings du plugin. L'avantage c'est que tu ne clone pas le dépot localement, donc techniquement il n'y a pas a écrire de code, ce qui peut en faire une solution client intéressante, le cas échéant.

## Installation

C'est un Plugin de la communauté, par défaut les *vaults* sont configurés en safe mode, donc tu vas dans *Settings > Community plugins* et tu clique sur le bouton *Turn on community plugins*. Tu as miantenant accès aux plugins de la communauté, tu peux cliquer sur le bouton *Browse*. Tu as une barre de recherche, nous on veut Github Publisher, donc c'est parti! Une fois que tu l'as trouvé, tu clique dessus, tu arrives sur une page de présentation, tu peux lire la doc, mais surtout, clique sur *install* pour installer le plugin. Une fois installé, tu dois cliquer sur *enable* pour l'activer.

Si par mégarde tu n'as pas activé le plugin, c'est pas grave: tu peux retourner sur la page du plugin en allant dans *Settings > Community plugins > Browse*, et là tu as un *toggle button* pour n'affiché que les plugin installés... tu te rends sur la page du plugin que tu viens d'installer, et tu cliques sur *enable*.

## Configuration

Maintenant que ton plugin est installé, il faut le configurer pour accéder à ton dépôt Github. Tu vas dans *Settings > Github Publisher* (les settings des community plugins sont tout en bas dans le menu gauche des settings).

### Github configuration

Le premier onglet de settings est l'onglet *Github configuration* qui permet, comme son nom l'indique, de paramétrer la connexion a dépôt:
- **API type:** laisse sur free/pro/team à moins que tu aies un compte *Github entreprise*
- **Repository name:** le nom du dépot, pour moi comme c'est le dépôt de ma page *Github-Pages* c'est *dadatoa.github.io*
- **Github Username:** même chose, là c'est facile, c'est ton pseudo Github, donc *dadatoa* pour moi
- **Github Token:** le mode de connexion du plugin se fait par token Github. Je rentre pas dans les explications, mais pour obtenir ton token, tu peux soit le faire manuellement sur le site, soit utiliser le lien proposé dans les settings, qui propose un token préconfiguré avec les permissions nécessaires, je trouve ça plus simple. Tu cliques sur le lien, si t'es pas connecté à Github, tu vas devoir le faire, et t'arrives sur la page de configuration du toke. Tu dois personnaliser 2 trucs:
	- **note:** te permet d'identifier ton token (champs obligatoire)
	- **expiration:** par défaut sur 30 jours, tu peux personnaliser comme tu veux et mettre *no expiration*, mais Github ne recommande pas cette option pour des questins de sécurité. à toi de voir, si tu veux prendre le risque ou renouvelé ton token à intervalle régulier.
	Une fois que c'est fait, tu clique sur *Generate token*, et tu vas arriver sur une page qui t'affiche ton token, tu le copie et tu peux le copier dans le champs *Github token* de tes settings Github Publisher de retour sur Obsidian. Attention: après avoir fermé la page tokens de ton navigateur, tu ne reverras plus ton token, donc tu dois bien l'avoir copié avant. Par contre, je ne recommande pas d'en faire une sauvegarde, si tu le perds, tu e révoques et t'en génère un autre, c'est plus safe.
- **Main branch:** peronnellement, ma branche de publication sur mon site n'est pas la branche principale, mais la branche *gh-pages*. Je change donc la *main branch* pour mettre *gh-pages*, a toi de mettre la branche à partir de laquelle ton site est publié
- **Automatically merge pull request:** je le laisse activé. Lorsque tu publies une note, elle va être envoyé sur une branche dédiée sur ton dépôt; il te faudras alors faire un pull request pour fusionner la branche de ta nouvelle note avec ta branche de publication, cette option permet de faire ça automatiquement
- **Test connexion:** te permet de faire un essai pour voir si tout fonctionne, ça mange pas de pain.

Après, il y a un bloc **Github Workflow**, j'ai laissé toutes les options par défaut.

## Upload configuration

Ce 2ème onglet permet de configurer les options et les règles pour l'upload de tes notes sur le dépôt:
- **File tree in repository:** j'ai pas tout tester, mais en terme de fonctionnement, c'est l'option *YAML Frontmatter* qui me semble convenir à mes besoins. Voilà comment ça marche: tu vas définir une clé dans ton frontmatter qui indiquera dans quel repertoire de ton dépôt sera copié ta note, sans tenir compte du dossier en local. Je préfère ça et je téxplique pourquoi dans l'[ article précédent](obsidian-jamstack-vault.md). 
- **Default folder:** Il s'agit du dossier par défaut ou vont être uploadées les notes si *Github Publisher* ne trouve pas le dossier ou uploader les notes indiquée par le frontmatter. J'y ai remis mon dossier `collections`
- **Frontmatter key:** la clé du frontmatter que Github Publisher va analyser pour savoir dans quel dossier uploader les notes. Comme les dossiers sur mon repo correspondent à des collections paramétrée dans Jekyll, j'ai décidé d'appeler la clé `collection`. Comme tu as du le voir précédemment, ça donne un frontmatter qui ressemble à ça:
- **Root folder:** les répertoire racine dans lequel publier les notes. Dans la mesure ou j'ai fait en sorte que toutes mes publications se situent dans le même dossier `collections`, je règle cette valeur à *collections*.
- **Set the key where to get the value of the file name:** il s'agit de la clé de référence dont Github Publisher va se servir pour nomer les fichiers sur le repo. En effet, les fichier n'auront pas le même nom qu'en local, la valeur par défaut utilisée est title. Le problème, c'est que mes titres vont potentiellement avoir des accents, espaces, majuscules, qui vont poser problème à Jekyll lors de l'édition du site. Il me faut donc slugifier les titres, j'ai donc décidé de faire ça manuellement (en attendant de trouver mieux) et d'activer cette option puis de régler la valeur à *slug*.
- **Apply edit on the folder path or the filename:** d'après ce que je comprends, cette option me permet de slugifier les titres et de me passer du réglage précédent, cependant je suis une quiche avec les Regex et je n'ai pas réussi à configurer ça pour que ça fonctionne comme je veux.
- **Folder note:** si une note a le même nom que le dossier dans lequel elle se touve, *Github Publisher* la renome en `index.md`.
- **Auto clean up:** Je croyais qu'on pouvais pas dépublier des trucs... ben si en fait! suffisait d'activer cette option! Un champs apparaît quand tu actives, honnêtement, je m'en suis pas préoccupé, c'est pour protéger des dossier de l'autoc clean-up.

## Content's conversion

Cet onglet propose différentes options pour la conversion des notes en posts à l'upload sur le repo. Il se compose de 3 blocs:
1. **Main text**: j'ai laissé toutes les options par défaut pour le momment, je regarderais plus en détails si je rencontre des problèmes
2. **Tags:** la de même, j'ai laissé tout par défaut soit:
	- *Inline tags:* desactivé car je mets mes tags dans des listes YAML (c'est à dire entre crochet) et cette notation est bien géré par Obsidian comme par Jekyll
	- *Convert frontmatter / dataview field into tags:* je laisse vide, c'est pour transformer un autre champs du frontmatter en tags
	- *Exclude value from conversion*: je laisse vide également, c'est lié au champs précédent.
3. **Links:** ce bloc sert entre autre à convertir les liens wikilinks - entre double crochets - en liens markdown classique. En effet, si Obsidian gère bien les wikilinks et les utilise entre pour les liens interne aux notes, Jekyll ne les gère pas, il faut donc modifier tous les liens qui se trouvent dans les fichiers markdown pour les rendre compatible avec Jekyll:
	- *Internal links:* je l'active, si j'ai bien compris ça recalcule les adresses des liens en fonctions du dossier dans lesquels ils se touvent... à tester
	- *Convert internal links to unpublished note:* je pensais le désactivé, mais j'ai changé d'avis, c'est pas grave, les liens vers des articles non publiés renvoiront une 404
	- *`[wikilinks](wikilinks.md)` to `[MDlinks](links)` :* de nouveau j'active, il me conerti tous les liens wikilinks en liens markdown classique, ce qui fait que je peux continuer à utiliser des lien wikilinks dans mes notes même s'il ne sont pas supporté par Jekyll

## Embed

Cet onglet défini le comportement des pièces jointes (images par exemple) et ou les télécharger (le cas échéant). Je désactive la première option *Transferts attachments* car je veux utiliser cloudinary pour les médias, bien que je ne sache pas comment l'intégrer à Obsidian pour le moment. Je laisse les deux autres champs vides par défaut.

## Plugin settings

Le dernier onglet avant l'aide défini le comportement et les commandes définies dans Obsidian, je laisse toutes les valeurs par défaut, s'il me manque des trucs j'irai voir ce que je peux changer. Tu dois te rappeler du premier item de configuration: **Share key**; c'est la clé frontmatter qui va définir si ta note est à publier ou nom. Par défaut elle est à *share*, ce qui me semble bien, mais tu peux la changer si tu veux.

## Racourcis clavier

C'est un dernier élément de configuration qui n'est pas dans les settings du plugin directement, le moyen le plus simple d'y accéder c'est de passer par *settings > community plugins > browse* et de sélectionner Github Publisher. Tu veras qu'il y a un bouton *hotkeys* qui te permet de créer des racourcis claviers pour les commandes de Github Publisher.

## Et ensuite, on fait marcher tout ça

Tu as tout configuré, tout semble fontionner. Donc maintenant, t'as plus quà écrire! Et après, quand tu auras deux trois posts à rédiger, je t'emmennerai dans la *command palette*.