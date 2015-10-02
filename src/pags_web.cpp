#include "./pags_web.h"

void resolver_pags_web(
    conf& args, ifstream& ifile, int cant_nodos,
    int cant_aristas, double resultado[]
) {
    MEDIR_TIEMPO_INICIO(args.timer);
    matrize data(ifile, cant_nodos, cant_aristas);
    MEDIR_TIEMPO_FIN(args.timer);
}

matrize::matrize(ifstream& data, int cant_nodos, int cant_aristas) {
    _cant_nodos = cant_nodos;
    int i = 0;
    int j = 0;
    for (int k = 0; k < cant_aristas; k++) {
        data >> i;
        data >> j;
        cout << "Datos: " << i << ", " << j << endl;
    }
}
