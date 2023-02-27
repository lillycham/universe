{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}
module Network.LProto.Base where
import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString as S ()
import qualified Data.ByteString.Char8 as C
import Control.Concurrent.Async (async, wait)
import qualified Control.Exception as E
-- import Control.Monad (unless, forever, void)
import System.IO (hPutStrLn, stderr)
import System.Exit (exitWith, ExitCode(ExitSuccess))

data Command
  = Echo C.ByteString
  | Exit
  | Set C.ByteString C.ByteString
  | BadReq
  deriving (Eq, Show)

data ProtoErr = ErrUnknown
  deriving (Show, E.Exception)

redisMain :: IO ()
redisMain = do
  let port = 3459
  sock <- socket AF_INET Stream 0
  bind sock (SockAddrInet port 0)
  listen sock 2
  C.putStrLn $ "listening on: " <> (C.pack $ show port)
  a0 <- async $ mainLoop sock
                -- \e -> do let err = show (e :: E.IOException)
                --          hPutStrLn stderr ("Error: " <> err)
                --          close sock
  mapM_ wait [a0]
  close sock

mainLoop :: Socket -> IO ()
mainLoop sock = do
  (conn, _) <- accept sock
  msg <- recv conn 4096
  let cmd = uncurry cmdMapper $ parseCmd msg
  C.putStr   $ "msg: "  <> msg
  C.putStrLn $ "cmd: "  <> (C.pack $ show cmd)
  _ <- handleCmd conn cmd
  mainLoop sock

parseCmd :: C.ByteString -> (C.ByteString, C.ByteString)
parseCmd ""  = ("", "")
parseCmd msg = case C.words msg of
          (cmd:rest) -> (cmd, C.unwords rest)
          _          -> ("", "")
            
cmdMapper :: C.ByteString -> C.ByteString -> Command
cmdMapper cmd body = case cmd of
  "ECHO" -> Echo body
  "EXIT" -> Exit
  "SET"  -> uncurry Set $ parseCmd body
  _      -> BadReq

handleCmd :: Socket -> Command -> IO Int
handleCmd sock cmd = case cmd of
                       Echo x  -> send sock x
                       Exit    -> send sock "Server shutting down!"
                               >> C.putStrLn "Shutting Down!" >> exitWith (ExitSuccess)
                       Set k v -> C.putStrLn ("setting " <> k <> " to " <> v)
                               >> send sock "OK"
                       BadReq  -> send sock "-unknown cmd"
   
