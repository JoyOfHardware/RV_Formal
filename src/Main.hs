{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Main where

import Prelude
import Text.Show.Pretty (ppShow)

import Simulation(simulation)

main :: IO ()
main = do
  putStrLn "Simulating Machine"
  -- mapM_ (putStrLn . ppShow) simulation
  putStrLn $ "executed for " ++ show (length simulation) ++ " cycles"
  putStrLn "Simulation complete"