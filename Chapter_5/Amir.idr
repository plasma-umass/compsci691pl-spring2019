import Data.Vect

data Stack: (elem:Type) -> Type where
     EmptyStack: Stack elem
     (::): elem -> Stack elem -> Stack elem

push: elem -> Stack elem -> Stack elem
push x xs = x :: xs

pop: Stack elem -> (elem, Stack elem)
pop (x::xs) = (x, xs)

size: Stack elem -> Nat
size EmptyStack = Z
size (x::xs) = S (size xs)

data Command = Push String
              | Pop
              | End

parseCommand : String -> String -> Maybe Command
parseCommand "push" str = Just (Push str)
parseCommand "end" "" = Just End
parseCommand "pop" "" = Just Pop
parseCommand _ _ = Nothing

parse : (input : String) -> Maybe Command
parse input = case span (/= ' ') input of
                                    (cmd, args) => parseCommand cmd (ltrim args)

parsePop: (String, Stack String) -> (String, Stack String)
parsePop (str, stack) = (str ++ "\n", stack)

toStr: Stack String -> String
toStr EmptyStack = ""
toStr (x::xs) = x ++ " , " ++ (toStr xs)

processInput : Stack String  -> String -> Maybe (String, Stack String)
processInput stack input
    = case parse input of
            Nothing => Just ("Invalid command\n", stack)
            Just (Push item) =>
                  Just (show (S (size stack)) ++ "\n", push item stack)
            Just Pop => case (size stack) > 0 of
                                False =>  Just ("Stack is empty\n", stack)
                                True => Just (parsePop (pop stack))
            Just End => Nothing

main : IO ()
main = do
        putStrLn "Enter push, pop, or end commands."
        replWith EmptyStack "command: " processInput
