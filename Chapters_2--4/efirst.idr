module efirst

partition : Num a => List a -> (f: a -> Bool) -> (List a, List a)
partition l f = (filter f l, filter (\x => if f x then False else True) l)
