#!/usr/bin/perl -0777 -n

# -0777 dis q'on veut stocker tout ce qui vient du cat dans la variable $_

# On lance le script avec la commande suivante :
# perl script.pl file.json

print("AVANT REGEX : \n");

print($_); # affiche le contenu du fichier (stocké dans $_ )

print("MATCHS : \n");

while (/\[.*?\]/gms) {
    print "Match is:", $&, "\n";
}

print("APRES REGEX : \n");

# s/\n+/\n/g; # retire les sauts de ligne multiples (on peut directement utiliser la regex sans rien puisque le texte est dans $_)

s/:\s*\[\K\n.*?(?=\])/$&=~s@\s+@@rgs/egs; # retire les sauts de ligne dans les tableaux



print($_)