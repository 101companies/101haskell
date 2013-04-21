This is a beginner's Haskell-based contribution to the 101companies Project.

If you have ghci installed, then you can easily test the code as follows:

     $ pwd
     /home/billg/101haskell/contributions/haskellStarter/src
     $ ghci Main.hs 
     GHCi, version 7.4.2: http://www.haskell.org/ghc/  :? for help
     Loading package ghc-prim ... linking ... done.
     Loading package integer-gmp ... linking ... done.
     Loading package base ... linking ... done.
     [1 of 1] Compiling Main             ( Main.hs, interpreted )
     Ok, modules loaded: Main.
     *Main> main
     399747.0
     12345.0
     199873.5
     *Main> 
     Leaving GHCi.
     $ 

The main function (see the code) totals the salaries of all employees in a sample company (also to be found in the file), computes the median of all salaries, and it cuts all salaries in half to show again the total after the cut.

Please find additional information here:
* http://101companies.org/
* http://101companies.org/wiki/Contribution:haskellStarter
* https://github.com/101companies/101haskell/
* https://github.com/101companies/101haskell/blob/master/README.md 

