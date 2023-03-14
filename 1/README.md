# Week 1

## Fin de processus

- signal SIGKILL :
  - (1ère fois on demande au processus de s'arrêter)
  - (2ème fois on force l'arrêt du processus)

## POSIX

Standard définissant les interfaces de utilisateurs et logiciellles, la ligne de commande, ...

### Histoire

- Unix était propriétaire mais cher
- BSD (Berkeley Software Distribution) était un peu plus libre mais pas assez
- GNU et Linux sont venus de nul part en se basant sur les standards POSIX et c'est un truc libre

### glibc

C'est la librairie standard de C pour GNU/Linux

## MinGW

- MinGW est une surcouche de Windows qui permet d'utiliser des programmes GNU/Linux
- N'existe plus depuis que Microsoft a sorti Windows Subsystem for Linux (WSL)

## Différents shells

- Bash
- Zsh -> performant
- Fish
- sh
- ...

## Commandes

- `ps` : affiche les processus en cours (-ax pour afficher tous les processus)
- `kill` : tue un processus
- `fg` : ramène un processus en arrière plan au premier plan
- `ls p*` : affiche les fichiers commençant par p
- `echo p*` : affiche tous les fichiers commençant par p
- `echo "p*"` : affiche p\*
- `TOTO=tata` : stocke tata dans la variable TOTO
- `echo $TOTO` : affiche tata (contenu de la variable TOTO)
- `echo "...$TOTO..."` : affiche ...tata... donc variables dans les doubles guillemets sont interprétées
- `echo '...$TOTO...'` : affiche ...$TOTO... donc variables dans les simples guillemets ne sont pas interprétées
- `echo "\'"` : affiche ' (guillemet simple)

## Lecteurs

- `C:` : lecteur C
- `A:` et `B:` : disquettes

## Windows vs POSIX pour les fichiers

- Chemins de fichiers
  - Windows : `C:\Users\Toto\Documents\`
  - POSIX : `/home/Toto/Documents/`

# Infos supplémentaires sur POSIX

- POSIX :`/` est la racine du système de fichiers
- `/dev` : dossier pour les devices
- `/home/user` : dossier pour les fichiers de l'utilisateur
- Créer par Richard Stallman

## VI

- vi est disponible selon le standard POSIX
- vi est un éditeur de texte
- vim est une version améliorée de vi (vi improved)

## Génération de nombres aléatoires

- vrai générateur de nombres aléatoires : TPM qui est un composant matériel sécurisé permettant de générer des nombres aléatoires
