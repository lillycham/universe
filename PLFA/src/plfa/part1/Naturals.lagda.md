
```agda
module plfa.part1.Naturals where
```

# The Naturals are an inductive data type.

ℕ, the set of the naturals, is infinite, but it can be defined in a few lines
according to __Peano's axioms.__ As inference rules, there are:

   --------
    zero : ℕ

    m : ℕ
    ---------
    suc m : ℕ

which translates to the Agda definition as follows:

```agda
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ
```

ℕ is the name of the datatype. `zero` and `suc` are the constructors.

- Base case: Zero is a natural number

- *Inductive* case: If `m` is a natural number, then so is `suc m`.

These two rules give the only way of creating naturals.
Hence, naturals are written like:

    zero
    suc zero
    suc (suc zero)
    suc (suc (suc zero))

0 is `zero`; 1 is `suc zero`; `2 is suc (suc zero)`; and so on.

```agda
seven : ℕ
seven = suc (suc (suc (suc (suc (suc (suc zero))))))
```

# Understanding the definition

The keyword `data` begins an *inductive definition* - a new datatype
with constructors.`ℕ : Set` tells us that this datatype is named "ℕ",
and that it is a `Set`, meaning a type.`where` seperates the declaration
of the type from the definition of it's constructors.

The rest of the definition tells us the constructors, `zero` and `suc`.
The lines
    zero : ℕ
    suc  : ℕ → ℕ
give signatures specifying the types of the constructors zero and suc.
They tell us that zero is a natural number and that suc takes a natural
number as an argument and returns a natural number.

# Pragmas

A pragma is a special kind of comment which informs the compiler of
something. This pragma tells the compiler that `ℕ` is a definition of
the naturals, and allows us to type `0`, `1`,... instead of zero,
suc zero, and so on.

```agda
{-# BUILTIN NATURAL ℕ #-}
```

It also internally allows the agda compiler to change out our definition
of ℕ for the Haskell `Integer` type. This is considerably more efficient.

# Imports
Shortly we will want to write some equations that hold between terms
involving natural numbers. To support doing so, we import the definition
of equality and notations for reasoning about it from the Agda standard library:

```agda
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)
```

The first line brings the standard library module that defines equality
into scope and gives it the name Eq. The second line opens that module,
that is, adds all the names specified in the using clause into the
current scope. In this case the names added are `_≡_`, the equality operator,
and refl, the name for evidence that two terms are equal. The third line
takes a module that specifies operators to support reasoning about
equivalence, and adds all the names specified in the using clause into
the current scope. In this case, the names added are `begin_`, `_≡⟨⟩_`,
and _∎. We will see how these are used below. We take these as givens
for now, but will see how they are defined in Chapter Equality.

Agda uses underbars to indicate where terms appear in infix or mixfix
operators. Thus, _≡_ and _≡⟨⟩_ are infix (each operator is written between two terms),
while begin_ is prefix (it is written before a term), and _∎ is postfix
(it is written after a term).

Parentheses and semicolons are among the few characters that cannot
appear in names, so we do not need extra spaces in the using list.

Here is the definition of addition:

```agda
_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)
```
It has a base case and an inductive case, corresponding to the base case
and inductive case of the nats.
The base case says that adding a number n to zero, will return the number n.
The inductive case says that adding the successor of an number to another
number, (suc m) + n, returns the successor of adding the two numbers,
suc (m + n).

Let's add two and three:

```agda
_ : 2 + 3 ≡ 5
_ =
  begin
    2 + 3
  ≡⟨⟩
    suc (1 + 3)
  ≡⟨⟩
    suc (suc (0 + 3))
  ≡⟨⟩
    suc (suc 3)
  ≡⟨⟩
    5
  ∎
```

Of course we can simply write this with `refl`:

```agda
_ : 2 + 3 ≡ 5
_ = refl
```

This is an example of a proof.
Here `2 + 3 ≡ 5` is a type, and the chain of equations/refl are terms of the type.
The terms provide evidence for the assertion.

# Exercise +-example
```agda
+-example : 3 + 4 ≡ 7
+-example =
  begin
    3 + 4
  ≡⟨⟩
    suc (2 + 4)
  ≡⟨⟩
    suc (suc (1 + 4))
  ≡⟨⟩
    suc (suc (suc (0 + 4)))
  ≡⟨⟩
    suc (suc (suc 4))
  ≡⟨⟩
    7
  ∎
```

