# See the README.md file for instructions.

all:
	echo "main" | ghci -v0 src/Main.hs > log.txt
	diff log.txt baseline.txt
	rm -f log.txt
