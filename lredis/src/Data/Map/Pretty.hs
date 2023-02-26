module Data.Map.Pretty (show) where
import Data.Map.Base (BSTree (Branch, Empty))

instance (Show k, Show v) => Show (BSTree k v) where
  show (Branch k v l r) = "[ " ++ show k ++ ":" ++ show v ++ " ] { " ++ show l ++ ", " ++ show r ++ " } "
  show Empty            = "_"
