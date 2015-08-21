.PHONY: all curses

all: binary
binary: bindir
	crystal build src/binary.cr -o bin/ton

curses: bindir
	gcc curses_tests/attr_t.c -o bin/curses_tests_attr_t && bin/curses_tests_attr_t

bindir:
	@mkdir -p bin
