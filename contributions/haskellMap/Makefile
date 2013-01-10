i=-i.:../haskellNovice

test:
	echo "main" | ghci -v0 ${i} Main > log
	diff log baseline
	rm log

clean:
	rm -f log
