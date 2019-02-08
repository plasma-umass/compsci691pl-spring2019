data Stack : Nat -> Type -> Type where 
  MkStack : {a : Type} -> (xs : List a) -> Stack (length xs) a

stack_pop : {a : Type} -> Stack (S n) a -> (a, Stack n a)
stack_pop (MkStack (x :: xs)) = (x, MkStack xs)

stack_push : {a : Type} -> a -> Stack n a -> Stack (S n) a
stack_push newitem (MkStack xs) = MkStack (newitem :: xs)

data Queue : Nat -> Type -> Type where
  MkQueue : {a : Type} -> (xs : List a) -> Queue (length xs) a

queue_pop : {a : Type} -> Queue (S n) a -> (a, Queue n a)
queue_pop (MkQueue (x :: xs)) = (x, MkQueue xs)

queue_push : {a : Type} -> a -> Queue n a -> Queue (S n) a
queue_push newitem (MkQueue xs) = MkQueue $ newitem :: xs