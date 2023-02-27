{-# LANGUAGE BlockArguments #-}
module Data.Map.BaseSpec where
import Data.Map
import Data.List ((\\))
import Test.Hspec

infixl 0 |>

(|>) :: a -> (a -> b) -> b
x |> f = f x

testTree :: BSTree Integer String
testTree = insert 2 "c" $ insert 1 "b" $ create 0 "a"

spec :: Spec
spec = do
  describe "Functor" do
    it "holds true the identity law" $
      (fmap id testTree) `shouldBe` testTree
    it "holds true the composition law" $
      let f = replicate 1
          g = reverse in
      (fmap (f.g) testTree) `shouldBe`
      ((fmap f) . (fmap g) $ testTree)
    it "can be mapped over" $
      let f = (replicate 1)
          t = (create 0 "a") in
        (fmap f t) `shouldBe` (create 0 ["a"])
  describe "Searching" do
    it "can be searched by key" $
      (value 0 testTree) `shouldBe` (Just "a")
    it "missing keys give Nothing" $
      (value 10 testTree) `shouldBe` Nothing
    it "can be searched for values" $
      (searchV "b" testTree) `shouldBe` (Just 1)
    it "missing values give Nothing" $
      (searchV "d" testTree) `shouldBe` (Nothing)
    it "can be searched in ranges" $
      ((getRange 0 3 testTree) \\ ["a","b","c"]) `shouldBe` []
  describe "insertion" do
    it "keys can be overridden" $
      (create 0 "a" |> insert 0 "b") `shouldBe`
      (create 0 "b")
    it "inserts smaller values on left" $
      (create 1 "a" |> insert 0 "b") `shouldBe`
      (Branch 1 "a" (Branch 0 "b" Empty Empty) Empty)
    it "inserts bigger values on right" $
      (create 0 "a" |> insert 1 "b") `shouldBe`
      (Branch 0 "a" Empty (Branch 1 "b" Empty Empty))
    
