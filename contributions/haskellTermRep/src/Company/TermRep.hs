{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE OverlappingInstances #-}

module TermRep where

data TermRep
  = IntRep Int
  | FloatRep Float
  | StringRep String
  | ListRep [TermRep]
  | ConstrRep String [TermRep]
  deriving (Eq, Show, Read)

class Term t
  where
    explode :: t -> TermRep
    implode :: TermRep -> t

instance Term Int
  where
    explode = IntRep
    implode (IntRep x) = x

instance Term Float
  where
    explode = FloatRep
    implode (FloatRep x) = x

instance Term String
  where
    explode = StringRep
    implode (StringRep x) = x

instance Term a => Term [a]
  where
    explode = ListRep . map explode
    implode (ListRep x) = map implode x
