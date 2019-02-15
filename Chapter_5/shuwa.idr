import Data.Vect

total
myfilter: Vect n a -> (f: a -> Bool) -> (len: Nat ** Vect len a)
myfilter [] f = (_ ** [])
myfilter (x :: xs) f = let (_ ** tail) = myfilter xs f in
                        if f x then (_ ** x::tail)
                               else (_ ** tail)
