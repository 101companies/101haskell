module Cut where

import Company
import TermRep

cut :: TermRep -> TermRep
cut (FloatRep f) = FloatRep (f/2)
cut (ListRep ts) = ListRep (map cut ts)
cut (ConstrRep n ts) = ConstrRep n (map cut ts)
cut t = t
