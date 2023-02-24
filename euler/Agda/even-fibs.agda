{-# OPTIONS --sized-types --guardedness #-}
module even-fibs where

open import Data.Nat
open import Data.List --using (sum; upTo; filter; map; List)
open import Relation.Nullary using (Dec)
open import Data.Nat.Divisibility
open import Function using (_$_; _∘_)
open import Data.Bool

fib : ℕ → ℕ
fib 0 = 0
fib 1 = 1
fib (suc (suc n)) = fib (suc (n)) + fib (n)

efibs = sum ∘ (filter (2 ∣?_)) $ upTo 4000000

module Main where
open import Data.Nat.Show using (show)
open import IO

main : Main
main = run $ putStrLn $ show $ efibs
