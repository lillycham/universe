{-# OPTIONS --type-in-type #-}

data ⊥ : Set where

-- An impredicative data type

data D : Set where
  c : (f : (A : Set) → A → A) → D

-- Structural recursion with  f args < c f  is no longer valid.
-- We should not be able to demonstrated that D is empty.

empty : D → ⊥
empty (c f) = empty (f D (c f))

-- This gets us to absurdity quickly:

absurd : ⊥
absurd = empty (c λ A x → x)
