#ifndef MNTP2_DEPORTES_H
#define MNTP2_DEPORTES_H

#include <iostream>
#include <fstream>
#include <vector>

#include "./config.h"

using namespace std;

class matriz {
 private:
    int _cant_nodos;
    vector<vector<int> > vals;
 public:
    matriz(ifstream&, int, int);
};

void resolver_deportes(conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, double resultado[]);

#endif
