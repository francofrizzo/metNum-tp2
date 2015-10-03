#include "./pags_web.h"

void resolver_pags_web(
    conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, vector<double>& resultado
) {
    MEDIR_TIEMPO_INICIO(args.timer);
    switch (args.alg) {
        case ALG_PAGERANK: {
            matrize data(ifile, cant_nodos, cant_aristas);
            vector<double> inicial (cant_nodos, (double) 1/cant_nodos);
            //cout << inicial[cant_nodos - 1] << endl;
            resultado = data.potencias(inicial, args.c, args.tol);
            break;
        }
        case ALG_ALT: {
            resultado = indeg(ifile, cant_nodos, cant_aristas);
            break;
        }
    }
    MEDIR_TIEMPO_FIN(args.timer);
}



matrize::matrize(ifstream& data, int cant_nodos, int cant_aristas) {
    _cant_nodos = cant_nodos;
    int i = 0;
    int j = 0;
    vector<vector<int> > dataPorColumna(_cant_nodos, vector<int>());

    for (int k = 0; k < cant_aristas; k++) {
        data >> i;
        i--;
        data >> j;
        j--;
        dataPorColumna[j].push_back(i);
        //cout << i << "," << j << endl; DEBUG
    }

    for (int i = 0; i < dataPorColumna.size(); i++) {
        sort(dataPorColumna[i].begin(), dataPorColumna[i].end());
    }


    for (int l = 0; l < _cant_nodos; l++) {
        if (dataPorColumna[l].size() == 0) {
            ptr_cols.push_back(-1);
        } else {
            ptr_cols.push_back(vals.size());
            for (int h = 0; h < dataPorColumna[l].size(); h++) {
                int n = dataPorColumna[l].size();
                
                vals.push_back((double) 1 / n);
                ind_filas.push_back(dataPorColumna[l][h]);
            };
        };
    }

    for (int i = 0; i < vals.size(); i++) {
        cout << vals[i] << ",";
    }
    cout << endl << endl;

    for (int i = 0; i < ind_filas.size(); i++) {
        cout << ind_filas[i] << ",";
    }
    cout << endl << endl;

    for (int i = 0; i < ptr_cols.size(); i++) {
        cout << ptr_cols[i] << ",";
    }
    cout << endl << endl;  //DEBUG    
}

vector<double> matrize::potencias(const vector<double>& inicial, double c, double tol) const {
    vector<double> v1 = inicial;
    vector<double> v2 = prod(v1, c);
    while (difManhattan(v1, v2) > tol) {
        vector<double> aux = v2;
        v2 = prod(v1, c);
        v1 = aux;
    }
    return v2;
}

vector<double> matrize::prod(const vector<double>& vec, double c) const {
    vector<double> res;

    double prom = 0;
    for (int i = 0; i < _cant_nodos; i++) {
        prom = prom + vec[i];
    }
    prom = prom / _cant_nodos;
    double dumping = prom * c;
    
    for (int i = 0; i < _cant_nodos; i++) {
        int ptr_actual;
        int ptr_next;
        rango_fila(i, ptr_actual, ptr_next);
        double acum = 0;
        if (ptr_actual == -1) {
            acum = prom;
        } else {
            acum = dumping;  // arranco con el valor de dumping
            for (int j = ptr_actual; j < ptr_next; j++) { // vamos sumando el valor correspondiente a cada posición no nula de la fila
                acum = acum + (1 - c) * vals[j] * vec[ind_filas[j]];
            }
        }
        res.push_back(acum);
    }

    return res;
}

void matrize::rango_fila(int fila, int& ptr_actual, int& ptr_next) const {
    ptr_actual = ptr_cols[fila];
    if (ptr_actual != -1) {
        ptr_next = -1;
        for (int j = fila + 1; j < _cant_nodos && ptr_next == -1 ; j++) {
            ptr_next = ptr_cols[j];
        }
        if (ptr_next == -1) {
            ptr_next = _cant_nodos;
        }
    } else {
        ptr_next = -1;
    }
}

double matrize::difManhattan(const vector<double>& v1, const vector<double>& v2) const {
    double res = 0;
    for (int i = 0; i < v1.size(); i++) {
        res = res + abs(v1[i] - v2[i]);
    }
    //cout << res << endl;
    return res;
}

vector<double> indeg(ifstream& ifile, int cant_nodos, int cant_aristas) {
    int sumaTotal = 0;
    vector<double> resultado (cant_nodos, 0); 
    int i = 0;
    int j = 0;
    for (int k = 0; k < cant_aristas; k++) {
        ifile >> i;
        i--;
        ifile >> j;
        j--;
        resultado[j]++;
        sumaTotal++;
    }

    for (int i = 0; i < cant_nodos; i++){
        resultado[i] = resultado[i] / sumaTotal;
    }


    /*for (int i = 0; i < resultado.size(); i++) {
        cout << resultado[i] << ",";
    }
    cout << endl << endl; */
    return resultado;
}
