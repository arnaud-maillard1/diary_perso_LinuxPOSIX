# Week 9

# Regex suite

## Façon d'utiliser les regex dans python

```ipython
In [1]: import re

In [2]: re.compile(r"^1$|^(11+?)\1+$")
Out[2]: re.compile(r'^1$|^(11+?)\1+$', re.UNICODE)

In [3]: rx = re.compile(r"^1$|^(11+?)\1+$")

In [4]: rx.match('111')

In [5]: rx.match('1111')
Out[5]: <re.Match object; span=(0, 4), match='1111'>

In [6]: rx.match('11111')

In [7]: rx.match('111111')
Out[7]: <re.Match object; span=(0, 6), match='111111'>

In [8]: re.match(r"^1$|^(11+?)\1+$", '111')

In [9]: re.match(r"^1$|^(11+?)\1+$", '1111')
Out[9]: <re.Match object; span=(0, 4), match='1111'>
```

# Makefile

```makefile
# How to make a pie
flour:
	@echo "Getting flour"

dough: flour water
	@echo "Making dough with $^"

pie: dough apple sugar
	@echo "Making pie with $^"
# $^ is a special variable that contains all the dependencies
```

```bash
➜  test git:(main) ✗ make pie
Getting flour
make: *** No rule to make target 'water', needed by 'dough'.  Stop.
➜  test git:(main) ✗ touch water
➜  test git:(main) ✗ make pie
Getting flour
Making dough with flour water
make: *** No rule to make target 'apple', needed by 'pie'.  Stop.
➜  test git:(main) ✗ touch apple
➜  test git:(main) ✗ make pie
Getting flour
Making dough with flour water
make: *** No rule to make target 'sugar', needed by 'pie'.  Stop.
➜  test git:(main) ✗ touch sugar
➜  test git:(main) ✗ make pie
Getting flour
Making dough with flour water
Making pie with dough apple sugar
➜  test git:(main) ✗
```

## Pour compiler du C

```bash
➜  test git:(main) ✗ gcc -c foo.c -o foo.o
➜  test git:(main) ✗ gcc -c main.c -o main.o
➜  test git:(main) ✗ gcc foo.o main.o -ototo
➜  test git:(main) ✗ ./toto
```

Au lieu de faire ces lignes, on peut faire un Makefile :

```makefile
foo.o: foo.c
	gcc -c foo.c -o foo.o

main.o: main.c
	gcc -c main.c -o main.o

toto : foo.o main.o
	gcc foo.o main.o -ototo
```

Pour améliorer les répétitions, on peut utiliser des variables :

```makefile
CC=gcc
EXEC=toto
all: $(EXEC)

foo.o: foo.c
	$(CC) -c $< -o$@

main.o: main.c
	$(CC) -c $< -o$@

# $< prend toutes les dépendances donc foo.o et main.o
$(EXEC) : foo.o main.o
	$(CC) $^ -o$@


# précise que all n'est pas un fichier donc qu'il ne faut pas le chercher
.PHONY: all
```

- `$@` : nom de la cible
- `$<` : première dépendance
- `$^` : toutes les dépendances

Encore meilleures version :

```makefile
CC=gcc
EXEC=toto
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
CFLAGS=-Wall -Wextra -Werror -Wpedantic -std=c11
LFLAGS=-lm
all: $(EXEC)
# -include $(OBJS:.o=.d)

# arrête la compilation et permet d'afficher le message d'erreur donc de debug
# $(error $(OBJS))


%.o : %.c
	$(CC) $(CFLAGS) -c $< -o$@
# $< prend toutes les dépendances donc foo.o et main.o
$(EXEC) : $(OBJS)
	$(CC) $^ -o$@ $(LFLAGS)

# supprime les fichiers .o
clean:
	rm -f $(OBJS)

# supprime l'exécutable et les fichiers .o
mrproper: clean
	rm -f $(EXEC)
# précise que all n'est pas un fichier donc qu'il ne faut pas le chercher
.PHONY: all
```

Mais il y a un problème, si on modifie un fichier .h, il ne recompile pas.

```bash
➜  test git:(main) ✗ make
gcc -Wall -Wextra -Werror -Wpedantic -std=c11 -c foo.c -ofoo.o
gcc -Wall -Wextra -Werror -Wpedantic -std=c11 -c main.c -omain.o
gcc foo.o main.o -ototo -lm
➜  test git:(main) ✗ make
make: Nothing to be done for 'all'.
➜  test git:(main) ✗ touch foo.h
➜  test git:(main) ✗ make
make: Nothing to be done for 'all'.
```

On ajoute `-include $(OBJS:.o=.d)` pour inclure les fichiers .d qui contiennent les dépendances et le flag `-MD` pour générer les fichiers .d

```makefile
CC=gcc
EXEC=toto
SRCS=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
CFLAGS=-Wall -Wextra -Werror -Wpedantic -std=c11
LFLAGS=-lm
all: $(EXEC)
-include $(OBJS:.o=.d)

# arrête la compilation et permet d'afficher le message d'erreur donc de debug
# $(error $(OBJS))


%.o : %.c
	$(CC) $(CFLAGS) -c $< -o$@ -MD
# $< prend toutes les dépendances donc foo.o et main.o
$(EXEC) : $(OBJS)
	$(CC) $^ -o$@ $(LFLAGS)

# supprime les fichiers .o
clean:
	rm -f $(OBJS)

# supprime l'exécutable et les fichiers .o
mrproper: clean
	rm -f $(EXEC)
# précise que all n'est pas un fichier donc qu'il ne faut pas le chercher
.PHONY: all
```

```bash
➜  test git:(main) ✗ make all
gcc -Wall -Wextra -Werror -Wpedantic -std=c11 -c foo.c -ofoo.o -MD
gcc -Wall -Wextra -Werror -Wpedantic -std=c11 -c main.c -omain.o -MD
gcc foo.o main.o -ototo -lm
➜  test git:(main) ✗ make all
make: Nothing to be done for 'all'.
➜  test git:(main) ✗ touch foo.h
➜  test git:(main) ✗ make all
gcc -Wall -Wextra -Werror -Wpedantic -std=c11 -c main.c -omain.o -MD
gcc foo.o main.o -ototo -lm
➜  test git:(main) ✗
```

Maintenant on pourrait vouloir faire pour que lorsqu'on appuie sur la touche `F5`, ça compile

# CMake
