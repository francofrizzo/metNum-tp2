#ifndef MNTP2_DEPORTES_H
#define MNTP2_DEPORTES_H

#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <iomanip>

#include "./config.h"

using namespace std;

class matriz {
 private:
    int _cant_nodos;
    vector<vector<double> > vals;
 public:
    matriz(ifstream&, int, int, double);

    vector<double> potencias(const vector<double>&, const double, double, unsigned int*) const;
    vector<double> prod(const vector<double>&, const double) const;
    double difManhattan(const vector<double>&, const vector<double>&) const;
    
    void imprimir();
};

void resolver_deportes(conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, vector<double>& resultado);

vector<double> ranking_afa(ifstream&, int, int);

#endif
