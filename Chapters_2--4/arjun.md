The following datatype defines sized-indexed binary trees with values at the
nodes and no values at the leaves.

```
data SizedTree : Nat -> Type -> Type where
  Leaf : {a : Type} -> SizedTree Z a
  Node : {a : Type} -> {m : Nat} -> {n : Nat} ->
    SizedTree m a -> a -> SizedTree n a -> SizedTree (S (m + n)) a
```

For example, the following value:

```
tree1 : SizedTree 2 Nat
tree1 = Node Leaf 4 (Node Leaf 3 Leaf)
```

Represents the tree:

```
        4
      /   \
           3
         /  \
```

And, the following value:

```
tree2 : SizedTree 5 Nat
tree2 = Node (Node (Node Leaf 10 Leaf) 20 Leaf) 40 tree1
```

Represents the tree:


```
        40
      /   \
     20    \
   /   \    4
  10       / \
 /  \         3
             / \
```

Write a function to flatten size-index binary trees into vectors *in-order*.
Your function should have the following type:

```
flatten : SizedTree n Nat -> Vect n Nat
```

For example:

```
flatten tree1 -- should produce [4, 3]
flatten tree2 -- should produce [10, 20, 40, 4, 3]
```

Suggested approach:

1. Flatten the tree in whatever order works for you.
2. Try to understand why flattening in-order will not work if done in the
   obvious way.
3. Write the appropriate helper function (which has nothing to do with
   `SizedTree`).