# Proving Essential Facts about Even and Odd Natural Numbers

## Defining Types for Even and Odd Propositions

In this problem we will work through proving some basic facts about even and odd numbers. The task is to define 2 types `Even n` and `Odd n` that represent the proposition that `n` is even (or odd, respectively). We don't want to talk about divisibility and actually dividing natural numbers (Idris has no implementation of `Fractional Nat`), so we want to use the easier definition that `n` is even if there exists a Nat `k` such that `n = 2*k = k + k`, and `n` is odd if there exists a Nat `k` such that `n = 2*k + 1 = k + k + 1`.

We can write this using a dependent pair:

```idris
data Even : (n : Nat) -> Type where
    EvenK : (k : Nat ** n = k + k) -> Even n
```

The type `Even n` represents that `n` is even, since the only way to construct an element of `Even n` is to provide a `k` and a proof that `n = k + k`. Note: you can also write it as `EvenK : (k : Nat) -> n = k + k -> Even n` without using a dependent pair, what matters is that you record both the `k` and the proof that `n = k + k`. Likewise, we can define `Odd n`:

```idris
data Odd : (n : Nat) -> Type where
    OddK : (k : Nat ** n = k + k + 1) -> Odd n
```

As a simple example, we can prove that zero is even:
```idris
total evenZ : Even Z
evenZ = EvenK (0 ** Refl)
```
Specifically, we chose `k` to be 0, and just needed to show that `0 = 0 + 0`, which Idris can do for us with `Refl`.

## Prove the most basic facts about evens and odds

Now that we have the definitions setup, try to prove the most basic facts about evens and odds. First as a warm up, try to show:

```idris
total oneNotEven : Even (S Z) -> Void
```

Now, show that even and odd numbers alternate:

```idris
total odd2even : Odd n -> Even (S n)
total even2odd : Even n -> Odd (S n)
```

It can also be convenient to go in the other direction, so also prove the following opposite lemmas:

```idris
total even2odd_backwards : Odd (S n) -> Even n
total odd2even_backwards : Even (S n) -> Odd n
```

## Prove some slightly more interesting facts

Now that the essential facts are proven, try to prove the following 4 theorems:

```idris
total oddPlusOdd : Odd n -> Odd m -> Even (n + m)
total oddPlusEven : Odd n -> Even m -> Odd (n + m)
total evenPlusOdd : Even n -> Odd m -> Odd (n + m)
total evenPlusEven : Even n -> Even m -> Even (n + m)
```

*Hint: My strategy was to prove `oddPlusOdd` directly via lots of algebra (i.e. without using the lemmas proved above, and instead doing lots of rewriting). Then, I proved the other 3 theorems by using `oddPlusOdd` and some of the lemmas already proved above. However, there are many ways to complete these proofs.*
