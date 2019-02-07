
# Ch2_4 Question

Write a *recursive* function that gets two arbitrary vectors and returns a *merged sorted vector*. Your function should have the following type:
```idris
mergeWithSort : Ord elem => Vect n elem -> Vect m elem -> Vect (n+m) elem
```
Example:
```
*mergeWithSort> mergeWithSort [11, 9, 8] [13, 2]
[2, 8, 9, 11, 13] : Vect 5 Integer
```
Suggested approach: Following functions implement *insertion sort*. You can call them in your code. 
```idris
insert : Ord elem => (x : elem) -> (xsSorted : Vect k elem) -> Vect (S k) elem
insert x [] = [x]
insert x (y :: xs) = case x < y of
						  False => y :: insert x xs
						  True => x :: y :: xs
```
```idris
insSort : Ord elem => Vect n elem -> Vect n elem
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in insert x xsSorted
```
