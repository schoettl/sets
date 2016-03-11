Set
===

It's about this game: https://en.wikipedia.org/wiki/Set_(game)

This program generates sets or non-sets with special properties.

The Set game is used in some psychological studies. In these studies computer
generated set items are presented to the subjects. The subjects have to
determine if the items are a set or not.

For exampe, the studies' conductor may want to have the third set item to be an
"oddball" that is different in exactly two features (e.g. color and shape).

This program can generate a variety of sets or non-sets with special
properties. It's written in Haskell, so you need to setup a Haskell environment
to run it. To show the usage/help message, use this command:

```
runhaskell generate_items.hs
```

Here are a few examples on how to run it with certain parameters:

```
# generate sets that have exactly 2 spans
runhaskell generate_items.hs -S -s2

# generate non-sets with a special "oddball":
# - oddball must be different to the actual third item in exactly 2 features
# - first two items must have exactly 1 span
runhaskell generate_items.hs -P2 -s1
```

Terms
-----

Terms used througout this program (and in studies):

 - *item* — one card in the game Set
 - *set* — a set of three items, with special properties according to the game
   rules
 - *non-set* — not a set
 - *feature* — one of the properties of an item (color, shape, fill) and also
   all possible values of this property
 - *span* — when three items are all different from each other in *one* feature
 - *n-span* — when three items have spans in exactly n features
 - *match* — when three items are all same in *one* feature
 - *n-match* —¸...
