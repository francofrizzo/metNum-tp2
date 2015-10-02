#include "./deportes.h"

void resolver_deportes(
    conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, double resultado[]
) {
    MEDIR_TIEMPO_INICIO(args.timer);
    matriz data(ifile, cant_nodos, cant_aristas);
    MEDIR_TIEMPO_FIN(args.timer);
}

matriz::matriz(ifstream& data, int cant_nodos, int cant_aristas) {
    _cant_nodos = cant_nodos;
    int num_fecha = 0;
    int i = 0;
    int j = 0;
    int goles_i = 0;
    int goles_j = 0;
    for (int k = 0; k < cant_aristas; k++) {
        data >> num_fecha;
        data >> i;
        data >> goles_i;
        data >> j;
        data >> goles_j;
        cout << "Datos: " << num_fecha << ", " << i << ", " << goles_i << ", " << j << ", " << goles_j << endl;
    }
}
