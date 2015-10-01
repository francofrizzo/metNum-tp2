CC=g++
CPPFLAGS=-Wall -Wextra -pedantic -ggdb -c -std=c++11
DEP=

all: rankings

rankings: rankings.o $(DEP)
	$(CC) rankings.o $(DEP) -o rankings

%.o: %.cpp
	$(CC) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o
	rm -f rankings
