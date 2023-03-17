---
title: "Je débute le scrapping avec Python"
description: "Dans ce premier articles, je vais configurer mes outils et mon environnement de développement Python 3."
category: docs
tags:
- python
- venv
- scrapping
pubdate: 2023-03-17T05:05:32.926Z
layout: post
---

## Venv

*Venv* permet de gérer son environnement de développement, un peu comme on le ferait avec *npm* sous *javascript* par exemple. L'insstallateur de paquets s'appelle *pip*. la première chose à faire lorsqu'on démarre un projet python est donc de s'assurer de créer un environnement de développement avec *venv*. Pour celà, j'ouvre un terminal et je me rends dans le dossier racine de mon projet (*myapp*) et je tappe:

```bash
[dadatoa.github.io myapp]$ python3 -m venv myvenv
```
Cela va créer un dossier *myvenv* (du nom que j'aurais donné à mon environnement *venv*) à la racine de mon projet qui va contenir tout ce qui est nécessaire pour définir et faire fonctionner mon envronnement de développement, notemment les packages installés via *pip* le seront localement dans ce repertoire.

Pour activer mon environnement de développement:

```bash
[dadatoa.github.io myapp]$ source myvenv/bin/activate
```
On est maintenant dans notre environnement de développement. 

**C'est en général le bon momment pour activer un repo *git* ;-)**

J'installerai les paquets avec le gestionnaire de paquets *pip* en utilisant la commande `pip install [NOM DU PAQUET]`. Si pour une raison j'ai besoin de reporduire cet environnemnt de développement avec la même configuration, je peux saisir la commande `pip freeze`. Cela va m'afficher en sortie dans le terminal l'ensemble des paquets que j'ai installé.

```bash
[dadatoa.github.io myapp]$ pip freeze
aiofiles==22.1.0
aiosqlite==0.18.0
anyio==3.6.2
appnope==0.1.3
argon2-cffi==21.3.0
argon2-cffi-bindings==21.2.0
...

```
Je ne vais pas pouvoir utiliser ça comme ça, je dois l'enregistrer quelqupart dans un fichier texte. Soit je copie/colle toute la liste, soit je passe une commande pour tout mettre dans un fichier `requirements.txt` par exemple (le nom du fichier importe peu): `pip freeze > requirements.txt`.

Je peux ensuite quitter l'environnement:

```bash
[dadatoa.github.io myapp]$ deactivate
```
Et si je veux créer un autre environnement similaire, je me rend à la racine du nouveau projet, j'y copie mon fichier `requirements.txt`. Ensuite, je peux créer mon environenment de développement, l'activer, et passer la commande `pip install -r requirements.txt` pour reinstaller tout mes packages dans mon nouvelle environnement *venv*.

```bash
[dadatoa.github.io my_other_app]$ python3 -m venv myvenv
[dadatoa.github.io my_other_app]$ source myvenv/bin/activate
[dadatoa.github.io my_other_app]$ pip install -r requirements.txt 
```


## OhMyZsh

J'utilise le terminal Iterm2 sous mac, mais n'importe quel terminal fera l'affaire. C'est un terminal zsh que je personnalise avec [OhMyZsh](https://ohmyz.sh/) [(github)](https://github.com/ohmyzsh/ohmyzsh). Je peux personnaliser OhMyZsh avec des plugins (voir tout en bas de la page d'accueil du site) ou sur [github](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins). OhMyZsh est préconfiguré avec le [plugin Git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git) et possède également un [plugin pour Python](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python), ce qui m'arrange bien. Si tu te mets aussi à coder un peu, c'est le genre d'outil qui peux te faciliter pas mal la vie et te rendre ton expérience plus agréable.