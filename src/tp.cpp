#include <iostream>
#include <iomanip>
#include <fstream>
#include <unistd.h>
#include <string.h>
#include <limits>
#include <ctime>

#include "./config.h"
#include "./pags_web.h"
#include "./deportes.h"

#define INTENTAR_PARSEO(funcion_parseo, nombre) \
    try { funcion_parseo } catch (exception e) { \
        cout << "El parámetro "#nombre" no es válido" << endl; \
        exit(1); \
    }

#define LEER_ENCAB_SNAP(ifile, cant_nodos, cant_aristas) \
    string params; \
    ifile.ignore(std::numeric_limits<streamsize>::max(), '\n'); \
    ifile.ignore(std::numeric_limits<streamsize>::max(), '\n'); \
    ifile.ignore(std::numeric_limits<streamsize>::max(), ':'); \
    ifile >> cant_nodos; \
    ifile.ignore(std::numeric_limits<streamsize>::max(), ':'); \
    ifile >> cant_aristas; \
    ifile.ignore(std::numeric_limits<streamsize>::max(), '\n'); \
    ifile.ignore(std::numeric_limits<streamsize>::max(), '\n'); \

#define LEER_ENCAB_LIGA(ifile, cant_nodos, cant_aristas) \
    ifile >> cant_nodos; \
    ifile >> cant_aristas;

using namespace std;

void mostrar_ayuda(char*);
void parsear_argumentos(conf&, char**);
void imprimir_tiempo(clock_t);

int main(int argc, char* argv[]) {
    conf args;
    ifstream ifile;
    ofstream ofile;
    ifstream tfile;
    int cant_nodos;
    int cant_aristas;
    ifstream data;
    vector<double> resultado;

    // Parseo de argumentos
    if (argc > 5) {
        parsear_argumentos(args, argv);
    } else {
        // En caso de faltar argumentos, mostrar ayuda y salir
        mostrar_ayuda(argv[0]);
        exit(1);
    }

    // Parseo de opciones especiales
    char opt;
    while ((opt = getopt(argc, argv, "ho:e:t")) != -1) {
        switch (opt) {
            case 'h': { // mostrar ayuda
                mostrar_ayuda(argv[0]);
                exit(0);
                break;
            }
            case 'o': { // cambiar ruta de salida
                args.ofile = optarg;
                break;
            }
            case 'e': { // cargar archivo con nombres de equipos
                args.tfile_flag = true;
                args.tfile = optarg;
                break;
            }
            case 't': { // calcular tiempo de ejecución
                args.timer_flag = true;
                break;
            }
            default: { // si las opciones son inválidas
                mostrar_ayuda(argv[0]);
                exit(1);
                break;
            }
        }
    }

    // Apertura de archivos de entrada y salida
    ifile.open(args.ifile, ios_base::in);  // archivo de entrada
    if (! ifile.good()) {
        cout << "Error al abrir el archivo de entrada" << endl;
        exit(1);
    }

    ofile.open(args.ofile, ios_base::app);  // archivo de salida
    if (! ofile.good()) {
        cout << "Error al abrir el archivo de salida" << endl;
        exit(1);
    }

    if (args.tipo_inst == TIPO_DEPORTES && args.tfile_flag) {
        tfile.open(args.tfile, ios_base::in);  // archivo de nombres de equipos
        if (! tfile.good()) {
            cout << "Advertencia: no se pudo abrir el archivo de nombres de equipos (será ignorado)" << endl;
            args.tfile_flag = false;
        }
    }

    // Parseo de archivos de entrada y ejecución de los métodos

    // Reviso que el algoritmo solicitado sea válido
    if (! ES_ALG_VALIDO(args.alg)) {
        cout << "Error: El algoritmo solicitado no es válido" << endl;
        exit(1);
    }

    // Ejecuto el algoritmo, de acuerdo al tipo de instancia especificada
    switch (args.tipo_inst) {
        case TIPO_PAGS_WEB: {
            LEER_ENCAB_SNAP(ifile, cant_nodos, cant_aristas)
            resolver_pags_web(args, ifile, cant_nodos, cant_aristas, resultado);
            break;
        }
        case TIPO_DEPORTES: {
            LEER_ENCAB_LIGA(ifile, cant_nodos, cant_aristas)
            resolver_deportes(args, ifile, cant_nodos, cant_aristas, resultado);
            break;    
        }
        default: {
            cout << "Error: El tipo de instancia especificado no es válido" << endl;
            exit(1);
            break;           
        }
    }

    // Escritura en archivo de salida
    for (vector<double>::iterator it = resultado.begin(); it != resultado.end(); it++) {
        ofile << *it << endl;
    }

    // Imprimir por pantalla tiempo de ejecución
    if (args.timer_flag) {
        imprimir_tiempo(args.timer);
    }

    ifile.close();
    ofile.close();
    return 0;
}


void mostrar_ayuda(char* s) {
    cout << "  Modo de uso: " << setw(12) << s <<" [-opción] [argumento] <algoritmo> <c>" << endl;
    cout <<           "                            <tipo_instancia> <archivo_entrada> <tolerancia>" << endl;
    cout << "  Parámetros:" << endl;
    cout << "    algoritmo         0 para PageRank, 1 para alternativo" << endl;
    cout << "    c                 Valor de la probabilidad de teletransportación" << endl;
    cout << "    tipo_instancia    0 para páginas web, 1 para deportes" << endl;
    cout << "    archivo_entrada   Ruta del archivo con la definición de la red" << endl;
    cout << "    tolerancia        Valor de tolerancia utilizado en el criterio de parada" << endl;
    cout << "                        del método de la potencia" << endl;
    cout << "  Opciones:" << endl;
    cout << "    -h          Muestra este texto de ayuda" << endl;
    cout << "    -o <path>   Permite especificar el nombre y ubicación del archivo de salida" << endl;
    cout << "    -e <path>   Para el tipo de instancia \"deportes\", permite especificar un" << endl;
    cout << "                  archivo con nombres de equipos" << endl;
    cout << "    -t          Calcula e imprime en pantalla el tiempo insumido por la ejecu-" << endl;
    cout << "                  ción del método" << endl;
}

void parsear_argumentos(conf& args, char* argv[]) {
    INTENTAR_PARSEO(args.alg = stoi(argv[1]);, <algoritmo>)
    INTENTAR_PARSEO(args.c = stod(argv[2]);, <c>)
    INTENTAR_PARSEO(args.tipo_inst = stoi(argv[3]);, <tipo_instancia>)
    args.ifile = argv[4];
    INTENTAR_PARSEO(args.tol = stod(argv[5]);, <tolerancia>)
    args.ofile = args.ifile + ".out";
}

void imprimir_tiempo(clock_t timer) {
    cout << "Tiempo de ejecución (ticks de reloj): " << timer << endl;
}
