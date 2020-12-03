{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Network.TLS.RNG
    ( StateRNG(..)
    , Seed
    , seedNew
    , seedToInteger
    , seedFromInteger
    , withTLSRNG
    , newStateRNG
    , MonadRandom
    , getRandomBytes
    ) where

import Crypto.Random.Types
import Crypto.Random

newtype StateRNG = StateRNG ChaChaDRG
    deriving (DRG)

instance Show StateRNG where
    show _ = "rng[..]"

withTLSRNG :: StateRNG
           -> MonadPseudoRandom StateRNG a
           -> (a, StateRNG)
withTLSRNG rng f = withDRG rng f

newStateRNG :: Seed -> StateRNG
newStateRNG seed = StateRNG $ drgNewSeed seed
