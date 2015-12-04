#ifndef MNTP2_PAGS_WEB_H
#define MNTP2_PAGS_WEB_H

#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <iomanip>
#include <algorithm>

#include "./config.h"

using namespace std;

class matrize {
 private:
    int _cant_nodos;
    vector<double> vals;
    vector<int> ind_filas;
    vector<int> ptr_cols;
 public:
    matrize(ifstream&, int, int);

    vector<double> potencias(const vector<double>&, const double, double, unsigned int*, ostream&) const;
    vector<double> prod(const vector<double>&, const double) const;
    double difManhattan(const vector<double>&, const vector<double>&) const;

    void rango_columna(int, int&, int&) const;
    void imprimir() const;
};

void resolver_pags_web(conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, vector<double>& resultado, ostream& conv);

vector<double> indeg(ifstream&, int, int);

#endif
