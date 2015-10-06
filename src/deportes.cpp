#include "./deportes.h"

void resolver_deportes(
    conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, vector<double>& resultado
) {
    MEDIR_TIEMPO_INICIO(args.timer);
    switch (args.alg) {
        case ALG_PAGERANK: {
            matriz data(ifile, cant_nodos, cant_aristas, args.c);
            vector<double> inicial(cant_nodos, (double) 1/cant_nodos);
            resultado = data.potencias(inicial, args.c, args.tol, &args.count_iter);
            break;
        }
        case ALG_ALT: {
            resultado = ranking_afa(ifile, cant_nodos, cant_aristas);
            break;
        }
    }
    MEDIR_TIEMPO_FIN(args.timer);
}

matriz::matriz(ifstream& data, int cant_nodos, int cant_aristas, double c) {
    _cant_nodos = cant_nodos;

    vals = vector<vector<double> >(cant_nodos, vector<double>(cant_nodos, 0));
    int i = 0;
    int j = 0;
    int goles_i = 0;
    int goles_j = 0;

    for (int k = 0; k < cant_aristas; k++) {
        data >> i >> i >> goles_i >> j >> goles_j;
        i--;
        j--;
        if (goles_i > goles_j) {
            vals[i][j] = vals[i][j] + (goles_i - goles_j);
        } else {
            vals[j][i] = vals[j][i] + (goles_j - goles_i);
        }
    }

    double unif = (double) 1 / cant_nodos;
    double dumping = unif * (1 - c);

    for (int j = 0; j < cant_nodos; j++) {
        double suma = 0;
        for (int i = 0; i < cant_nodos; i++) {
            suma = suma + vals[i][j];
        }
        if (suma == 0) {
            for (int i = 0; i < cant_nodos; i++) {
                vals[i][j] = unif;
            }
        } else {
            for (int i = 0; i < cant_nodos; i++) {
                vals[i][j] = (vals[i][j] / suma) * c + dumping;
            }
        }
    }
}

vector<double> matriz::potencias(const vector<double>& inicial, double c, double tol, unsigned int* counter) const {
    vector<double> v1 = inicial;
    vector<double> v2 = prod(v1, c);
    SUMAR_ITERACION(counter);
    while (difManhattan(v1, v2) > tol) {
        v1 = v2;
        v2 = prod(v1, c);
        SUMAR_ITERACION(counter);
    }
    return v2;
}

vector<double> matriz::prod(const vector<double>& vec, double c) const {
    vector<double> res;

    for (int i = 0; i < _cant_nodos; i++) {
        double acum = 0;
        for (int j = 0; j < _cant_nodos; j++) {
            acum = acum + vals[i][j] * vec[j];
        }
        res.push_back(acum);
    }

    return res;
}

double matriz::difManhattan(const vector<double>& v1, const vector<double>& v2) const {
    double res = 0;
    for (int i = 0; i < v1.size(); i++) {
        res = res + abs(v1[i] - v2[i]);
    }
    return res;
}

void matriz::imprimir() {
    for (int i = 0; i < vals.size(); i++) {
        vector<double> row = vals[i];
        for (int j = 0; j < row.size(); j++) {
            cout << fixed << setprecision(6) << row[j] << " ";
        }
        cout << endl;
    }
}

vector<double> ranking_afa(ifstream& data, int cant_nodos, int cant_aristas) {
    vector<double> res(cant_nodos);
    int i = 0;
    int j = 0;
    int goles_i = 0;
    int goles_j = 0;
    int total_puntos = 0;

    for (int k = 0; k < cant_aristas; k++) {
        data >> i >> i >> goles_i >> j >> goles_j;
        i--;
        j--;
        if (goles_i == goles_j) {
            res[i] = res[i] + 1;
            res[j] = res[j] + 1;
            total_puntos = total_puntos + 2;
        } else if (goles_i > goles_j) {
            res[i] = res[i] + 3;
            total_puntos = total_puntos + 3;
        } else {
            res[j] = res[j] + 3;
            total_puntos = total_puntos + 3;
        }
    }

    for (int i = 0; i < cant_nodos; i++) {
        res[i] = res[i] / total_puntos;
    }

    return res;
}
