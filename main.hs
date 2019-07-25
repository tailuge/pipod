fac 0 = 1
fac n = n * fac (n-1)

len [] = 0
len (x:xs) = 1 + len xs