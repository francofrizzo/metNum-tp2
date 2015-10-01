#include "vector.h"

vector::vector() {
    tam = 0;
    vec = NULL;
}

vector::vector(const vector& o) {
    tam = o.tam;
    vec = new double[tam];
    for (int i = 0; i < tam; i++) {
        vec[i] = o.vec[i];
    }
}

vector::vector(int n) {
    // cout << "Creando vector de tamaño " << n << endl;
    tam = n;
    vec = new double[n];
    for (int i = 0; i < n; i++) {
        vec[i] = 0;
    }
}

vector::~vector() {
    // cout << "Destruyendo vector " << this << ": " << *this << endl;
    if (vec != NULL) {
        delete[] vec;
    }
}

vector& vector::operator=(const vector& o) {
    if (this != &o) {
        tam = o.tam;
        vec = NULL;

        vec = new double[tam];
        for (int i = 0; i < tam; i++) {
            vec[i] = o.vec[i];
        }
    }
    return *this;
}

int vector::tamano() const{
    return tam;
}

double& vector::operator[](int i) {
    return vec[i];
}


double& vector::operator[](int i) const {
    return vec[i];
}

std::ostream& operator<<(std::ostream& os, const vector& vec) {
    os << "[";
    for (int i = 0; i < vec.tamano() - 1; i++) {
        os << vec[i] << ", ";
    }
    if (vec.tamano() > 0) {
        os << vec[vec.tamano() - 1];
    }
    os << "]";
    return os;
}
