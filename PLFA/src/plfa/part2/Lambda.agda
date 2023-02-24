open import Data.Bool using (Bool; true; false; T; not)
open import Data.Empty using (⊥; ⊥-elim)
open import Data.List using (List; _∷_; [])
open import Data.Nat using (ℕ; zero; suc)
open import Data.Product using (∃-syntax; _×_)
open import Data.String using (String; _≟_)
open import Data.Unit using (tt)
open import Relation.Nullary using (Dec; yes; no; ¬_)
open import Relation.Nullary.Decidable using (False; toWitnessFalse)
open import Relation.Nullary.Negation using (¬?)
open import Relation.Binary.PropositionalEquality using (_≡_; _≢_; refl)

-- stx of terms

-- seven constructs. three are for the core lambda calculus:

-- Variables ` x
-- Abstractions ƛ x ⇒ N
-- Applications L · M

-- Three are for the naturals:
-- Zero `zero
-- Successor `suc M
-- Case case L [zero⇒ M |suc x ⇒ N ]

-- And one is for recursion:
-- Fixpoint μ x ⇒ M

Id : Set
Id = String

infix  5 ƛ_⇒_
infix  5 μ_⇒_
infixl 7 _·_
infix  8 `suc_
infix  8 `_

data Term : Set where
  `_                      :  Id → Term
  ƛ_⇒_                    :  Id → Term → Term
  _·_                     :  Term → Term → Term
  `zero                   :  Term
  `suc_                   :  Term → Term
  case_[zero⇒_|suc_⇒_]    :  Term → Term → Id → Term → Term
  μ_⇒_                    :  Id → Term → Term

