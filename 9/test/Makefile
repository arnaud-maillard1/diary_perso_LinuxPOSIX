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