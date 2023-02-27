{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}
module Network.LProto.BaseSpec where

import Test.Hspec
import Test.Hspec.QuickCheck
import Network.LProto.Base

spec :: Spec
spec = do
  describe "cmdMapper" do
    it "handles echo commands"  $ (cmdMapper "ECHO" "Hello World!") `shouldBe` (Echo "Hello World!")
    it "handles exit commands"  $ (cmdMapper "EXIT" "")  `shouldBe` Exit
    it "discards exit argument" $ (cmdMapper "EXIT" "0") `shouldBe` Exit
    it "handles set commands"   $ (cmdMapper "SET" "A 10") `shouldBe` (Set "A" "10")
    it "handles empty commands" $ (cmdMapper "" "") `shouldBe` BadReq
    it "handles unknown commands" $ (cmdMapper "not" "a command")  `shouldBe` BadReq
    it "handles spaces in command data" $ (cmdMapper "E C H O" "") `shouldBe` BadReq
  describe "parseCmd" do
    it "parses commands" $ (parseCmd "ECHO hello world") `shouldBe` ("ECHO", "hello world")
    it "parses argless commands" $ (parseCmd "EXIT") `shouldBe` ("EXIT", "")
    it "handles empty arguments" $ (parseCmd "") `shouldBe` ("", "")
    
