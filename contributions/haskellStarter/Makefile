build:
	ghc Main.hs

test: build
	./Main < sampleCompany.txt > log
	diff baseline log
	make clean

clean:
	rm -f log *.o *.hi Main

