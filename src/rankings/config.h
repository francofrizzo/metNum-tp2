#ifndef MNTP2_CONFIG_H
#define MNTP2_CONFIG_H

#include <ctime>
#include <string.h>

using namespace std;

#define ALG_PAGERANK  0
#define ALG_ALT       1
#define ES_ALG_VALIDO(cod) (cod == ALG_PAGERANK || cod == ALG_ALT)

#define TIPO_PAGS_WEB 0
#define TIPO_DEPORTES 1
#define ES_TIPO_VALIDO(cod) (cod == TIPO_PAGS_WEB || cod == TIPO_DEPORTES)

#define MEDIR_TIEMPO_INICIO(timer) timer = clock();
#define MEDIR_TIEMPO_FIN(timer) timer = clock() - timer;

struct conf {
    int alg;                   // algoritmo a utilizar
    double c;                  // probabilidad de teletransportación
    int tipo_inst;             // tipo de instancia (paginas web, deportes)
    string ifile;              // path del archivo de entrada
    string ofile;              // path del archivo de salida
    double tol;                // tolerancia para la parada del método de la potencia

    bool tfile_flag = false;   // determina si se usará archivo con nombres de equipos
    string tfile;              // path del archivo con los nombres de equipos

    clock_t timer = 0;         // timer
    bool timer_flag = false;   // determina si se calculará el tiempo de ejecución
};

#endif
