i=-i.:../haskellComposition

test:
	echo "main" | ghci -v0 ${i} Main.hs > log
	diff log baseline
	rm log

install:
	cabal install hstats

clean:
	rm -f log
