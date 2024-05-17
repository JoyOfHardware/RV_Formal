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
  states <- simulation
  putStrLn "Simulating Machine"
  -- mapM_ (putStrLn . ppShow) simulation
  putStrLn $ "last state" ++ show (last states)
  putStrLn $ "executed for " ++ show (length states) ++ " cycles"
  putStrLn "Simulation complete"