{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Main where

import Prelude
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure)
import Data.Maybe (listToMaybe)
import Data.List (isPrefixOf)
import Text.Show.Pretty (ppShow)

import Simulation (Simulation(..), Args(..), simulation)
import Machine(Machine(..))

main :: IO ()
main = do
    rawArgs <- getArgs
    args <- parseArgs rawArgs
    result <- simulation args
    putStrLn "Simulating Machine"
    case result of
        Failure errMsg -> putStrLn $ "Error: " ++ errMsg
        Success states -> do
            -- mapM_ (putStrLn . ppShow) states  -- Uncomment to print each state, if needed.
            putStrLn $ "Last state: " ++ show (cpu $ last states)
            putStrLn $ "Executed for " ++ show (length states) ++ " cycles"
            putStrLn "Simulation complete"

-- Function to parse command line arguments into the Args data type
parseArgs :: [String] -> IO Args
parseArgs argv = 
    case extractKey "firmware" argv of
        Just firmwarePath -> return Args { firmware = firmwarePath }
        Nothing -> do
            progName <- getProgName
            putStrLn "Error: Missing firmware argument."
            putStrLn $ "Usage: " ++ progName ++ " --firmware=FILE"
            exitFailure

filterByKey :: String -> [String] -> [String]
filterByKey key argv = filter (switch `isPrefixOf`) argv
  where
    switch = "--" ++ key ++ "="

extractKey :: String -> [String] -> Maybe String
extractKey key argv = listToMaybe $ map removePrefix $ filterByKey key argv
  where removePrefix = drop $ length ("--" ++ key ++ "=")