Now that we have defined addition, we can define multiplication as repeated addition.

```agda
_*_ : ℕ → ℕ → ℕ
zero    * n  =  zero
(suc m) * n  =  n + (m * n)
```

Let's multiply two and three.

```agda
_ =
  begin
    2 * 3
  ≡⟨⟩    -- inductive case
    3 + (1 * 3)
  ≡⟨⟩    -- inductive case
    3 + (3 + (0 * 3))
  ≡⟨⟩    -- base case
    3 + (3 + 0)
  ≡⟨⟩    -- simplify
    6
  ∎
```

# Exercise *-example
Compute 3 * 4, writing out your reasoning as a chain of equations.

```agda
_ =
  begin
    3 * 4
  ≡⟨⟩
    4 + (2 * 4)
  ≡⟨⟩
    4 + (4 + (1 * 4))
  ≡⟨⟩
    4 + (4 + (4 + (0 * 4)))
  ≡⟨⟩
    4 + (4 + (4 + 0))
  ≡⟨⟩
    12
  ∎
```

# Exercise _^_ (recommended)
Define exponentiation, which is given by the following equations:
    m ^ 0        =  1
    m ^ (1 + n)  =  m * (m ^ n)

```agda
_^_ : ℕ → ℕ → ℕ
m ^ 0       = 1
m ^ (suc n) = m * (m ^ n)
```

Check that 3 ^ 4 is 81.

```agda
_ : (3 ^ 4) ≡ 81
_ =
  begin
    3 ^ 4
  ≡⟨⟩
    3 * (3 * (3 * 3))
  ≡⟨⟩
    81
  ∎
  
_ : (3 ^ 4) ≡ 81
_ = refl
```

# Monus
Monus (∸) is subtraction defined on the naturals. Since there is no negative naturals, the result of
a bigger number subtracted from a smaller one is taken to be zero.

```agda
_∸_ : ℕ → ℕ → ℕ
m     ∸ zero   =  m
zero  ∸ suc n  =  zero
suc m ∸ suc n  =  m ∸ n
```

- If the second argument is zero, then the first equation applies.
  - If it is `suc n`, then we consider the first argument.
  - If it is zero, the second equation applies.
  - If it is `suc m` then the third equation applies

Agda would raise an error if all the cases are not covered.
As with multiplication and addition, the recursive definition is well founded because monus on
bigger numbers is defined in terms of monus on smaller ones.

Let's subtract two from three.
```agda
_ =
  begin
    3 ∸ 2
  ≡⟨⟩
    2 ∸ 1
  ≡⟨⟩
    1 ∸ 0
  ≡⟨⟩
    1
  ∎
```

We didn't use the second equation here, but it is required if we subtract a larger number from a
smaller one:

```agda
_ =
  begin
    2 ∸ 3
  ≡⟨⟩
    1 ∸ 2
  ≡⟨⟩
    0 ∸ 1
  ≡⟨⟩
    0
  ∎
```

Monus is defined so that exactly one equation will apply. Say the second line was instead written:

      zero ∸ n = zero

Then it would not be clear whether agda should use the first or second line to simplify `zero ∸ zero.`
In this case, both lines would lead to the same answer, but that may not always be the case.
Using the pragma `--exact-split` causes agda to warn us if we have overlapping cases.

# Exercise example₁ and example₂
Compute 5 ∸ 3 and 3 ∸ 5, writing out your reasoning as a chain of equations.

```agda
_ =
  begin
    5 ∸ 3
  ≡⟨⟩
    4 ∸ 2
  ≡⟨⟩
    3 ∸ 1
  ≡⟨⟩
    2 ∸ 0
  ≡⟨⟩
    2
  ∎

_ =
  begin
    3 ∸ 5
  ≡⟨⟩
    2 ∸ 4
  ≡⟨⟩
    1 ∸ 3
  ≡⟨⟩
    0 ∸ 2
  ≡⟨⟩
    0
  ∎
```

# Operator Precedence

Precedence is often used to avoid writing many parentheses. Application binds more *tightly*
than any operator, so we may write `suc m + n` to mean `(suc m) + n`. As another example, we
say that multiplication binds more tightly than addition, and so write n + m * n to mean n + (m * n).
We also sometimes say that addition associates to the left, and so write m + n + p to mean (m + n) + p.

