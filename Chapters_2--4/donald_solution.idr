data MaxList : (t : Type) -> (m : t) -> Type where
    Single : (x : t) -> MaxList t x
    Cons : Ord t => (x : t) -> (xs : MaxList t m) -> MaxList t (max x m)

--  For some reason this does't work!!????
-- data MaxList2 : Ord t => (t : Type) -> (m : t) -> Type where
--     Single2 : (x : t) -> MaxList2 t x
--     Cons2 : (x : t) -> (xs : MaxList2 t m) -> MaxList2 t (max x m) 

