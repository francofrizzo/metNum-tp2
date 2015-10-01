#include <iostream>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

using namespace std;
void mostrar_ayuda (char*);

int main (int argc, char* argv[]) {
    char opt;
    /*if the program is ran witout options ,it will show the usgage and exit*/
    if (argc == 1) {
        mostrar_ayuda(argv[0]);
        exit(1);
    }
    while ((opt = getopt(argc, argv, "h")) != -1) {
        switch (opt) {
            case 'h': // mostrar ayuda
                mostrar_ayuda(argv[0]);
                break;
            default:  // si las opciones son inválidas
                mostrar_ayuda(argv[0]);
                break;
        }
    }
    return 0;
}

void mostrar_ayuda (char* s) {
    cout << "Modo de uso: " << s <<" [-opción] [argumento]" << endl;
    cout << "Opciones:" << endl;
    cout << "          -h    Muestra este texto de ayuda." << endl;
}
