# Week 10

# Perl

Oneliner == one line of code

```perl
perl -e 'print "Hello World\n"'
```

Remplacer toutes les voyelles d'un fichier par leur majuscules :

```perl
perl -pi -e 's/[aeiou]/\U$&/g' file.txt
```

Dans un fichier C, le malheureus développeur a mis des éparateurs de commentaires du type `/************** titre **************/` et il veut les remplacer par des `/* titre */`.

```perl
perl -pi -e 's@/\*+\s*(.*?)\s*\*+/@/* $1 */@g' file.c
```

Dans un fichier C j'aimerais remplacer les multiples lignes vides par une seule.

```perl
perl -0pi -e 's/\n+/\n/g' file.c
```

On veut supprimer les lignes vides dans ce fichier:

```json
{
    "name": "John",

    "age": 30,


        {
            "name": "Ford",
            "models": [
                "Fiesta",
                "Focus",
                "Mustang"
            ]
        },
        {
            "name": "BMW",
            "models": [
                "320",
                "X3",
                "X5"
            ]

        },

        {


            "name": "Fiat",
            "models": [
                "500",


                "Panda"
            ]

}
```

```perl
perl -0pi -e 's/\n+/\n/g' file.json
```

## Exercice

Dans ce même fichier JSON j'aimerais

```json
"models": [
    "320",
    "X3",
    "X5"
]
```

devient

```json
"models": [ "320", "X3", "X5" ]
```

### Explications réponse

```perl
s/:\s*\[\K\n.*?(?=\])/$&=~s@\s+@@rgs/egs;
```

structure de la regex :

s/a/b/egs

- a = pattern de recherche
- b = pattern de remplacement
- e = evaluate (que b c'est du perl)
- g = global (toutes les occurences)
- s = single line (le . matche aussi les \n)

explications partie a :

- `:\s*\[` : matche `:` suivi de 0 ou plusieurs espaces suivi de `[`
- `\K` : on oublie ce qui a été matché avant
- `\n` : matche un retour à la ligne
- `.*?` : matche n'importe quoi (sans gourmandise)
- `(?=\])` : matche `]` (sans le consommer)

explications partie b :

`$&=~` : le $& est la variable qui contient le match de la regex, on lui applique une substitution
`s@` : défini le séparateur de la substitution
`\s+` : un ou plusieurs espaces
`@@` : remplace par rien
`rgs` : r = raw (pas d'interprétation des \), g = global, s = single line

# SED

SED est un langage de programmation qui permet de manipuler des données structurées. Il est très utilisé pour manipuler des fichiers CSV.

# AWK

Comme Sed mais sous stéroïdes.

# Docker

Docker est un outil qui permet de créer des conteneurs. Un conteneur est un environnement isolé qui contient tout ce dont un programme a besoin pour fonctionner. C'est un peu comme une machine virtuelle mais en plus léger.
