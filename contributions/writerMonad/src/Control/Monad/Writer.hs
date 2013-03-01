{-

This is a trivialized implementation of a writer monad.

See here for a proper implementation:

http://hackage.haskell.org/packages/archive/mtl/latest/doc/html/Control-Monad-Writer.html

The present implementation is kept as simple as possible; specifically:
- Monad transformers are not used.
- No designated type class is defined for writer monads.
- Typical convenience operations of writer monads are omitted.
- The issue of laziness and strictness is neglected.
- ...

-}

module Control.Monad.Writer where

import Control.Monad
import Data.Monoid


-- A Writer computation consists of output and a value.

newtype Writer w a = Writer { runWriter :: (a, w) }


-- We set up the Monad type-class instance for writers.

instance Monoid w => Monad (Writer w)
  where
    return a = Writer (a, mempty)
    (Writer (a, w)) >>= f =
      let (Writer (b, w')) = f a in
        (Writer (b, w `mappend` w'))


-- Writer monads are monads with a tell action.

tell :: w -> Writer w ()
tell w = Writer ((), w)
