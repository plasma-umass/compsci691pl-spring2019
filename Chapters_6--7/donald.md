# Write an Arithmetic Evaluator with Type-Checked Number of Arguments

The goal of this problem is to write a function `evalStr` which aims to evaluate an arithmetic expression which contains some free variables, and values to substitute into those free variables. These free variables are denoted using integer indices. Some examples:

```idris
evalStr "1 + 2" == 3
evalStr "$0 + $0" 7 == 14
evalStr "$0 + $1" 7 9 == 16
evalStr "$0 + $1" 8 # SHOULD NOT TYPE-CHECK
evalStr "$0 + $1" 9 8 3 # SHOULD NOT TYPE-CHECK
```

## Starting with Evaluating an AST

Instead of working with the strings directly, instead start by considering an AST:

```
e ::=   Add e1 e2
        Sub e1 e2
        Mul e1 e2
        Div e1 e2
        Lit n   # This is a literal with integer value n
        Var n   # This is a variable with index n, i.e. "$n$"
```

Write a data type in Idris to represent this AST, and then write an `eval` function which evaluates using the AST directly, but still type-checks the number of arguments. Examples:

```idris
eval (Add (Lit 1) (Lit 2)) == 3
eval (Add (Var 0) (Var 0)) 7 == 14
eval (Add (Var 0) (Var 1)) 7 9 == 16
eval (Add (Var 0) (Var 1)) 8 # SHOULD NOT TYPE-CHECK
eval (Add (Var 0) (Var 1)) 9 8 3 # SHOULD NOT TYPE-CHECK
```

## Writing the parser

If you have extra time, you can write the parser which converts a string to the AST representation. It's not very related to dependent types though, so consider this optional. Once this is done you can easily write the complete `evalStr` function.
