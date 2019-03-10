# Proving Monotonicity of * and +

## 1: Prove that `+` is monotonic
This one isn't too bad
```idris
total
plusMonotonic : (c : Nat) -> LTE a b -> LTE (c + a) (c + b)
```

## 2: Prove that `*` is monotonic
This one is trickier. Write a proof that for naturals a, b, and c, that if `a <=
b`, then multiplying by `c` respects this ordering.
