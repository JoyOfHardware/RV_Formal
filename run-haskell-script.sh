#!/bin/bash

# Check if a script file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <Haskell script file>"
  exit 1
fi

SCRIPT=$1

# Ensure the project is built
cabal build

# Run the script using runghc with the correct GHC options
runghc -i./hs -package-env . $SCRIPT

