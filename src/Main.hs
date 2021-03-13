{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty as S

import Data.Monoid (mconcat)
import Data.Text.Lazy as TL

import System.IO
import System.Process (readProcess)

main = do
  putStrLn "Starting server..."
  haiku <- readHaiku
  haiku2 <- createHaiku
  scotty 3000 $ do
    get "/haiku" $ do
      S.text $ mconcat ["aaaaaa", TL.pack haiku2]

    notFound $ do
      S.text "Spesifiser ønsket tjeneste i URL"

-- Currently does lazy load. Probably want to make
-- eager so the handle can be closed in the function
readHaiku :: IO String
readHaiku = do
  handle <- openFile "haiku.txt" ReadMode
  contents <- hGetContents handle
  return contents

createHaiku :: IO String
createHaiku = do
  let path = "./echoHaiku.sh"
  readProcess path [] ""
  
