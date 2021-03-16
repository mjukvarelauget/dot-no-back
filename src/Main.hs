{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty as S

import Data.Monoid (mconcat)
import Data.Text.Lazy as TL

import Data.Aeson
import Data.Aeson.Types

import Data.Vector as V

import GHC.Exts

import qualified Data.ByteString.Lazy as BL

import System.IO
import System.Process (readProcess)


-- "In practice, liftIO is used each time one wants to
-- run IO actions in another monad, provided such monad allows for it."
main = do
  putStrLn "Starting server..."
  scotty 3000 $ do
    get "/haiku" $ do
      newHaiku <- S.liftAndCatchIO $ getHaiku
      S.liftAndCatchIO $ putStr newHaiku
      S.json $ splitOn "\n" (TL.pack newHaiku)

    notFound $ do
      S.text "Spesifiser ønsket tjeneste i URL\n"


--NOTE: The process url is relative to the top level directory with cabal run
getHaiku :: IO String
getHaiku = do
  let runscript = "helpers/runHaiku.sh"
  readProcess runscript [] "" 

-- The haiku should be served as a JSON list, each element a line
