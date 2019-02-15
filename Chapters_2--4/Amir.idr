import Data.Vect

-----insert------

insert : Ord elem => (x : elem) -> (xsSorted : Vect k elem) -> Vect (S k) elem
insert x [] = [x]
insert x (y :: xs) = case x < y of
						  False => y :: insert x xs
						  True => x :: y :: xs

-----insSort-----

insSort : Ord elem => Vect n elem -> Vect n elem
insSort [] = []
insSort (x :: xs) = let xsSorted = insSort xs in insert x xsSorted

--appendWithSort--

appendWithSort : Ord elem => Vect n elem -> Vect m elem -> Vect (n+m) elem
appendWithSort [] ys = ys
appendWithSort (x :: xs) ys = let sortedYs = insSort ys in insert x (appendWithSort xs (sortedYs))
