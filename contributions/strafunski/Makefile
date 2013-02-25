strafunski = StrategyLib/Data/Generics/Strafunski/StrategyLib

build:
	ghc -i.:StrategyLib Main.hs

test: build
	./Main < sampleCompany.txt > log
	diff baseline log
	make clean

clean:
	rm -f log *.o *.hi Main ${strafunski}/*.hi ${strafunski}/*.o


