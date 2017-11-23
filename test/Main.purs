module Test.Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Function.Uncurried (mkFn2)
import Data.List ((..))
import Data.List as List
import Data.List.Fast (map, filter, zipWith)
import Performance.Minibench (benchWith)
import Prelude as Prelude
import Prelude hiding (map)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  let xs1000 = 1 .. 1000
      xs10000 = 1 .. 10000
      xs100000 = 1 .. 100000

  -- map

  log "Data.List.map (1000 elements)"
  benchWith 1000 \_ -> Prelude.map (_ + 1) xs1000
  log "Data.List.Fast.map (1000 elements)"
  benchWith 1000 \_ -> map (_ + 1) xs1000

  log "Data.List.map (10000 elements)"
  benchWith 100 \_ -> Prelude.map (_ + 1) xs10000
  log "Data.List.Fast.map (10000 elements)"
  benchWith 100 \_ -> map (_ + 1) xs10000

  log "Data.List.map (100000 elements)"
  benchWith 10 \_ -> Prelude.map (_ + 1) xs100000
  log "Data.List.Fast.map (100000 elements)"
  benchWith 10 \_ -> map (_ + 1) xs100000

  -- filter

  let even x = mod x 2 == 0

  log "Data.List.filter (1000 elements)"
  benchWith 1000 \_ -> List.filter even xs1000
  log "Data.List.Fast.filter (1000 elements)"
  benchWith 1000 \_ -> filter even xs1000

  log "Data.List.filter (10000 elements)"
  benchWith 100 \_ -> List.filter even xs10000
  log "Data.List.Fast.filter (10000 elements)"
  benchWith 100 \_ -> filter even xs10000

  log "Data.List.filter (100000 elements)"
  benchWith 10 \_ -> List.filter even xs100000
  log "Data.List.Fast.filter (100000 elements)"
  benchWith 10 \_ -> filter even xs100000

  -- zipWith

  let f = mkFn2 \a b -> a + b

  log "Data.List.zipWith (1000 elements)"
  benchWith 1000 \_ -> List.zipWith (+) xs1000 xs1000
  log "Data.List.Fast.zipWith (1000 elements)"
  benchWith 1000 \_ -> zipWith f xs1000 xs1000

  log "Data.List.zipWith (10000 elements)"
  benchWith 100 \_ -> List.zipWith (+) xs10000 xs10000
  log "Data.List.Fast.zipWith (10000 elements)"
  benchWith 100 \_ -> zipWith f xs10000 xs10000

  log "Data.List.zipWith (100000 elements)"
  benchWith 10 \_ -> List.zipWith (+) xs100000 xs100000
  log "Data.List.Fast.zipWith (100000 elements)"
  benchWith 10 \_ -> zipWith f xs100000 xs100000
