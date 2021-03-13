{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty as S

import Data.Monoid (mconcat)
import Data.Text.Lazy as TL

import System.IO

main = do
  putStrLn "Starting server..."
  haiku <- readHaiku
  putStrLn haiku
  scotty 3000 $ do
    get "/haiku" $ do
      S.text $ mconcat ["aaaaaa", TL.pack haiku]

    notFound $ do
      S.text "Spesifiser ønsket tjeneste i URL"

readHaiku :: IO String
readHaiku = do
  handle <- openFile "haiku.txt" ReadMode
  contents <- hGetContents handle
  return contents

