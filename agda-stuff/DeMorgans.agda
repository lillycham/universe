module DeMorgans where

open import Data.Bool
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)


_ : not (true ∨ false) ≡ (not true) ∧ (not false)
_ = refl

_ : not (true ∧ false) ≡ (not true) ∨ (not false)
_ = refl

-- ¬[a∨b]⇔¬a∧¬b : ∀ {A B} → not (A ∨ B) ≡ (not A) ∧ (not B)
-- ¬[a∨b]⇔¬a∧¬b = refl

-- ≡⟨⟩∎

data False : Set where

postulate bottom : False
