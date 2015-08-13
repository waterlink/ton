all:
	mkdir -p bin
	crystal build src/binary.cr -o bin/ton
