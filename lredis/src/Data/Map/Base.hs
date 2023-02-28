{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE DeriveFoldable #-}
module Data.Map.Base (BSTree (Empty, Branch), create, insert, value, searchV, getRange, (!), isin, isntin) where
import Data.Maybe (isNothing)
import Data.List (sortOn, union)

-- | A binary search tree.
data BSTree k v
  = Empty
  | Branch k v (BSTree k v) (BSTree k v)
  deriving (Eq, Foldable, Show)

-- | Functor instance
instance Functor (BSTree k) where
  -- | Map a function `f` over the values of Map `m`
  fmap f m = vmap f m

instance (Ord k, Eq v) => Semigroup (BSTree k v) where
  (<>) = merge

instance (Ord k, Eq v) => Monoid (BSTree k v) where
  mempty = Empty

-- | Map a function `f` over the values of Map `m`
vmap :: (v -> v') -> BSTree k v -> BSTree k v'
vmap _ Empty            = Empty
vmap f (Branch k v l r) = Branch k (f v) (fmap f l) (fmap f r)

-- | Create a new BST from a K-V pair
create :: k -> v -> BSTree k v
create k v = Branch k v Empty Empty

-- | Insert a value into a BST
insert :: (Ord k) => k -> v -> BSTree k v -> BSTree k v
insert k v Empty             = create k v
insert k' v'(Branch k v l r) = case compare k k' of
  LT -> Branch k v l (insert k' v' r)
  GT -> Branch k v (insert k' v' l) r
  EQ -> Branch k' v' l r

foldTree :: (a -> b -> b) -> b -> BSTree k a -> b
foldTree _ acc Empty            = acc
foldTree f acc (Branch _ v l r) = foldTree f acc' l
  where acc' = f v r'
        r'   = foldTree f acc r

toList :: BSTree k v -> [(k,v)]
toList tree  = go tree
  where go (Branch k v l r) = [(k,v)] ++ go r ++ go l
        go Empty            = []

fromList :: Ord k => [(k,v)] -> BSTree k v
fromList [] = Empty
fromList xs = foldl (go) Empty xs
  where go t (k,v) = insert k v t

(!) :: (Ord k, Eq v) => BSTree k v -> k -> Maybe v
t ! k = value k t 

isin :: (Ord k, Eq v) => k -> BSTree k v -> Bool
isin k t = (t ! k) /= Nothing

isntin :: (Ord k, Eq v) => k -> BSTree k v -> Bool
isntin = (not .) . isin
 
merge :: (Ord k, Eq v) => BSTree k v -> BSTree k v -> BSTree k v
merge Empty b = b
merge a Empty = a
merge a b  = fromList $ sortOn fst $ union a' b'
  where a' = toList a
        b' = toList b

-- | Get the value at key `k`.
-- O (log n) (?)
value :: (Ord k) => k -> BSTree k v -> Maybe v
value _ (Empty) = Nothing
value k' (Branch k v l r) = case compare k k' of
  EQ -> Just v
  GT -> value k' l
  LT -> value k' r

-- | Search for a value `v` in a given BST, returning it's key if it is found.
searchV :: (Eq v) => v -> BSTree k v -> Maybe k
searchV v' (Branch k v l r) 
  | v == v' = Just k
  | v /= v' = if (not $ isNothing kL) then kL
                                      else kR
              where kL = searchV v' l 
                    kR = searchV v' r
searchV _ _ = Nothing

-- | Select from bst `t` between `l` and `h` inclusive.
getRange :: Ord k =>  k -> k -> BSTree k v -> [v]
getRange l h t = getRangeI t l h []

getRangeI :: (Ord k) => BSTree k v -> k -> k -> [v] -> [v]
getRangeI (Branch k v l r) lo hi arr = if
  | (lo <= k) -> getRangeI l lo hi (v:arr)
  | (hi >= k) -> getRangeI r lo hi (v:arr)
  | otherwise -> arr
getRangeI Empty _ _ arr              = arr
