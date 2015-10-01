#include "matriz.h"

matriz::matriz() {
  columnas = 0;
  filas = 0;
  mat = NULL;
}

matriz::matriz(const matriz& o) {
  columnas = o.columnas;
  filas = o.filas;
  // cout << "Copiando matriz de " << columnas << " columnas y " << filas << " filas." << endl;
  mat = new vector[filas];
  for (int i = 0; i < filas; i++) {
    mat[i] = vector(o.mat[i]);
    // cout << "Copiando fila " << i << " de " << columnas << endl;
  }
  // cout << "Terminé de copiar" << endl;
}

matriz::matriz(int n, int m){
  columnas = n;
  filas = m;
  // cout << "Creando matriz de " << columnas << " columnas y " << filas << " filas." << endl;
  mat = new vector[m];
  for (int i = 0; i < m; i++) {
    mat[i] = vector(n);
  }
}

matriz::~matriz() {
  // cout << "Destruyendo matriz " << this << ": " << endl << *this << endl;
  if (mat != NULL) {
      delete[] mat;
  }
}

int matriz::ancho() const {
  return columnas;
}

int matriz::alto() const {
  return filas;
}

bool matriz::esCuadrada() {
  return (columnas == filas);
}

vector& matriz::operator[](int i) {
  return mat[i];
}

vector& matriz::operator[](int i) const {
  return mat[i];
}

vector matriz::eliminacionGaussiana(vector& b) {
  if (esCuadrada()) {
    int n = ancho();
    if (b.tamano() == n) {
      for (int j = 0; j < n; j++) {
        for (int i = j + 1; i < n; i++) {
          double m = mat[i][j] / mat[j][j];
          for (int k = j; k < n; k++) {
            mat[i][k] = mat[i][k] - m * mat[j][k];
          }
          b[i] = b[i] - m * b[j];
        }
      }
      return sustHaciaAtras(b);
   } else {
     cout << "Error: Las dimensiones del vector y de la matriz no coinciden." << endl;
     return vector();
   }
  } else {
   cout << "Error: La matriz no es cuadrada." << endl;
   return vector();
  }
}
void matriz::factorizacionLU() {
  if (esCuadrada()) {
    int n = ancho();
    for (int j = 0; j < n; j++) {
      for (int i = j + 1; i < n; i++) {
        double m = mat[i][j] / mat[j][j];
        mat[i][j] =  m;
        for (int k = j + 1; k < n; k++) {
          mat[i][k] = mat[i][k] - m * mat[j][k];
        }
      }
    }    
  } else {
      cout << "Error: La matriz no es cuadrada." << endl;
  }
}

vector matriz::solucionLU(vector& b) const {
  vector y = sustHaciaAdelanteConUnos(b); // obtenemos y = L^(-1) * b
  return sustHaciaAtras(y); // resolvemos U * x = y
}

vector matriz::sustHaciaAtras(vector& b) const {
  int n = ancho();
  vector res = vector(n);

  for (int i = n-1; i >= 0; i--) {
    double suma = 0;
    for (int j = i + 1; j < n; j++) {
      suma = suma + mat[i][j] * res[j];
    }
    res[i] = (b[i] - suma) / mat[i][i];
  }

  return res;
}

vector matriz::sustHaciaAdelante(vector& b) const {
  int n = ancho();
  vector res = vector(n);

  for (int i = 0; i < n; i++) {
    double suma = 0;
    for (int j = 0; j <= i; j++) {
      suma = suma + mat[i][j] * res[j];
    }
    res[i] = (b[i] - suma) / mat[i][i];
  }

  return res;
}

vector matriz::sustHaciaAdelanteConUnos(vector& b) const {
  // Esta función hace sustitución hacia adelante,
  // pero ignora los elementos de la diagonal y considera
  // que esta tiene solamente unos.
  int n = ancho();
  vector res = vector(n);

  for (int i = 0; i < n; i++) {
    double suma = 0;
    for (int j = 0; j < i; j++) {
      suma = suma + mat[i][j] * res[j];
    }
    suma = suma + res[i];
    res[i] = (b[i] - suma);
  }

  return res;
}


std::ostream& operator<<(std::ostream& os, const matriz& mat) {
  int alto = mat.alto();
  int ancho = mat.ancho();
  for (int i = 0; i < alto; i++) {
    if (i > 0) {
      os << endl;
    }
    for (int j = 0; j < ancho; j++) {
      os << setfill(' ') << setw(12) << mat[i][j] << " ";
    }
  }
  return os;
}
