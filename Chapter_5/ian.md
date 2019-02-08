# Rot N Cipher

Implement a program that performs a Rot N (a generalization of ROT13)
on a string. It should run in a loop that requests first a string, then
a number from the user. It should terminate when the user inputs an empty
string. Characters other than ascii [a-zA-Z] can be ignored.

## Example



    *RotN> :exec rotNloop
    String> This is a secret!             
    Number> 13
    Guvf vf n frperg!
    String> Here's another sentence.
    Number> 28
    Jgtg'u cpqvjgt ugpvgpeg.
    String> 
    *RotN> 

## Hints
The following functions from the prelude may be useful:
* `chr : Int -> Char`
* `ord : Char -> Int`
* `pack : Foldable t => t Char -> String`
* `unpack : String -> List Char`



