---
title: "Obsidian: la base"
slug: obsidian-a-l-usage
collection: _docs
tags: [obsidian]
date: 2023-03-29

---
Obsidian est une application qui permet la prise de note dans des fichiers markdown, directement stocké dans un dossier sur la machine en local. Il est possible d'adhérer au service (payant) qui permet de stocker ses notes sur leurs serveurs.

Cependant, Obsidian n'étant pas opne source, bien que ses conepteurs/dévelopeurs aient l'air de bonne fois, à titre perso je préfère garder mes fichiers privés en local, ou à l'extrème limite sur des trucs pas trop sensible les mettre sur un dépôt git hébergé en privé. J'envisage de l'utiliser comme système de gestion de contenus (*CMS*) pour mon site Jekyll hébergé sur Github-Pages [ (voir là)](2023-03-29-obsidian-cms-jekyll.md).

## Organisation des fichiers

Quand tu ouvres l'application, tu es invité à ouvrir ou créer un *vault* local ou à ouvrir un *vault* en ligne. Pour cette 3ème option tu dois être connecté avec un compte à l'application. Moi je préfère, autant que faire se peut éviter de me logger systématiquement sur toutes les plattesformes, mais données privées sont bine assez publiquescomme ça...! 

Donc tu crée ton *vault*, qui va être en gros le dossier racine de ton espace de prise de notes, dans lequel tu peux créer des notes, donc, qui sont simplement des fichiers markdown avec possiblement un frontmatter, et des dossiers dans lesquels tu vas pouvoir stockés tes notes si tu souhaites les organiser un peu. L'arborescence de fichiers/dossiers que tu crées dans l'application se retrnascrit telle quelle sur ton disque dur, ce qui en facilite la gestion. Il y a juste un *dotfile* qui est créé à la racine de ton *vault* et qui va contenir les métadonnées du *vault* et les différent réglages qui lui sont propres.

D'ailleurs, tu noteras que si tu tu crée un autre *vault*, les réglages et même les plugin que tu auras installlés dans le premier ne seront pas présent dans le second, chaque *vault* est indépendant de ce point de vue là.

## Markown + Yaml

C'est un combo classique que tu peux retrouver souvent sur les générateurs de sites statiques, dont je suis particulièrment fan, et sur celui qui est peut-être le plus utilisé: Jekyll.

#### Markdown

C'est une façon d'écrire du texte facilement qui pourra être reformatté tout aussi facilement par un programme pour sortir d'autre format plus adaptés à la présentation, comme du html sur le net par exemple. C'est un markdown de base avec un petit truc en plus: le formatage des liens entre doubles crochets façon wiki. Tu peux lier tes notes à l'aide de se type de lien à l'intérieur de ton *vault*. Il est aussi possible d'utiliser le formatage des liens markdown classique. Pour le formatage du texte, les outils wysiwyg sont dans le menu format, pas super ergonomique d'accès, donc c'est pas mal de connaître la syntaxe markdown pour écrire du texte.

#### Yaml

C'est comme avec Jekyll: tous les fichiers markdown peuvent avoir une en-tête en Yaml. C'est un langage de formatage de données (un peu comme le xml ou json) qi à l'énorme avantage d'être facile à lire pour nous-autres, êtres humains. Ici il va te servir à indiquer des méta-données pour chacune de tes note, ça peut être par exemple:
- un titre
- une date de création / de publication / de modification
- la catégorie dans laquelle tu veux ranger ta notes
- des tags
- liste non exhaustive (...)

## Ecrire une note

Si comme moi t'as déjà un peu joué avec Jekyll ou Github-Pages, écrire une note sous Obsidian ressemble beaucoup à écrire une page ou un post pour le publier sur Jekyll. J'ai configuré mon *vault* pour que les nom de fichier n'aparaissent pas en gros en haut de la note, je trouve ça plus lisible, et de toutes façons, l'arborescence de fichier se trouve dans le panneau gauche.

### Source Mode

Lorsque tu écris une note, tu peux basculer en *Source Mode* dans le menu *View* de la barre d'outil. Ce mode te mermet d'afficher les tags Markdown sur ta page pour avoir un contrôle plus fin de la forme de ta note, ou de repérer les éventuelles erreur de formatages, les conflits entre les balises bizarrement interprétés, ce genre de chose.

### Mode de lecture

Si tu vas faire u tour dans le menu *View* de la barre d'outil, tu veras que tu as une *Reading View* (raccourci `<option> + E`). Ce mode désactive la  capacité d'écriture et propose une affichage pour la lecture seulement. Ça évite de modifier des rucs dans les notes par inadvertance quand on veut juste se relire... d'autant qu'à priori Obsidian enregistre les modifications en continu et de façon transparente.

### formatage des notes

Vu que j'envisage de me servir de se *vault* comme d'un genre de CMS pour mon site Github-Pages, je formate mes notes en conséquence:
- j'ai reproduit les dossiers correspondant à mes collections
- je nomme mes fichier (au moins pour ce qui va devienir un post de blog) selon les standards des posts Jekyll
- je ne mets pas de titre de premier niveau dans ma note, mais j'indique le titre de la note dans le frontmatter.
Ce qui est plutôt cool aussi c'est que Obsidian supporte par défaut les tags, que tu peux ajouter à l'aide d'une une clé `tags` dans ton frontmatter, organisé sous forme d'une liste yaml entre crochet, ce qui permet de respecter également la syntaxe de Jekyll. Les tags s'affichent dans le penneau repliable droit de l'application. 

## Lier les notes

En plus des liens classiques que tu peux écrire en markdown sous la forme `[texte du lien](url/du/lien)`, Obsidian supporte les wikilinks pour les lien internes, dont la syntaxe est la suivante: 
```markdown
[cible-du-lien](cible-du-lien.md)
```

Ou bien, si tu veux personnaliser le texte du lien:
```markdown
[ texte du lien](cible-du-lien.md)
```

L'ensemble des notes de ton *vault* peuvent être ensuite affichées dans un *graph* ou les notes sont représentées par des points reliés entre eux en fonction des liens.

Le seul inconvénient majeur des wikilinks, c'est qu'ils ne sont pas supportés par défaut par Jekyll. Donc en vue de publier les notes de mon *vault* sur Github-Pages, c'est à prendre en compte. Il me semble que le plugin que je compte utiliser pour mes publication gère la conversion des liens wikilinks. Si ce n'est pas le cas, je vais devoir modifier tous les liens que j'aurais écrit en wikilins pour les convertir en lien markdown classiques, ou éventuellement trouver un plugin Jekyll qui gère les wikilinks, mais si ça éxiste, il ne sera pas supporté par Github-Pages. Mais c'est pas (encore) le sujet!

## Les templates

Obsidian propose également un système de template pour préformater les notes. Je vais pouvoir automatiser de cette manière une partie de la création de mes notes en vue d'une publcation sur mon site, en particulier au niveau du frontmatter. J'avoue, j'ai pas encore trop explorer la question, mais dès que j'ai correctement configuré le plugin Github Publisher, je m'attaque au templates!

## What next?

Maintenant que t'as un peu joué avec Obsidian, il est temps de le connecter à ton repo Github pour gérer ton contenu sur github Pages (ou Netlify ou n'importe quel hebergeur Github based). L'option que j'ai choisi c'est donc d'installer le plugin *Github Publisher*, à voir [ ici](obsidian-github-publisher-setup.md).