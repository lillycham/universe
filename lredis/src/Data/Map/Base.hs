{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiWayIf #-}
module Data.Map.Base (BSTree (Empty, Branch), create, insert, value, searchV, getRange) where
import Data.Maybe (isNothing)

-- | A binary search tree.
data BSTree k v = Empty |
  Branch k v (BSTree k v) (BSTree k v)

-- | Functor instance
instance Functor (BSTree k) where
  -- | Map a function `f` over the values of Map `m`
  fmap f m = vmap f m

-- | Map a function `f` over the values of Map `m`
vmap :: (v -> v') -> BSTree k v -> BSTree k v'
vmap _ Empty            = Empty
vmap f (Branch k v l r) = Branch k (f v) (fmap f l) (fmap f r)

-- | Create a new BST from a K-V pair
create :: k -> v -> BSTree k v
create k v = Branch k v Empty Empty

-- | Insert a value into a BST
insert :: (Ord k) => BSTree k v -> k -> v -> BSTree k v
insert Empty k v              = create k v
insert (Branch k v l r) k' v' = case compare k k' of
  GT -> Branch k v (insert l k' v') r
  LT -> Branch k v (insert r k' v') r
  EQ -> Branch k' v' l r

-- | Get the value at key `k`.
-- O (log n) (?)
value :: (Ord k) => BSTree k v -> k -> Maybe v
value (Empty) _ = Nothing
value (Branch k v l r) k' = case compare k k' of
  EQ -> Just v
  GT -> value l k'
  LT -> value r k'

-- | Search for a value `v` in a given BST, returning it's key if it is found.
searchV :: (Eq v) => BSTree k v -> v -> Maybe k
searchV (Branch k v l r) v'
  | v == v' = Just k
  | v /= v' = if (not $ isNothing kL) then kL
                                      else kR
              where kL = searchV l v'
                    kR = searchV r v'
searchV _ _ = Nothing

-- | Select from bst `t` between `l` and `h` inclusive.
getRange :: Ord k => BSTree k v -> k -> k -> [v]
getRange t l h = getRangeI t l h []

getRangeI :: (Ord k) => BSTree k v -> k -> k -> [v] -> [v]
getRangeI (Branch k v l r) lo hi arr = if
  | (lo <= k) -> getRangeI l lo hi (v:arr)
  | (hi >= k) -> getRangeI r lo hi (v:arr)
  | otherwise -> arr
getRangeI Empty _ _ arr              = arr
