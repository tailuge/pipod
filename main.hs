import Data.Maybe

fac 0 = 1
fac n = n * fac (n-1)

len [] = 0
len (_:xs) = 1 + len xs

data Exp a = Value a | Binop String (Exp a) (Exp a)

--eval :: Num a => Exp a -> a

--eval (Value a) = a
--eval (Binop "+" x y) = (eval x) + (eval y)
--eval (Binop "-" x y) = (eval x) - (eval y)


--eval (Binop "+" (Value 10) (Binop "-" (Value 6) (Value 4)))



suffixes [] = [[]]
suffixes (x:xs) = (x:xs) : suffixes xs

prefixes lst = map reverse (reverse (suffixes (reverse lst)))

splits lst = zip (prefixes lst) (suffixes lst)

inserteverywhere x lst = map (\(pre,suf) -> pre ++ x:suf) (splits lst)

perm [] = []
perm (x:[]) = [[x]]
perm (x:xs) = concatMap (inserteverywhere x) (perm xs)

data Ex a = Val a | Op String (Ex a) (Ex a) deriving (Show, Eq)

add a b = Op "+" a b
sub a b = Op "-" a b
mul a b = Op "*" a b
divide a b = Op "/" a b

combinations 0 _  = [[]]
combinations _ [] = []
combinations n (x:xs)
  | n <= (length (x:xs)) = (map ((:) x) (combinations (n-1) xs)) ++ (combinations n xs)
  | otherwise = []

remove _ [] = []
remove a (x:xs)
  | a == x = xs
  | otherwise = x:(remove a xs)

removeboth (a:(b:[])) lst = remove a $ remove b lst

combineonepair f lst = map (\pair -> (f (head pair) (head(tail pair))) : (removeboth pair lst)) (combinations 2 lst)

combineallops lst = (combineonepair add lst) ++
                    (combineonepair mul lst) ++
                    (combineonepair sub lst) ++
                    (combineonepair (flip(sub)) lst) ++
                    (combineonepair divide lst) ++
                    (combineonepair (flip(divide)) lst)


buildtrees [] = []
buildtrees lst = lst ++ concatMap buildtrees (combineallops lst)

--data Maybe a = Nothing | Just a

maybeeval f x y = do a <- (eval x)
                     b <- (eval y)
                     return (f a b)

eval (Val a) = Just a

eval (Op "+" x y) = maybeeval (+) x y
eval (Op "-" x y) = maybeeval (-) x y
eval (Op "*" x y) = maybeeval (*) x y
eval (Op "/" x y) = maybeeval (/) x y

countdown target lst = filter (\(_,v) -> v==target) $ map (\x -> (x,eval x)) (buildtrees lst)

-- https://www.youtube.com/watch?v=pfa3MHLLSWI
-- countdown (Just 952) [Val 3, Val 6, Val 25, Val 50, Val 75, Val 100]

i x = x
k x _ = x
s x y z = x z (y z)
sks = s (k s)
