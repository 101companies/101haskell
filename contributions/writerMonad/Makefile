i=-i.:../nonmonadic:../haskellComposition

test:
	echo "main" | ghci -v0 ${i} Main > log
	diff log ../nonmonadic/baseline
	rm log

install:
	cabal install hstats

clean:
	rm -f log
