# Week 6

# GitHub

## Etats avant commit

- `untracked` : fichier non suivi par git
- `modified` : fichier modifié mais non ajouté au prochain commit
- `staged` : fichier ajouté au prochain commit

## Glossaire

- `HEAD` : pointe sur le dernier commit (c'est où on travaille actuellement)
- `master` : branche principale
- `staged` : fichier ajouté au prochain commit
- `branch` : branche (n'est rien d'autre qu'un pointeur vers un commit)

## Commandes

- `git init` : initialise un dépôt git
- `git add` : ajoute un fichier au dépôt
- `git commit` : enregistre les modifications
- 'git log' : affiche l'historique des commits
- `git log --one-line` : affiche l'historique des commits en une ligne
- `git log --graph` : affiche l'historique des commits sous forme de graphe
- `git log --stat` : affiche l'historique des commits avec les statistiques (nombre de lignes ajoutées/supprimées + fichiers ajoutés/supprimés, ...)
- `git checkout <commit> <fichier>` : récupère un fichier d'un commit donné
- `git checkout <commit>` : se positionne sur un commit donné
- `git checkout <branche>` : se positionne sur une branche donnée
- `git switch <branche>` : se positionne sur une branche donnée
- `git branch <nom>` : crée une branche
- `git fetch` : récupère les commits d'un dépôt distant

La différence entre `fetch` et `pull` est que `fetch` récupère les commits sans les appliquer, alors que `pull` récupère les commits et les applique.

La commande `git pull` est en fait un raccourci pour `git fetch` suivi de `git merge` ou `git rebase` si le dépôt distant a été configuré pour utiliser `rebase` au lieu de `merge` par défaut.

Fonctionnement normal :

```console
git pull --rebase # stratégie de rebase
git pull # stratégie de merge
```

## Exemple

Exemple de checkout :

```bash
➜  orange git:(master) echo "hfhfhfhf" >> test.py
➜  orange git:(master) ✗ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test.py

no changes added to commit (use "git add" and/or "git commit -a")
➜  orange git:(master) ✗ git commit -am "commit 2"
[master b7395fa] commit 2
 1 file changed, 1 insertion(+)
➜  orange git:(master) git log --oneline
➜  orange git:(master) git log --oneline --graph
➜  orange git:(master) git log --oneline --graph --all
➜  orange git:(master) cat test.py
bhabds
hfhfhfhf
➜  orange git:(master) git checkout HEAD test.py
Updated 0 paths from 3689ff8
➜  orange git:(master) cat test.py
bhabds
hfhfhfhf
➜  orange git:(master) git log
➜  orange git:(master) git checkout 505c4394dc test.py
Updated 1 path from 8524039
➜  orange git:(master) ✗ cat test.py
bhabds
➜  orange git:(master) ✗
```

Exemple de branch :

```bash
➜  orange git:(master) cat test.py
bhabds
hfhfhfhf
➜  orange git:(master) git branch
➜  orange git:(master) git log
➜  orange git:(master) git branch branche2
➜  orange git:(master) git log
➜  orange git:(master) git checkout branche2
Switched to branch 'branche2'
➜  orange git:(branche2) cat test.py
bhabds
hfhfhfhf
➜  orange git:(branche2) echo "bonjour" >> test.py
➜  orange git:(branche2) ✗ cat test.py
bhabds
hfhfhfhf
bonjour
➜  orange git:(branche2) ✗ git status
On branch branche2
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test.py

no changes added to commit (use "git add" and/or "git commit -a")
➜  orange git:(branche2) ✗ git commit -am "add bonjour"
[branche2 a7468fe] add bonjour
 1 file changed, 1 insertion(+)
➜  orange git:(branche2) git log
➜  orange git:(branche2) git branch master
fatal: A branch named 'master' already exists.
➜  orange git:(branche2) git checkout master
Switched to branch 'master'
➜  orange git:(master) cat test.py
bhabds
hfhfhfhf
➜  orange git:(master)
```

Pour push une branche créée en local sur GitHub :

```bash
git push -u origin <branch>
```

## Commande `Git init --bare`

- `git init --bare` : initialise un dépôt git sans dossier de travail

## Commande `git clone`

Le `git clone` effectue les actions suivantes :

1. Créer un dossier
2. Git init
3. Git remote add origin <url>
4. Git fetch
5. Git checkout -t origin/master

## Commande `git checkout <commit>`

Lorsqu'on donne un commit à `git checkout`, on se positionne sur ce commit, mais la `HEAD` reste sur le dernier commit. On dit que l'on est en `detached HEAD`.

Si on fait un `commit` dans cet état, on crée un nouveau commit qui est détaché de la branche.

Si on quitte le `commit` qu'on a créé, on revient sur la branche, mais comme la tête est détachée, on ne peut pas revenir sur le commit qu'on a créé, sauf si on connait son hash.

Travailler en `detached HEAD` est une mauvaise pratique, mais il peut arriver de le faire pour tester des choses.

Si on aimerait retourner sur un `commit` perdu, on peut utiliser `git reflog` pour retrouver l'identifiant du commit. `git reflog` affiche l'historique des `commit` et des `checkout`.

# Command `git push -set-upstream <remote> <branch>`

Si on a créer une branche en local et qu'on aimerait désormais l'ajouter dans le remote (par exemple: github ou origin ou ...), on peut utiliser la commande `git push -set-upstream <remote> <branch>` avec `<remote>` qui est le nom du remote et `<branch>` qui est le nom de la branchee qu'on avait créé en local.

La liste des remotes est disponible avec la commande `git remote -v`.

```

```
