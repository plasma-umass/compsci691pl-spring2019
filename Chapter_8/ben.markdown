# An alternate approach to questions in parity, originally posed by Donald

I've replaced the definition of `Even` and `Odd`, originally:

```idris
mutual 
  data Even : (n : Nat) -> Type where
      EvenK : (k : Nat ** n = k + k) -> Even n

  data Odd : (n : Nat) -> Type where
      OddK : (k : Nat ** n = k + k + 1) -> Odd n
```

with the simpler, though less human-intuitive, form:

```idris
mutual
  ||| Zero is even, and successors of odds are even
  data Even : Nat -> Type where
    ZE : Even Z
    SO : Odd n -> Even (S n)

  ||| Successors of evens are odd
  data Odd : Nat -> Type where
    SE : Even n -> Odd (S n)
```

Using this definition, prove the following

```idris
oddPlusOddEven : Odd n -> Odd m -> Even (n + m)

oddPlusEvenOdd : Odd n -> Even m -> Odd (n + m)

evenPlusOddOdd : Even n -> Odd m -> Odd (n + m)

evenPlusEvenEven : Even n -> Even m -> Even (n + m)

predOddEven : Odd (S n) -> Even n

predNonZeroEvenOdd : Even (S n) -> Odd n
```

Some additional things I haven't attempted yet. These will be a lot more
difficult I think.

```idris
oddTimesOddOdd : Odd n -> Odd m -> Odd (n * m)

evenMultLeftEven : Even n -> (m : Nat) -> Even (n * m)

evenMultRightEven : (n : Nat) -> Even m -> Even (n * m)
```

