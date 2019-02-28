data Even : (n : Nat) -> Type where
    EvenK : (k : Nat ** n = k + k) -> Even n

data Odd : (n : Nat) -> Type where
    OddK : (k : Nat ** n = k + k + 1) -> Odd n

total evenZ : Even Z
evenZ = EvenK (0 ** Refl)

total oneNotEven : Even (S Z) -> Void
oneNotEven (EvenK (Z ** Refl)) impossible
oneNotEven (EvenK ((S k) ** pf)) =
    let pf1 = succInjective Z  (k + (S k)) pf in
    let pf2 = trans pf1 (sym (plusSuccRightSucc k k)) in
    case pf2 of
        Refl impossible

total odd2even : Odd n -> Even (S n)
odd2even (OddK (k ** Refl)) = EvenK (k + 1 ** prf)
    where prf : S (k + k + 1) = (k + 1) + (k + 1)
          prf =
              -- S ((k + k) + 1) = (k + 1) + (k + 1)
              rewrite plusCommutative k 1 in
              -- S ((k + k) + 1) = (1 + k) + (1 + k)
              cong {f=S} $
              -- (k + k) + 1 = k + (S k)
              rewrite sym (plusAssociative k k 1) in
              -- k + (k + 1) = k + (S k)
              rewrite plusCommutative k 1 in
              -- k + (S k) = k + (S k)
              Refl

total even2odd : Even n -> Odd (S n)
even2odd (EvenK (k ** Refl)) = OddK (k ** prf)
    where prf : S (k + k) = (k + k) + 1
          prf = plusCommutative 1 (k + k)

total commPlus1 : (a : Nat) -> (b : Nat) -> a = b + (the Nat 1) -> a = S b
commPlus1 (plus b (S Z)) b Refl = rewrite plusCommutative b 1 in Refl

total even2odd_backwards : Odd (S n) -> Even n
even2odd_backwards {n = Z} odd_sn = evenZ
even2odd_backwards {n = (S p)} (OddK (ssp_k ** pf)) = EvenK (ssp_k ** reduce pf)
    where reduce : S (S p) = (k + k) + 1 -> S p = k + k
          reduce {k} pf =
              let pf1 = commPlus1 (S (S p)) (k + k) pf in
              succInjective (S p) (k + k) pf1


total odd2even_backwards : Even (S n) -> Odd n
odd2even_backwards {n = Z} even_sz = void (oneNotEven even_sz)
odd2even_backwards {n = (S k)} (EvenK (Z ** Refl)) impossible
odd2even_backwards {n = (S k)} (EvenK ((S j) ** pf)) = OddK (j ** reduce)
    where reduce : S k = plus (plus j j) 1
          reduce =
              rewrite plusCommutative (j + j) 1 in
              rewrite plusSuccRightSucc j j in
              succInjective (S k) (j + (S j)) pf


total oddPlusOdd : Odd n -> Odd m -> Even (n + m)
oddPlusOdd (OddK (k ** Refl)) (OddK (j ** Refl)) = EvenK (k + j + 1 ** prf)
    where prf : ((k + k) + 1) + ((j + j) + 1) = ((k + j) + 1) + ((k + j) + 1)
          prf =
            -- ((k + k) + 1) + ((j + j) + 1) = ((k + j) + 1) + ((k + j) + 1)
            rewrite plusAssociative ((k + k) + 1) (j + j) 1 in
            -- (((k + k) + 1) + (j + j)) + 1 = ((k + j) + 1) + ((k + j) + 1)
            rewrite plusAssociative ((k + k) + 1) j j in
            -- k + k + 1 + j + j + 1 = ((k + j) + 1) + ((k + j) + 1)
            rewrite plusAssociative ((k + j) + 1) (k + j) 1 in
            -- k + k + 1 + j + j + 1 = (((k + j) + 1) + (k + j)) + 1
            rewrite plusAssociative ((k + j) + 1) k j in
            -- k + k + 1 + j + j + 1 = k + j + 1 + k + j + 1
            plusConstantRight (k + k + 1 + j + j) (k + j + 1 + k + j) 1 $
            -- k + k + 1 + j + j = k + j + 1 + k + j
            plusConstantRight (k + k + 1 + j) (k + j + 1 + k) j $
            -- ((k + k) + 1) + j = ((k + j) + 1) + k
            rewrite sym (plusAssociative (k + k) 1 j) in
            -- (k + k) + (1 + j) = ((k + j) + 1) + k
            rewrite sym (plusAssociative (k + j) 1 k) in
            -- (k + k) + (1 + j) = (k + j) + (1 + k)
            rewrite plusCommutative 1 j in
            -- (k + k) + (j + 1) = (k + j) + (1 + k)
            rewrite plusCommutative 1 k in
            -- (k + k) + (j + 1) = (k + j) + (k + 1)
            rewrite plusAssociative (k + k) j 1 in
            -- ((k + k) + j) + 1 = (k + j) + (k + 1)
            rewrite plusAssociative (k + j) k 1 in
            -- ((k + k) + j) + 1 = ((k + j) + k) + 1
            plusConstantRight (k + k + j) (k + j + k) 1 $
            -- (k + k) + j = (k + j) + k
            rewrite sym (plusAssociative k k j) in
            -- k + (k + j) = (k + j) + k
            rewrite sym (plusAssociative k j k) in
            -- k + (k + j) = k + (j + k)
            plusConstantLeft (k + j) (j + k) k $
            -- k + j = j + k
            plusCommutative k j


total oddPlusEven : Odd n -> Even m -> Odd (n + m)
oddPlusEven {n = n} {m = Z} odd_n even_m = rewrite plusZeroRightNeutral n in odd_n
oddPlusEven {n = n} {m = (S p)} odd_n even_m =
    let odd_p = odd2even_backwards even_m in
    let even_np = oddPlusOdd odd_n odd_p in
    rewrite sym (plusSuccRightSucc n p) in
    even2odd even_np

total evenPlusOdd : Even n -> Odd m -> Odd (n + m)
evenPlusOdd {n} {m} even_n odd_m = rewrite plusCommutative n m in oddPlusEven odd_m even_n

total evenPlusEven : Even n -> Even m -> Even (n + m)
evenPlusEven {n = Z} {m = m} even_n even_m = even_m
evenPlusEven {n = (S np)} {m = Z} even_n even_m = rewrite plusZeroRightNeutral np in even_n
evenPlusEven {n = (S np)} {m = (S mp)} even_n even_m =
    let odd_np = odd2even_backwards even_n in
    let odd_mp = odd2even_backwards even_m in
    let even_np_mp = oddPlusOdd odd_np odd_mp in
    rewrite sym (plusSuccRightSucc np mp) in
    odd2even (even2odd even_np_mp)
