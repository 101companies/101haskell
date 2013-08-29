# See the README.md file for instructions.

all:
	make build
	make clean

build:
	cabal clean
	cabal configure --enable-tests
	cabal build
	cabal test

doc:
	cabal haddock

clean:
	cabal clean
