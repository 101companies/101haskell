i=../haskellStarter

test:
	echo "main" | ghci -v0 ${i}/Main.hs > log
	diff ${i}/baseline log
	make clean

clean:
	rm -f log
