# Ch5 Question

Write a function that reads Push X and Pop commands (operations on a stack) from the console until the user enters End, and then reads a filename from the console and writes the final values of the stack to that file.

After each command, length of the stack must be shown. Besides it should avoid pop operation on an empty stack and inform it to the user.

You should implement your stack by using the following simple code.

```idris
data Stack: (n:Nat) -> (elem:Type) -> Type where
     MkStack: (elem:Type) -> Stack Z elem
     (::): elem -> Stack k elem -> Stack (S k) elem

push: elem -> Stack k elem -> Stack (S k) elem
push x xs = x :: xs

pop: Stack (S k) elem -> (elem, Stack k elem)
pop (x::xs) = (x, xs)
