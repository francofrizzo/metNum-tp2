CC=g++
CPPFLAGS=-Wall -Wextra -pedantic -ggdb -c -std=c++11
DEP=pags_web.o deportes.o

all: tp

tp: tp.o $(DEP)
	$(CC) tp.o $(DEP) -o tp

%.o: %.cpp
	$(CC) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o
	rm -f tp
