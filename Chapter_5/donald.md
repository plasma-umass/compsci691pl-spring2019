# Loading and Computing Matrices from Files

We will store an n x m matrix in a `.csv` file that has n lines, and m comma-separated columns. For example, the following is a 3 x 2 matrix:

```
1,7
2,9
5,2
```

The goal is to write a program `addMatFiles.idr` which takes as input via command line 3 options:

1. The first input filename
2. The second input filename
3. The destination filename

Then, the program should read the matrices from the 2 input files, add them together, and then write the result to the destination file.

Note that you should use the matrix addition mentioned in chapter 3 which uses dependent types to encode the sizes of matrices. Therefore, to perform this addition you will want to use dependent pairs to verify that the two input matrices have the same dimensions.
