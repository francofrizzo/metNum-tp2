#ifndef MNTP2_CONFIG_H
#define MNTP2_CONFIG_H

#include <ctime>
#include <vector>
#include <string.h>

using namespace std;

#define ALG_PAGERANK  0
#define ALG_ALT       1
#define ES_ALG_VALIDO(cod) (cod == ALG_PAGERANK || cod == ALG_ALT)

#define TIPO_PAGS_WEB 0
#define TIPO_DEPORTES 1
#define ES_TIPO_VALIDO(cod) (cod == TIPO_PAGS_WEB || cod == TIPO_DEPORTES)

// #define CRIT_EMPATE_
// #define CRIT_EMPATE_
// #define CRIT_EMPATE_

#define MEDIR_TIEMPO_INICIO(timer) timer = clock();
#define MEDIR_TIEMPO_FIN(timer) timer = clock() - timer;

#define SUMAR_ITERACION(count_iter) (*count_iter)++;

struct conf {
    int alg;                   // algoritmo a utilizar
    double c;                  // probabilidad de teletransportación
    int tipo_inst;             // tipo de instancia (paginas web, deportes)
    string ifile;              // path del archivo de entrada
    string ofile;              // path del archivo de salida
    double tol;                // tolerancia para la parada del método de la potencia

    bool rfile_flag = false;   // determina si calculará y guardará el ranking
    string rfile;              // archivo de rankings

    bool tfile_flag = false;   // determina si se usará archivo con nombres de equipos
    string tfile;              // path del archivo con los nombres de equipos

    bool timer_flag = false;   // determina si se calculará el tiempo de ejecución
    clock_t timer = 0;         // timer

    bool count_iter_flag = false;   // determina si se contarán las iteraciones
    unsigned int count_iter = 0;    // contador de iteraciones

    int criterio_empates = 0;
    int k1 = 0;
    double k2 = 0;
};

template<typename T>
ostream& operator<<(ostream& os, const vector<T>& vec) {
    os << "[";
    for (int i = 0; i < vec.size() - 1; i++) {
        os << vec[i] << ", ";
    }
    os << vec[vec.size() - 1] << "]";
    return os;
}

#endif