In Agda the precedence and associativity of infix operators needs to be declared:

```agda
infixl 6  _+_  _∸_
infixl 7  _*_
```

This states operators _+_ and _∸_ have precedence level 6, and operator _*_ has precedence
level 7. Addition and monus bind less tightly than multiplication because they have lower
precedence. Writing infixl indicates that all three operators associate to the left. One can also
write infixr to indicate that an operator associates to the right, or just infix to indicate that
parentheses are always required to disambiguate.

# Currying


```agda

```

We have chosen to represent a function of two arguments in terms of a function of the first
argument that returns a function of the second argument. This trick goes by the name currying.
Agda, like other functional languages such as Haskell and ML, is designed to make currying easy
to use. Function arrows associate to the right and application associates to the left

`ℕ → ℕ → ℕ` stands for `ℕ → (ℕ → ℕ)`
and
`_+_ 2 3` stands for `(_+_ 2) 3`.

The term _+_ 2 by itself stands for the function that adds two to its argument, hence applying it
to three yields five.

# More pragmas
Including the lines
```agda
{-# BUILTIN NATPLUS _+_ #-}
{-# BUILTIN NATTIMES _*_ #-}
{-# BUILTIN NATMINUS _∸_ #-}
```
tells Agda that these three operators correspond to the usual ones, and enables it to perform
these computations using the corresponding Haskell operators on the arbitrary-precision integer type.
Representing naturals with zero and suc requires time proportional to m to add m and n, whereas
representing naturals as integers in Haskell requires time proportional to the larger of the logarithms
of m and n. Similarly, representing naturals with zero and suc requires time proportional to the
product of m and n to multiply m and n, whereas representing naturals as integers in Haskell requires
time proportional to the sum of the logarithms of m and n.

# Exercise Bin (stretch)

A more efficient representation of natural numbers uses a binary rather than a unary system. We represent a number as a bitstring:

```agda
data ℕᵇ : Set where
  ⟨⟩ : ℕᵇ
  _O : ℕᵇ → ℕᵇ
  _I : ℕᵇ → ℕᵇ
```

Define a function
       inc : Bin → Bin
that converts a bitstring to the bitstring for the next higher number.
Using the above, define a pair of functions to convert between the two representations.
      to   : ℕ → Bin
      from : Bin → ℕ
For the former, choose the bitstring to have no leading zeros if it represents a positive natural, and
represent zero by ⟨⟩ O. Confirm that these both give the correct answer for zero through four.


```agda
inc : ℕᵇ → ℕᵇ
inc ⟨⟩ = ⟨⟩ I
inc (x O) = x I
inc (x I) = (inc x) O

to : ℕ → ℕᵇ
to 0 = ⟨⟩ O
to (suc n) = inc (to n)

from : ℕᵇ → ℕ
from ⟨⟩ = 0
from (x O) = from x + from x
from (x I) = suc (from x + from x)

-- Proofs?

-- incP : ∀ {b} → from (inc b) ≡ suc (from b)
-- incP {⟨⟩}  = refl
-- incP {b O} = refl
-- incP {b I} = {!!}
 

-- tests
_ : inc (⟨⟩ I O I I) ≡ ⟨⟩ I I O O
_ = refl

_ : inc ⟨⟩ ≡ ⟨⟩ I
_ = refl

_ : inc (⟨⟩ I) ≡ ⟨⟩ I O
_ = refl

_ : inc (⟨⟩ I O) ≡ ⟨⟩ I I
_ = refl

_ : inc (⟨⟩ I I) ≡ ⟨⟩ I O O
_ = refl

_ : inc (⟨⟩ I O O) ≡ ⟨⟩ I O I
_ = refl

_ : to 0 ≡ ⟨⟩ O
_ = refl

_ : to 1 ≡ ⟨⟩ I
_ = refl

_ : to 2 ≡ ⟨⟩ I O
_ = refl

_ : to 3 ≡ ⟨⟩ I I
_ = refl

_ : to 4 ≡ ⟨⟩ I O O
_ = refl

_ : from ⟨⟩ ≡ 0
_ = refl

_ : from (⟨⟩ I) ≡ 1
_ = refl

_ : from (⟨⟩ I O) ≡ 2
_ = refl

_ : from (⟨⟩ I I) ≡ 3
_ = refl

_ : from (⟨⟩ I O O) ≡ 4
_ = refl
```
