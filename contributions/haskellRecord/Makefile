origin=../haskellStarter

test:
	echo "main" | ghci -v0 ${origin}/Main.hs > log
	diff ${origin}/baseline log
	make clean

clean:
	rm -f log
