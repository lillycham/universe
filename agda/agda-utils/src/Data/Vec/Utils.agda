-- Agda-utils library
-- Utilities for working with Vecs

module Data.Vec.Utils where

open import Data.Vec as V
open import Data.Nat using (ℕ)

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)

-- Reify length of vector
vec→ℕ : ∀ {n} → {a : Set} → Vec a n → ℕ
vec→ℕ {n} _ = n

-- Sum vector of floats
sumF : ∀ {a} → Vec Float a → Float 
sumF = foldr _ _+_ 0.0

