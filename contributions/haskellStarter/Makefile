test:
	echo "main" | ghci -v0 Main.hs > log
	diff baseline log
	make clean

clean:
	rm -f log
