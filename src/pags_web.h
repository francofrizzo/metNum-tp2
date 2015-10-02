#ifndef MNTP2_PAGS_WEB_H
#define MNTP2_PAGS_WEB_H

#include <iostream>
#include <fstream>
#include <vector>

#include "./config.h"

using namespace std;

class matrize {
 private:
    int _cant_nodos;
    vector<double> vals;
    vector<int> ind_cols;
    vector<int> ptr_filas;
 public:
    matrize(ifstream&, int, int);
};

void resolver_pags_web(conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, double resultado[]);

#endif
