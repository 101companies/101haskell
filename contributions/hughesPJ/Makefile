i = -i.:../haskellComposition

test:
	echo "main" | ghci -v0 ${i} Main.hs > log
	diff log ../parsec/sampleCompany.txt
	rm log

clean:
	rm -f log
