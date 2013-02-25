i=../haskellStarter

test:
	cp ${i}/sampleCompany.txt .
	echo "main" | ghci -v0 -i.:${i} ${i}/Main.hs > log
	diff ${i}/baseline log
	make clean

clean:
	rm -f sampleCompany.txt log
