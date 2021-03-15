{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty as S

import Data.Monoid (mconcat)
import Data.Text.Lazy as TL

import System.IO
import System.Process (readProcess)

-- "In practice, liftIO is used each time one wants to
-- run IO actions in another monad, provided such monad allows for it."
main = do
  putStrLn "Starting server..."
  scotty 3000 $ do
    get "/haiku" $ do
      newHaiku <- S.liftAndCatchIO $ getHaiku
      S.text $ TL.pack newHaiku

    notFound $ do
      S.text "Spesifiser ønsket tjeneste i URL\n"


--NOTE: The process url is relative to the top level directory with cabal run
getHaiku :: IO String
getHaiku = do
  let runscript = "helpers/runHaiku.sh"
  readProcess runscript [] "" 
  
