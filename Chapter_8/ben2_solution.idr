module Monotonic
total plusMonotonic : (c : Nat) -> LTE a b -> LTE  (c + a) (c + b)
plusMonotonic Z x = x
plusMonotonic (S k) x = LTESucc (plusMonotonic k x)

||| Proof that multiplication is monotonic. Note that it is important to have
||| the resulting type be LTE (a * c) (b * c) instead of LTE (c * a) (c * b).
total multMonotonic : {a : Nat} -> {b : Nat}
                   -> (c : Nat)
                   -> LTE a b
                   -> LTE (a * c) (b * c)
multMonotonic {a} {b} Z x = rewrite multCommutative a 0 in rewrite multCommutative b 0 in LTEZero
multMonotonic (S k) LTEZero = LTEZero
multMonotonic {a = S Left} {b = S Right} k (LTESucc x) = plusMonotonic k (multMonotonic k x)
