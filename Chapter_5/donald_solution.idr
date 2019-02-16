import Data.Vect
import Data.String

MatrixT : Nat -> Nat -> Type -> Type
MatrixT n m t = Vect n (Vect m t)

Matrix : Nat -> Nat -> Type
Matrix n m = MatrixT n m Double

total exactSizeMat : (n : Nat) -> (m : Nat) -> Matrix k l -> Maybe (Matrix n m)
exactSizeMat Z m [] = Just []
exactSizeMat (S n) m [] = Nothing
exactSizeMat Z m (row :: restRows) = Nothing
exactSizeMat (S n) m (row :: restRows) = do
    row' <- exactLength m row
    restRows' <- exactSizeMat n m restRows
    Just (row' :: restRows')


total mapVect : (a -> Maybe b) -> Vect n a -> Maybe (Vect n b)
mapVect f [] = Just []
mapVect f (x :: xs) = do
    x' <- f x
    xs' <- mapVect f xs
    Just (x' :: xs')

total mapMatrixM : (a -> Maybe b) -> MatrixT n m a -> Maybe (MatrixT n m b)
mapMatrixM f [] = Just []
mapMatrixM f (row :: restRows) = do
    row' <- mapVect f row
    restRows' <- mapMatrixM f restRows
    Just (row' :: restRows')
-- mapMatrixM f ((x :: ys) :: xs) = ?flatMapMatrix_rhs_3


total mkVect : List t -> (k ** Vect k t)
mkVect [] = (0 ** [])
mkVect (x :: xs) =
    let (k ** xsVect) = mkVect xs in
    (S k ** x :: xsVect)

total checkLen : (k ** Vect k String) -> (n : Nat) -> Maybe (Vect n String)
checkLen (k ** xs) n = exactLength n xs


total verifLengths : List (k' ** Vect k' String) -> Maybe (k ** List (Vect k String))
verifLengths [] = Just (0 ** [])
verifLengths ((headLen ** head) :: xs) =
    let possibleRows = map (\rowKVect => checkLen rowKVect headLen) xs in
    -- acc : Maybe (List (Vect headLen String))
    -- row : Maybe (Vect headLen String)
    -- For some reason foldlM wouldn't work...
    let res = foldl (\acc, row => case (acc, row) of
            (Nothing, _) => Nothing
            (_, Nothing) => Nothing
            (Just accList, Just rowVect) => Just (rowVect :: accList)
        ) (Just (the (List _) [head])) possibleRows in
    case res of
        Nothing => Nothing
        Just rows => Just (headLen ** (reverse rows))


total parseMatStr : String -> Maybe (n ** m ** MatrixT n m String)
parseMatStr str =
    let lines = split (== '\n') str in
    let n = length lines in
    -- List (k : Nat ** Vect k String)
    let rowVects' = map (\line =>
        let vals = split (== ',') line in
        mkVect vals
        ) lines in
    case verifLengths rowVects' of
        Nothing => Nothing
        Just (m ** rows) =>
            let (n ** rows') = mkVect rows in
            Just (n ** m ** rows')

total parseMat : String -> Maybe (n ** m ** Matrix n m)
parseMat str = do
    (n ** m ** matStr) <- parseMatStr str
    mat <- mapMatrixM String.parseDouble matStr
    Just (n ** m ** mat)

total readMat : String -> IO (Maybe (n ** m ** Matrix n m))
readMat path = do
    Right str <- readFile path
        | Left err => pure Nothing
    let str = trim str
    pure (parseMat str)

total readMatDims : String -> (n : Nat) -> (m : Nat) -> IO (Maybe (Either (Nat, Nat) (Matrix n m)))
readMatDims path n m = do
    Just (k ** l ** mat) <- readMat path
        | Nothing => pure Nothing
    pure (case exactSizeMat n m mat of
            Nothing => Just (Left (k, l))
            Just mat' => Just (Right mat'))

total addVect : Vect n Double -> Vect n Double -> Vect n Double
addVect [] [] = []
addVect (x :: xs) (y :: ys) = (x + y) :: addVect xs ys

total addMat : Matrix n m -> Matrix n m -> Matrix n m
addMat [] [] = []
addMat (rowA :: restA) (rowB :: restB) = (addVect rowA rowB) :: addMat restA restB

total main : IO ()
main = do
    let pathA = "donald_solution_test_a.csv"
    let pathB = "donald_solution_test_b.csv"
    Just (n ** m ** matA) <- readMat pathA
        | Nothing => do putStrLn ("Could not read matrix A at path: " ++ (show pathA))
    Just (Right matB) <- readMatDims pathB n m
        | Nothing => do putStrLn ("Could not read matrix B at path: " ++ (show pathA))
        | Just (Left (k, l)) => do putStrLn ("Matrix dimensions do not agree: " ++ (show n) ++ " x " ++ (show m) ++ " and " ++ (show k) ++ " x " ++ (show l))
    putStrLn "Input matrix A:"
    printLn matA
    putStrLn "\nInput matrix B:"
    printLn matB
    let sum = addMat matA matB
    putStrLn "\nSum:"
    printLn sum
    pure ()
