# Week 8

# Les expressions régulières

Définition : une expression régulière est une chaîne de caractères qui décrit un ensemble de chaînes de caractères.

## Exemple

- Recherche d'homonymes :

  ```
  /al(èz|(ai|è)s)e/
  ```

  détecte : alèze, alaise, alèse, mais pas charentaise

-

## grep

le `re` de `grep` correspond à `regex` (regular expression)

On peut utiliser `grep` pour rechercher des chaînes de caractères dans un fichier, dans un ensemble de fichiers, ...

**g**/**r**egular **e**xpression/**p** -> grep

Pour utiliser les expressions régulières, il faut utiliser l'option `-P` (Perl) ou `-E` (Extended) par exemple :

```bash
grep -P "al(èz|(ai|è)s)e" test.txt
```

Car autrement, `grep` ne comprend pas les expressions régulières, par exemple les parenthèses ne sont pas des groupes mais des caractères à rechercher pour `grep` sans l'option `-P` ou `-E`.

## egrep

`egrep` est un alias de `grep -E`

## PCRE

Perl Compatible Regular Expression : c'est les expressions régulières provenant de Perl, mais adaptées à d'autres langages pour que ce soit un peu plus simple.

C'est le meilleur format pour les expressions régulières selon Chevallier.

## Les bases

Le meilleur site pour l'aide des expressions régulières : https://regex101.com/

- m/regular expression/igs

  - `m` : mode
  - `igs` : modificateurs

- `\` : caractère d'échappement

  - `\n` : Nouvelle ligne
  - `\r` : Retour chariot
  - `\f` : Saut de page
  - `\t` : Tabulation
  - `\0` : Caractère nul (rien ne s'affiche)
  - `\a` : Caractère d'alerte
  - `\e` : Caractère d'échappement (escape)
  - `\x{...}` : Caractère en hexadécimal
  - `\u{...}` : Caractère unicode par exemple `\u153`
  - notation courte :
    - `\d` : Chiffre, equivalent à `[0-9]`
    - `\s` : Caractère blanc, equivalent à `[ \t\r\n]`
    - `\w` : Caractère alphanumérique, equivalent à `[a-zA-Z0-9_]`
    - `\D` : N'est pas un chiffre, equivalent à `[^0-9]`
    - `\S` : N'est pas un caractère blanc, equivalent à `[^ \t\r\n]`
    - `\W` : N'est pas un caractère alphanumérique, equivalent à `[^a-zA-Z0-9_]`
    - `.` : N'importe quel caractère sauf `\n`, equivalent à `[^\n]
    - `\b` :

- métacaractères : caractères spéciaux qui ont un sens particulier

  - `\` : caractère d'échappement
  - `.` : n'importe quel caractère mais qu'un seul
  - `[]` : ensemble de caractères

    - `[a-z]` : ensemble de caractères de `a` à `z`
    - `[a-zA-Z]` : ensemble de caractères de `a` à `z` et de `A` à `Z`
    - `[^a]` : ensemble de caractères sauf `a`
    - `[a-z-]` ou `[a-z\-]`: ensemble de caractères de `a` à `z` **et le caractère `-`**

  - `*` : autorise la répétition de 0 à $\infty$ fois
  - `+` : autorise la répétition de 1 à $\infty$ fois
  - `?` : autorise la répétition de 0 ou 1 fois
  - `{}` : autorise la répétition d'un nombre de fois précis

    - `{3}` : 3 fois
    - `{3,}` : 3 fois ou plus jusqu'à $\infty$
    - `{3,5}` : entre 3 et 5 fois

  - `()` : groupe est : uen portion de l'expression régulière

    - Appliquer une répétition au groupe
    - Faciliter la lecture de l'expression régulière
    - Capturer des groupes lors d'un match et les utiliser dans un remplacement
    - Pas de groupe dans un ensemble
    - Les groupes sont numérotés de gauche à droite
    - Les groupes sont par défaut capturants

    - `()` : groupe
    - `(?:)` : groupe non capturant (le groupe est utile pour le recherche mais pour le remplacement, il ne sera pas pris en compte) (le groupe ne compte pas pour le numéro des groupes)
    - `(?<name>)` : groupe nommé

- `|` : ou logique
- `\b` : mot sans être à l'intérieur d'un mot
- `^` : début de la chaîne
- `$` : fin de la chaîne
- `\A` : début de la chaîne
- `\Z` : fin de la chaîne

### Exemples

- `/chat/` : recherche la chaîne de caractères `chat` dans le texte
- `/./` : recherche n'importe quel caractère **sauf le retour chariot `\n`**
- `/ro.e/` : recherche la chaîne de caractères `ro` suivi d'un caractère quelconque et finissant par `e`
- `/3.14/` : match `3914` par exemple mais pas `3.14`
- `3\.14` : match `3.14` mais pas `3914`
- `c/[aeiouy].ale` : match cabale, cigale, coxale
- `0x[0-9a-f]+` : match 0x1234, 0xdeadbeef, 0x1234567890abcdef, 0xa, 0x0, ...
- `/\bchat\b/` : match chat, mais pas chaton, chatouille, ...

## Les expressions régulières en python

```python
impomt re

re.sub(r'regex de search', r'par quoi on substitue', 'texte', flags=re.I)
```

## Fonctions avancées

### Les quantificateurs gourmands et non-gourmands

- `/.*an/` : **Les quantificateurs sont gourman**ds

  Il prend le plus grand nombre de caractères possible jusqu'à ce qu'au dernier `an`

- `/.*?an/` : **Les quan**tificateurs sont non-gourmands

  Il prend le plus petit nombre de caractères possible jusqu'à ce qu'au dernier `an`

Les divers quantificateurs sont :

- `??` : 0 ou 1 fois
- `+?` : 1..$\infty$
- `*?` : 0..$\infty$

### Les `Lookahead` et `Lookbehind`

- `(?=...)` : **Lookahead** : Est-ce que mon curseur est suivi par `...`
- `(?!...)` : **Negative Lookahead** : Est-ce que mon curseur n'est pas suivi par `...`

- `(?<=...)` : **Lookbehind** : Est-ce que mon curseur est précédé par `...`
- `(?<!...)` : **Negative Lookbehind** : Est-ce que mon curseur n'est pas précédé par `...`

## Pour bien comprendre les regex

On peut utiliser le debuggeur de regex : https://regex101.com/
