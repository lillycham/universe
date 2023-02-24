module plfa.part1.Induction where

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong; sym)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; step-≡; _∎)
open import Data.Nat using (ℕ; zero; suc; _+_; _*_; _∸_;_^_)

-- One property of addition is that it is associative.
-- This means that the location of parentheses doesn't matter.

postulate
  _ : ∀ {m n p} → ((m + n) + p ≡ m + (n + p))

-- This proposition can be tested for a specific case:

_ : (3 + 4) + 5 ≡ 3 + (4 + 5)
_ =
  begin
    (3 + 4) + 5
  ≡⟨⟩
    7 + 5
  ≡⟨⟩
    12
  ≡⟨⟩
    3 + 9
  ≡⟨⟩
    3 + (4 + 5)
  ∎

-- But what if we want to prove that this property holds ∀ℕ?

-- We can prove this through proof by induction.

-- We first need to prove that it holds for zero, the base case.
-- We also need to prove for the inductive case - an arbitrary ℕ `m`.

-- To prove associativity, we take P m to be the property:
-- (m + n) + p ≡ m + (n + p)
-- where n and p are arbitrary ℕs.

+-assoc : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc zero n p =
  begin
    (zero + n) + p
  ≡⟨⟩
    n + p
  ≡⟨⟩
    zero + (n + p)
  ∎

+-assoc (suc m) n p =
  begin
    (suc m + n) + p
  ≡⟨⟩
    suc (m + n) + p
  ≡⟨⟩
    suc ((m + n) + p)
  ≡⟨ cong suc (+-assoc m n p) ⟩
    suc (m + (n + p))
  ≡⟨⟩
    suc m + (n + p)
  ∎
