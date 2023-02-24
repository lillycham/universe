module leastSq where

open import Data.Float -- using (Float) renaming (_*_ to _×_)
open import Data.Float.Base
import Data.Nat as N
open N using (ℕ)
open import Data.Vec as V
open V
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open import Function
import Data.List as D
open D using (List; []; _∷_)
open import Data.Unit

-- Reify length of vector
vec→ℕ : ∀ {n} → {a : Set} → Vec a n → ℕ
vec→ℕ {n} _ = n

-- Sum vector of floats
sumF : ∀ {a} → Vec Float a → Float 
sumF = foldr _ _+_ 0.0

-- Least Squares regression
leastSq : ∀ {a} → Vec Float a → Vec Float a → Float → Float
leastSq xs ys x = m * x + b
  where
    len = fromℕ $ vec→ℕ xs -- Safe to assume len xs == len ys
    m   = (len * sumF (zipWith (_*_) xs ys)
               - sumF xs * sumF ys)
           ÷ (len * sumF (map (_** 2.0) xs)
                    - sumF xs ** 2.0)
    b   = (sumF ys - m * sumF xs) ÷ len

a : Vec Float 5
a = 2.0 ∷ 3.0 ∷ 5.0 ∷ 7.0 ∷ [ 9.0 ]

b : Vec Float 5
b = 4.0 ∷ 5.0 ∷ 7.0 ∷ 10.0 ∷ [ 15.0 ]

leastSq-a,b,8≡12,45 : (leastSq a b 8.0 ≡ 12.451219512195122)
leastSq-a,b,8≡12,45 = refl


