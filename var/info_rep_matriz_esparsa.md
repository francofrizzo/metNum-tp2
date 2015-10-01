Formas de representación de matrices esparsas
=============================================

Dictionary of keys (DOK)
------------------------
**DOK** consists of a dictionary that maps (row, column)-pairs to the value of the elements. Elements that are missing from the dictionary are taken to be zero. The format is good for incrementally constructing a sparse matrix in random order, but poor for iterating over non-zero values in lexicographical order. One typically constructs a matrix in this format and then converts to another more efficient format for processing.

Compressed row Storage (CRS or CSR)
-----------------------------------
`(val, col_ind, row_ptr)`

**CSR** is `(val, col_ind, row_ptr)`, where `val` is an array of the (left-to-right, then top-to-bottom) non-zero values of the matrix; `col_ind` is the column indices corresponding to the values; and `row_ptr` is the list of value indexes where each row starts. The name is based on the fact that row index information is compressed relative to the COO format. One typically uses another format (LIL, DOK, COO) for construction. This format is efficient for arithmetic operations, row slicing, and matrix-vector products.

Compressed sparse column (CSC or CCS)
-------------------------------------
`(val, row_ind, col_ptr)`

**CSC** is similar to CSR except that values are read first by column, a row index is stored for each value, and column pointers are stored. I.e. CSC is `(val, row_ind, col_ptr)`, where `val` is an array of the (top-to-bottom, then left-to-right) non-zero values of the matrix; `row_ind` is the row indices corresponding to the values; and, `col_ptr` is the list of val indexes where each column starts. The name is based on the fact that column index information is compressed relative to the COO format. One typically uses another format (LIL, DOK, COO) for construction. This format is efficient for arithmetic operations, column slicing, and matrix-vector products. This is the traditional format for specifying a sparse matrix in MATLAB (via the sparse function).
