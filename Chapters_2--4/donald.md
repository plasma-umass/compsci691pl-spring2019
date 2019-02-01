In this problem we want to see how to define a new data type for a list. 
This list's type however will also keep track of the **maximum** value contained in the list. 
In addition, we also want to make it generic.
For example, here are some example constructions of the list, and their types:

```idris
4 :: 6 :: Single 1 : MaxList Integer 6
Z :: (S Z) :: (S (S Z)) :: Single Z : MaxList Nat 2
```

Note that we do not have a `Nil` constructor, since the maximum value contained in an empty list is not that well-defined. 
We circumvent this problem by only allowing you to construct lists of length 1 and greater, via `Single` and the usual `::`.

## Part 1: Define the `MaxList` type

*Note: Perhaps it would be easier to first define it so it only stores `Nat`s, and then generify it.* 

Also, you need to be careful to properly constrain the generic parameter.

## Part 2: Write an function to append 2 `MaxList`s together