two : Term
two = `suc `suc `zero

plus : Term
plus = μ "+" ⇒ ƛ "m" ⇒ ƛ "n" ⇒
         case ` "m"
           [zero⇒ ` "n"
           |suc "m" ⇒ `suc (` "+" · ` "m" · ` "n") ]

twoᶜ : Term
twoᶜ = ƛ "s" ⇒ ƛ "z" ⇒ ` "s" · (` "s" · ` "z")

plusᶜ : Term
plusᶜ = ƛ "m" ⇒ ƛ "s" ⇒ ƛ "z" ⇒
      ` "m" · ` "s" · (` "n" · ` "s" · ` "z")

sucᶜ : Term
sucᶜ = ƛ "n" ⇒ `suc (` "n")

-- Write the definition of a lambda term that multiplies 2 ℕats
mul : Term
mul = μ "*" ⇒ ƛ "m" ⇒ ƛ "n" ⇒
        case `  "m"
          [zero⇒ ` "n"
          |suc "m" ⇒ ` "+" · ` "n" · (` "*" · ` "m" · ` "n")]

-- Write the definition of a lambda term that multiplies 2 naturals,
-- encoded as church numerals
mulᶜ : Term
mulᶜ = μ "*" ⇒ ƛ "m" ⇒ ƛ "n" ⇒ ƛ "f" ⇒ ƛ "x" ⇒
       ` "m" · (` "n" · ` "f") · ` "x"

zeroᶜ : Term
zeroᶜ = ƛ "f" ⇒ ƛ "x" ⇒ ` "x"

_ = mulᶜ · zeroᶜ · twoᶜ · twoᶜ

-- Ex. primed (stretch)

-- These definitions allow writing variables as x instead of ` "x"
var? : (t : Term) → Bool
var? (` _) = true
var? _     = false

ƛ′_⇒_ : (t : Term) → {_ : T (var? t)} → Term → Term
ƛ′_⇒_ (` x) N = ƛ x ⇒ N

case′_[zero⇒_|suc_⇒_] : Term → Term → (t : Term) → {_ : T (var? t)} → Term → Term
case′ L [zero⇒ M |suc (` x) ⇒ N ]  =  case L [zero⇒ M |suc x ⇒ N ]

μ′_⇒_ : (t : Term) → {_ : T (var? t)} → Term → Term
μ′ (` x) ⇒ N  =  μ x ⇒ N

-- T is a function mapping from computation to evidence.

-- The definition of plus can now be written as follows:
plus′ : Term
plus′ = μ′ + ⇒ ƛ′ m ⇒ ƛ′ n ⇒
          case′ m
            [zero⇒ n
            |suc m ⇒ `suc (+ · m · n) ]
  where
  +  =  ` "+"
  m  =  ` "m"
  n  =  ` "n"

-- Define multiplication in the same style
mul′ : Term
mul′ = μ′ * ⇒ ƛ′ m ⇒ ƛ′ n ⇒
          case′ m
            [zero⇒ n
            |suc m ⇒ + · n · (* · m · n)]
 where
 * = ` "*"
 + = plus′
 m = ` "m"
 n = ` "n"

-- Values
-- A value is a term corresponding to an answer.
-- `suc `suc `suc `suc `zero is a value, while plus · two · two is not.
-- All function abstractions are considered values.

-- The predicate Value M holds if a term M is a value.
data Value : Term → Set where
  V-ƛ : ∀ {x N}
      ---------
    → Value (ƛ x ⇒ N)
    
  V-zero :
    ---------
    Value `zero

  V-suc : ∀ {V}
    → Value V
      ---------
    → Value (`suc V)

-- In informal presentations of formal semantics, using V as the name of
-- a metavariable is sufficient to indicate that it is a value. In agda,
-- we must specifically invoke the Value predicate.

-- Substitution

-- In lambda calculus we can substitute a term for a variable in another term.
-- This is important in defining the operational semantics of function
-- application.

-- We write substitution as N [ x := V ], meaning
-- “substitute term V for free occurrences of variable x in term N”, 

infix 9 _[_:=_]

_[_:=_] : Term → Id → Term → Term
(` x) [ y := V ] with x ≟ y
... | yes _         = V
... | no  _         = ` x
(ƛ x ⇒ N) [ y := V ] with x ≟ y
... | yes _         = ƛ x ⇒ N
... | no  _         = ƛ x ⇒ N [ y := V ]
(L · M)  [ y := V ] = L [ y := V ] · M [ y := V ]
(`zero)  [ y := V ] = `zero
(`suc M) [ y := V ] = `suc M [ y := V ]
(case L [zero⇒ M |suc x ⇒ N ]) [ y := V ] with x ≟ y
... | yes _         = case L [ y := V ] [zero⇒ M [ y := V ] |suc x ⇒ N ]
... | no  _         = case L [ y := V ] [zero⇒ M [ y := V ] |suc x ⇒ N [ y := V ] ]
(μ x ⇒ N) [ y := V ] with x ≟ y
... | yes _         = μ x ⇒ N
... | no  _         = μ x ⇒ N [ y := V ]


-- Examples
_ : (ƛ "z" ⇒ ` "s" · (` "s" · ` "z")) [ "s" := sucᶜ ]
     ≡ ƛ "z" ⇒ sucᶜ · (sucᶜ · ` "z")
_ = refl

_ : (sucᶜ · (sucᶜ · ` "z")) [ "z" := `zero ] ≡ sucᶜ · (sucᶜ · `zero)
_ = refl

_ : (ƛ "x" ⇒ ` "y") [ "y" := `zero ] ≡ ƛ "x" ⇒ `zero
_ = refl

_ : (ƛ "x" ⇒ ` "x") [ "x" := `zero ] ≡ ƛ "x" ⇒ ` "x"
_ = refl

_ : (ƛ "y" ⇒ ` "y") [ "x" := `zero ] ≡ ƛ "y" ⇒ ` "y"
_ = refl

-- (λ y. x (λ x. x)) [ x := 0 ] → (λ y. 0 (λ x. x))

-- Reduction
infix 4 _—→_
data _—→_ : Term → Term → Set where
  ξ-·₁ : ∀ {L L′ M}
    → L —→ L′
      ---------
    → L · M —→ L′ · M

  ξ-·₂ : ∀ {V M M′}
    → Value V
    → M —→ M′
      ---------
    → V · M —→ V · M′
    
  β-ƛ : ∀ {x N V}
    → Value V
      ------------------------------
    → (ƛ x ⇒ N) · V —→ N [ x := V ]

  ξ-suc : ∀ {M M′}
    → M —→ M′
      ------------------
    → `suc M —→ `suc M′

  ξ-case : ∀ {x L L′ M N}
    → L —→ L′
      -----------------------------------------------------------------
    → case L [zero⇒ M |suc x ⇒ N ] —→ case L′ [zero⇒ M |suc x ⇒ N ]

  β-zero : ∀ {x M N}
      ----------------------------------------
    → case `zero [zero⇒ M |suc x ⇒ N ] —→ M

  β-suc : ∀ {x V M N}
    → Value V
      ---------------------------------------------------
    → case `suc V [zero⇒ M |suc x ⇒ N ] —→ N [ x := V ]

  β-μ : ∀ {x M}
      ------------------------------
    → μ x ⇒ M —→ M [ x := μ x ⇒ M ]
    
-- (λ x. x) (λ x. x) → λ x. x
-- (λ x. x) (λ x. x) (λ x. x) → (λ x. x) (λ x. x)
-- twoᶜ sucᶜ `zero → sucᶜ (sucᶜ `zero)

infix  2 _—↠_
infix  1 begin_
infixr 2 _—→⟨_⟩_
infix  3 _∎

data _—↠_ : Term → Term → Set where
  _∎ : ∀ M
      ---------
    → M —↠ M

  _—→⟨_⟩_ : ∀ L {M N}
    → L —→ M
    → M —↠ N
      ---------
    → L —↠ N

begin_ : ∀ {M N}
  → M —↠ N
    ------
  → M —↠ N
begin M—↠N = M—↠N

data _—↠′_ : Term → Term → Set where

  step′ : ∀ {M N}
    → M —→ N
      -------
    → M —↠′ N

  refl′ : ∀ {M}
      -------
    → M —↠′ M

  trans′ : ∀ {L M N}
    → L —↠′ M
    → M —↠′ N
      -------
    → L —↠′ N



