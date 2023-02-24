{-# OPTIONS --guardedness #-}
module mults-of-three-or-five where

open import Data.List using (sum; filter; upTo)
open import Data.Nat
open import Data.Nat.Divisibility
open import Data.Nat.Show using (show)

open import Relation.Nullary using (Dec)
open import Relation.Unary.Properties using (_∪?_)

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (_≡⟨⟩_)
open import Function using (_$_; _⇔_)

-- Find the list of all factors of 3 ∧ 5, then sum them up.
muls : ℕ → ℕ
muls n = sum (filter ((3 ∣?_) ∪? (5 ∣?_)) (upTo n))

-- Assert that `muls 1000` is ≡ to 233168, the desired result.
muls≡233168 : (muls 1000) ≡ 233168
muls≡233168 = refl

module Main where
open import IO using (Main; run; putStrLn; _>>_)
main : Main
main = run $ do
  putStrLn $ show $ muls 1000
  

