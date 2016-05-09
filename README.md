Set
===

It's about this game: https://en.wikipedia.org/wiki/Set_(game)

This program generates sets or non-sets with special properties.

The Set game is used in some psychological studies. In these studies computer-generated
set items are presented to the subjects. The subjects have to
determine if the items are a set or not.

Using this program, the researcher can create specific kinds of sets and non-sets.
In the case of sets, it is possible to adjust the number of features that fulfill each of the two set rules ("match" and "span").
In the case of non-sets, the last item of a valid set is replaced by an "oddball" item, which brakes the set rules.
Using this program, it is possible to determine how many rule(s) the oddball brakes and which one(s).

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


Even finer-grained control of non-sets
--------------------------------------

A researcher might want to compare non-sets, in which the "match" rule is broken with non-sets, in which the "span" rule is broken.
The following awk script can be used to filter existing lists of non-sets into these two groups.

Please note that this script should only be used on non-sets (because sets do not brake any rules), only for -s1 and -s2 (but not -s0 and -s3 because these only brake one rule), and only for -P1 (but not -P2 or -P3 because two different rules might be broken).

Example: From non-sets generated with `-P1`, only keep those where the span-rule is broken:

```
cat non-sets-P1.txt | awk -f label_P1_nonsets.awk | awk '/span-rule-broken/ { print $1, $2, $3 }'
```

Analogously for match-rule broken:

```
cat non-sets-P1.txt | awk -f label_P1_nonsets.awk | awk '/match-rule-broken/ { print $1, $2, $3 }'
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
