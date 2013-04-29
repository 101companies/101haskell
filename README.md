# Summary

This repo collects Haskell-based contributions to the 101companies Project.

http://101companies.org/

Haskell Platform 2012.4.0.0 is recommended for use with the repo.

http://www.haskell.org/platform/

Most contributions are "engineered": they modularized, packaged, documented, and equipped with unit tests. [Cabal](http://www.haskell.org/cabal/), as part of the Haskell Platform, is leveraged for packaging and building. [Haddock](www.haskell.org/haddock/), as part of the Haskell Platform, is leveraged for documentation conventions and possibly documentation generation. [HUnit](http://hunit.sourceforge.net/]), as readily available through Cabal, is leveraged for testing. (Additional tools may be used by individual contributions.)

# Status

Please note: the process towards "engineered" contribution is underway; various contributions are not yet conformant. Also, there may be exceptions from the rule for good reasons. For instance, contribution haskellStarter is specifically meant to be very simple ("no engineering"). 

# Usage

Each "engineered" contribution in the repo is cabalized individually so that dependencies are properly collected and basic testing is provided. The contributions can be built and tested at the command line in a uniform manner.

The relevant commands are shown here for the "haskellEngineer" contribution, which is a trivial contribution that merely demonstrates indeed simple best practices of packaging, building, modularization, documentation, and testing.

    $ cd contributions/haskellEngineer
    $ cabal configure --enable-tests
    $ cabal build
    $ cabal test

Documentation may be generated as follows:

    $ cabal haddock

Left-overs from the attempted build are cleaned up like this:

    $ cabal clean

These steps may also be scripted in a local Makefile. In particular, configuration, building, testing, and final cleaning can be performed in one sweep as follows:

    $ make

Alternatively, the tests can also be invoked more interactively:

    $ cd src
    $ ghci Main.hs
    > runTestTT tests
    Cases: 3  Tried: 3  Errors: 0  Failures: 0
    Counts {cases = 3, tried = 3, errors = 0, failures = 0}

# Best practices

* Comment your code: Use short line comments for most data types and functions. Try to relate to the feature model of the 101companies System. Use Haddock comment conventions. Inspire yourself with commenting conventions in existing contributions.
* Modularize your code: Place all source code in the src folder. Capture basic tests in src/Main.hs; see more on testing below. Use the namespace "Company" for all modules that implement features. Use regular namespaces such as "Data" or "Control" for any support modules that you may need. In placing modules in "Company", follow the naming conventions of existing contributions. For instance, the data model of a contribution is typically placed in a module "Company.Data".
* Use Cabal: All building and testing should be delegated uniformly to Cabal as shown above. All dependencies to hackage packages should be properly captured in the Cabal file. An existing Cabal file should be used as a starting point for any new contribution. No "Setup.hs" file is needed, given the use of the simple build type and the absence of an intention to submit 101companies packages to hackage.
* Provide basic tests in src/Main.hs: Such basic testing does not need to strive for any coverage other than demonstration implemented features. Thus, a few positive test cases may suffice. Negative test cases may be helpful though to demonstrate constraints related to features. HUnit is used in a basic manner. An existing file src/Main.hs should be used as a starting point. If more than basic tests are to be developed, then they should be separated out into an extra testsuite.

Contribution haskellEngineer is maintained to be a good demonstrator of these best practices.
