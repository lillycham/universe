module Data.Map.Access where
import Data.Map.Base (BSTree (Branch, Empty))
-- Accessors
left :: BSTree k v -> BSTree k v
left (Branch _ _ x _) = x
left Empty = Empty

right :: BSTree k v -> BSTree k v
right (Branch _ _ _ x) = x
right Empty = Empty

key :: BSTree k v -> Maybe k
key (Branch k _ _ _) = Just k
key Empty = Nothing
