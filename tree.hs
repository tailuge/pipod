
data Tree a = TreeLeaf a | TreeNode (Tree a) (Tree a) | Id deriving (Show, Eq) 

data Bush a = BushLeaf a | BushNode [Bush a] deriving (Show, Eq)


bush = BushNode [BushLeaf 'f', BushNode [BushLeaf 'g', BushLeaf 'x', BushLeaf 'y'], BushLeaf 'z', BushNode[BushLeaf 'h', BushLeaf 't']]

-- curry ?

mcurry :: Bush a -> Tree a
mcurry (BushLeaf x) = TreeLeaf x
mcurry (BushNode lst) = foldl (\acc elt -> TreeNode acc (mcurry elt)) Id lst

-- flatten ?

flatten :: Bush a -> [a]
flatten (BushLeaf x) = [x]
flatten (BushNode lst) = foldl (\acc elt -> acc ++ (flatten elt)) [] lst