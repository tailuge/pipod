fac 0 = 1
fac n = n * fac (n-1)

len [] = 0
len (_:xs) = 1 + len xs

data Exp a = Value a | Binop String (Exp a) (Exp a)

--eval :: Num a => Exp a -> a

eval (Value a) = a
eval (Binop "+" x y) = (eval x) + (eval y)
eval (Binop "-" x y) = (eval x) - (eval y)


--eval (Binop "+" (Value 10) (Binop "-" (Value 6) (Value 4)))