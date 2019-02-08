## Perfect Binary Trees

In the book, we defined a generic type for a binary tree whose nodes carry values of type `elem`:

```
data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)
```

Using dependent types, define a generic datatype that represents a perfect
binary tree of height `k` (with arbitrary node values). By a perfect tree, we
mean a tree in which all internal nodes have two children, and all leaves
are at the same depth.

For instance, a working implementation should allow this tree:

```
                            "Cat"
                          /       \
                    "Dog"          "Huh"
                  /      \        /     \
             "Right"    "Left"  "No"   "Maybe"
```

But should raise a type error if you try to encode this tree:

```
                           "Milk"
                          /      \
                    "Salt"        "Egg"
                  /      \
            "Pepper"      "Another egg"
```
