module Function.Operators where

infix 5 _$_

-- Function application operator
_$_ : ∀ {A B : Set} → (A → B) → A → B
f $ a = f a
