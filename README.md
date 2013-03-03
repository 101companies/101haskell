This repo collects Haskell-based contributions to the 101companies:Project.

http://101companies.org/

The repo uses the Haskell building and packaging tool [Cabal](http://www.haskell.org/cabal/). Each contribution in the repo is cabalized individually so that dependencies are properly collected and basic testing is provided. The contributions can be built and tested at the command line in a uniform manner.

Please note: the process of cabalization is underway; various contributions are not yet conformant.

The relevant commands are shown here for the "haskellStarter" contribution.

    $ cd contributions/haskellStarter
    $ cabal configure --enable-tests
    $ cabal build
    $ cabal test

Alternatively, the tests can also be invoked more interactively:

    $ cd src
    $ ghci Main.hs
    > runTestTT tests
    Cases: 3  Tried: 3  Errors: 0  Failures: 0
    Counts {cases = 3, tried = 3, errors = 0, failures = 0}
