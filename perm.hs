import Data.Maybe

include x [] = [[x]]
include x (y:ys) = (x:y:ys) : (map (y:) (include x ys))


finclude x lst = foldr (\a ((y:ys):yss) -> (y:a:ys) : (map (a:) ((y:ys):yss))) [[x]] lst

suffixes [] = [[]]
suffixes (x:xs) = (x:xs) : suffixes xs

prefixes lst = map reverse (reverse (suffixes (reverse lst)))

splits lst = zip (prefixes lst) (suffixes lst)

inserteverywhere x lst = map (\(pre,suf) -> pre ++ x:suf) (splits lst)

perm [] = []
perm (x:[]) = [[x]]
perm (x:xs) = concatMap (inserteverywhere x) (perm xs)

path x = (x,[x])
cons x (y,lst) = (x+y, x:lst)

steps lst = (take 2 lst) : (steps3 lst) ++ [(drop ((length lst) - 2) lst)]
 where
    steps3 (a:b:c:[]) = [[a,b,c]]
    steps3 (x:xs) = (take 3 (x:xs)) : steps3 xs

paths [a] = map (\x -> [(x,[x])]) a
paths (x:xs) = zipWith f x (steps (paths xs))
  where f cost p = concat (map extend p)
         where extend p = map (cons cost) p

minpaths = map minimum . paths
minpath = minimum . minpaths

minpaths' [row] = (minimum . map path) row


