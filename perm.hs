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


