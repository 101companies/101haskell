# Summary

This repo collects Haskell-based contributions to the 101companies:Project.

http://101companies.org/

Haskell Platform 2012.4.0.0 is recommended for use with the repo.

http://www.haskell.org/platform/

The repo uses the Haskell building and packaging tool [Cabal](http://www.haskell.org/cabal/), which is part of the Haskell Platform. 

# Status

Please note: the process of cabalization is underway; various contributions are not yet conformant.

# Usage

Each contribution in the repo is cabalized individually so that dependencies are properly collected and basic testing is provided. The contributions can be built and tested at the command line in a uniform manner.

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

# Best practices

* Comment your code: Use short line comments for most data types and functions. Try to relate the feature model of the 101companies:System. Inspire yourself with commenting conventions in existing contributions.
* Use Cabal in the right way: All building and testing should be delegated uniformly to Cabal as shown above. All dependencies to hackage packages should be properly captured in the Cabal file. An existing Cabal file should be used as a starting point for any new contribution. No "Setup.hs" file is needed, given the use of the simple build type and the absence of an intention to submit 101companies packages to hackage.
* Provide basic tests in src/Main.hs: These tests should demonstrate the implemented features. These are mainly positive test cases. HUnit is used in some basic manner. An existing file src/Main.hs should be used as a starting point. If more than basic tests are to be developed, then they should be separated out into an extra testsuite.

Contributions haskellStarter and haskellComposition should be maintained to be hopefully good demonstrators of these best practices.
