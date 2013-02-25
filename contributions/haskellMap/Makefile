i=../haskellFlat

test:
	echo "main" | ghci -v0 -i.:${i} Main > log
	diff log ${i}/baseline
	rm log

clean:
	rm -f log
