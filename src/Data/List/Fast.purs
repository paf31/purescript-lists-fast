-- | Faster replacements for common methods on linked lists,
-- | which exploit mutation under the hood.

module Data.List.Fast where

import Data.Function.Uncurried (Fn2)
import Data.List (List)

foreign import map :: forall a b. (a -> b) -> List a -> List b

foreign import filter :: forall a. (a -> Boolean) -> List a -> List a

foreign import zipWith :: forall a b c. Fn2 a b c -> List a -> List b -> List c
