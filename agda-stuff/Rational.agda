-- The set of rational numbers ℚ is defined as numbers that can be
-- expressed as the quotient of two integral values, where the 2nd,
-- the denominator, is non-zero.

open import Data.Nat

record ℚ {A B : ℕ} : Set where
  field
    num : A
    den : B
  
  
