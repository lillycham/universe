{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE TupleSections #-}
module Data.Map.BaseSpec where
import Data.Map
import Data.List ((\\))
import Test.Hspec
import Test.Hspec.QuickCheck
import Control.Applicative ((<$>))
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Function
import Test.QuickCheck.Gen

infixl 0 |>

(|>) :: a -> (a -> b) -> b
x |> f = f x

instance (Ord k, Arbitrary k,
          Ord v, Arbitrary v) => Arbitrary (BSTree k v) where
  arbitrary = sized go
    where go n = frequency
            [ (1, pure Empty)
            , (n, insert <$> arbitrary
                         <*> arbitrary
                         <*> go (n `div` 2))]

monoidAssocProp :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssocProp x y z = (x <> (y <> z)) == ((x <> y) <> z)

monoidRightIdProp :: (Eq m, Monoid m) => m -> Bool
monoidRightIdProp x = x == (x <> mempty)

monoidLeftIdProp :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdProp x = (mempty <> x) == x

functorIdProp :: (Functor f, Eq (f a)) => f a -> Bool
functorIdProp x = (fmap id x) == x

-- ∀ f, g ∈ A. F(f) ∘ F(g) = F(f ∘ g)  
functorCompProp :: (Functor f, Eq (f c)) => f a -> Fun a b -> Fun b c -> Bool
functorCompProp x (apply -> f) (apply -> g) = (fmap (g.f) x) == (fmap g . fmap f $ x)

genTreeWith :: (Arbitrary v, Ord v) => Int -> Gen (BSTree Int v)
genTreeWith n = arbitrary `suchThat` (n `isin`)

genTreeWith' :: (Arbitrary v, Ord v) => Gen ((BSTree Int v), Int)
genTreeWith' =
  arbitrary >>= \k ->
  genTreeWith k >>= \t ->
  pure (t, k)

genTreeWithout :: (Arbitrary v, Ord v) => Int -> Gen (BSTree Int v)
genTreeWithout n = arbitrary `suchThat` (n `isntin`)

genTreeWithout' :: (Arbitrary v, Ord v) => Gen ((BSTree Int v), Int)
genTreeWithout' =
  arbitrary >>= \k ->
  genTreeWithout k >>= \t ->
  pure (t, k)

genBranch =
  arbitrary >>= \k ->
  arbitrary >>= \v ->
  pure $ Branch k v Empty Empty

genSmallerThan n = arbitrary `suchThat` (n >)
genGreaterThan n = arbitrary `suchThat` (n <)

testTree :: BSTree Int String
testTree = insert 2 "c" $ insert 1 "b" $ create 0 "a"

spec :: Spec
spec = do
  describe "Functor" do
    prop "holds the identity law"
      (functorIdProp :: BSTree Int Int -> Bool)
    prop "holds the composition law"
      (functorCompProp :: BSTree Int Int -> Fun Int Int -> Fun Int Int -> Bool)
  describe "Monoid" do
    prop "holds the associativity law"
      (monoidAssocProp :: BSTree Int Int -> BSTree Int Int -> BSTree Int Int -> Bool)
    prop "holds the right identity law"
      (monoidRightIdProp :: BSTree Int Int -> Bool)
    prop "holds the left identity law"
      (monoidLeftIdProp :: BSTree Int Int -> Bool)
  describe "Searching" do
    prop "can be searched by key" $
      forAll (genTreeWith' :: Gen ((BSTree Int Int), Int)) \(t,k) ->
        (t ! k) /= Nothing
      -- k `isin` t
    prop "missing keys give Nothing" $
      forAll (genTreeWithout' :: Gen ((BSTree Int Int), Int)) \(t,k) ->
        t ! k == Nothing
    it "missing values give Nothing" $
      (searchV "d" testTree) `shouldBe` (Nothing)
    it "can be searched in ranges" $
      ((getRange 0 3 testTree) \\ ["a","b","c"]) `shouldBe` []
  describe "insertion" do
    it "keys can be overridden" $
      (create 0 "a" |> insert 0 "b") `shouldBe`
      (create 0 "b")
    it "inserts smaller keys on left" $
      forAll (genBranch :: Gen (BSTree Int Int)) \t@(Branch k v _ r) ->
        forAll (genSmallerThan k) \k' ->
          forAll (arbitrary :: Gen Int) \v ->
            let new = create k' v in (insert k' v t) == (Branch k v new r)
      -- (create 1 "a" |> insert 0 "b") `shouldBe`
      -- (Branch 1 "a" (Branch 0 "b" Empty Empty) Empty)
    it "inserts bigger values on right" $
      (create 0 "a" |> insert 1 "b") `shouldBe`
      (Branch 0 "a" Empty (Branch 1 "b" Empty Empty))
    
