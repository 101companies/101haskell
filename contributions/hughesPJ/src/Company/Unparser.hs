module Company.Unparser where

import Company.Data
import Text.PrettyPrint.HughesPJ

unparse :: Company -> Doc
unparse (Company n ds) =
  bracy "company" n (vcat (map unparseD ds))
  where
    bracy :: String -> String -> Doc -> Doc
    bracy k n d =
         text k <+> doubleQuotes (text n) <+> text "{"
      $$ nest 2 d
      $$ text "}"
    unparseD :: Department -> Doc
    unparseD (Department n m ds es) =
      bracy "department" n (vcat (   [unparseE "manager" m]
                                ++ map unparseD ds
                                ++ map (unparseE "employee") es))
      where
        unparseE :: String -> Employee -> Doc
        unparseE k (Employee n a s) = bracy k n (a' $$ s')
          where
            a' = text "address" <+> doubleQuotes (text a)
            s' = text "salary" <+> text (show s)
