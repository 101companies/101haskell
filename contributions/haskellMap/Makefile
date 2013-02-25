origin=../haskellStarter

test:
	cp ${origin}/sampleCompany.txt .
	echo "main" | ghci -v0 -i.:${origin} ${origin}/Main.hs > log
	diff ${origin}/baseline log
	make clean

clean:
	rm -f sampleCompany.txt log
