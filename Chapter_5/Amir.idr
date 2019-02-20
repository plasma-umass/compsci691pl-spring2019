import Data.Vect

data Stack: (elem:Type) -> Type where
     EmptyStack: Stack elem
     (::): elem -> Stack elem -> Stack elem

push: elem -> Stack elem -> Stack elem
push x xs = x :: xs

pop: Stack elem -> Maybe (elem, Stack elem)
pop EmptyStack = Nothing
pop (x::xs) = Just ((x, xs))

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

parsePop: Stack String -> (String, Stack String)
parsePop stack = case pop stack of
                      Nothing => ("Stack is empty\n", stack)
                      Just ((str, stack2)) => (str ++ "\n", stack2)

toStr: Stack String -> String
toStr EmptyStack = ""
toStr (x::xs) = x ++ " , " ++ (toStr xs)

processInput : Stack String  -> String -> Maybe (String, Stack String)
processInput stack input
    = case parse input of
            Nothing => Just ("Invalid command\n", stack)
            Just (Push item) =>
                  Just (show (S (size stack)) ++ "\n", push item stack)
            Just Pop => Just (parsePop stack)
            Just End => Nothing

main : IO ()
main = do
        putStrLn "Enter push, pop, or end commands."
        replWith EmptyStack "command: " processInput
