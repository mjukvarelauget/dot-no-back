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

import qualified Data.Map as Map

data Haiku = Haiku {haiku :: [TL.Text]}
instance ToJSON Haiku where
  toJSON (Haiku lines) = object ["haiku" .= lines]

-- "In practice, liftIO is used each time one wants to
-- run IO actions in another monad, provided such monad allows for it."
main = do
  putStrLn "Starting server..."
  scotty 3000 $ do
    get "/haiku" $ do
      newHaiku <- S.liftAndCatchIO $ getHaiku
      S.liftAndCatchIO $ putStr newHaiku
      haikuToJSON newHaiku

    notFound $ do
      S.text "Spesifiser ønsket tjeneste i URL\n"


--NOTE: The process url is relative to the top level directory with cabal run
getHaiku :: IO String
getHaiku = do
  let runscript = "helpers/runHaiku.sh"
  readProcess runscript [] "" 

haikuToJSON :: String -> ActionM ()
haikuToJSON haikuString = S.json $ haikuRecord
  where haikuRecord = Haiku {haiku = linesList}
        linesList = withoutLastElement paddedLinesList
        paddedLinesList = splitOn "\n" (TL.pack haikuString)

-- Utility
withoutLastElement :: [a] -> [a]
withoutLastElement [] = []
withoutLastElement (head:[]) = []
withoutLastElement (head:tail) = head:(withoutLastElement tail)


