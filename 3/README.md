# Week 3

## Commande `echo`

Ci-dessous, on redirige `stdout` dans le `stdin` d'un autre programme (c'est un pipe)

```console
echo "toto" | cowsay
```

Ci-dessous, on redirige le `stdout` d'un fichier vers un fichier

```console
echo "tata" > tata.txt
```

Ci-dessous, on lit le fichier pour le mettre dans `stdout`

```console
echo "titi" > titi.txt
```

Infos supplémentaires :

`>`: Overwrites the existing file, or creates a file if the file of the mentioned name is not present in the directory.

`>>`: Appends the existing file, or creates a file if the file of the mentioned name is not present in the directory.

## RCS

Le site suivant est bien : [lien](http://www.cs.toronto.edu/~simon/howto/rcs.html)

## Commande `cp`

```console
cp Src_file Dest_file
```

## Hash

2 fichiers identiques auront le mêm hash

Collision : il est possible de générer assez facilement deux fichiers **différents** ayant le même hash.

## Shell script

Learn : https://learnxinyminutes.com/docs/bash/

Pour exécuter qql chose en bash, comme une addition d'arguments, on utiliser les parenthèses après le `$` :

```bash
echo "add $* together to get $(($1 + $2))"
```

Voici un exmple de shell stocké dans le fichier `test.sh`:

```bash
#!/bin/bash

PROGRAM=$(basename "$0")

foobar () {
    echo "foobar"
}

add () {
    echo "add $* together to get $(($1 + $2))"
}

command=$1
case $command in
    "" | "-h" | "--help")
        help
        ;;
    *)
        shift
        ${command} "$@"
        if [ $? = 127 ]; then
            echo "Error: '$command' is not a known command." >&2
            echo "       Run '$PROGRAM --help' for a list of known commands." >&2
            exit 1
        fi
        ;;
esac

```

(le 127 est là parce que c'est le numéro d'erreur qui correspond à une commande pas trouvée)

Voici ce qu'on peut faire avec ce fichier

```console
➜  labo-01-plomberie-git-arnaud-maillard1 git:(master) ✗ ./test.sh ad
./test.sh: line 20: ad: command not found
Error: 'ad' is not a known command.
       Run 'test.sh --help' for a list of known commands.
➜  labo-01-plomberie-git-arnaud-maillard1 git:(master) ✗ ./test.sh foobar
foobar
➜  labo-01-plomberie-git-arnaud-maillard1 git:(master) ✗ ./test.sh add 5 8
add 5 8 together to get 13
```

## Tips

1. L'option `-al` permet de lister les fichiers en ajoutant les informations d'accès, la date, ...

```console
➜  labo-01-plomberie-git-arnaud-maillard1 git:(master) ✗ ls -al main*
-r-xr-xr-x 1 arnaud-maillard1 arnaud-maillard1  25 Mar  9 13:38 main.c
-r-xr-xr-x 1 arnaud-maillard1 arnaud-maillard1 230 Mar  9 13:39 main.c,v
➜  labo-01-plomberie-git-arnaud-maillard1 git:(master) ✗ ls -al
total 32
drwxrwxrwx 1 arnaud-maillard1 arnaud-maillard1  4096 Mar  9 13:39 .
drwxrwxrwx 1 arnaud-maillard1 arnaud-maillard1  4096 Mar  9 13:21 ..
drwxrwxrwx 1 arnaud-maillard1 arnaud-maillard1  4096 Mar  9 13:21 .git
-rwxrwxrwx 1 arnaud-maillard1 arnaud-maillard1 31979 Mar  9 13:21 README.md
-rwxrwxrwx 1 arnaud-maillard1 arnaud-maillard1   477 Mar  9 13:21 git.sh
-r-xr-xr-x 1 arnaud-maillard1 arnaud-maillard1    25 Mar  9 13:38 main.c
-r-xr-xr-x 1 arnaud-maillard1 arnaud-maillard1   230 Mar  9 13:39 main.c,v
```

2. La commande `rm` permet de supprimer un fichier
