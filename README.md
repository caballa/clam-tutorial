# Clam Tutorial #

## Prerequisites ##

Install [Clam](https://github.com/seahorn/crab-llvm#requirements-for-compiling-from-sources) and make sure that `CLAM_INSTALL_DIR/bin` is in your `PATH` environment variable or set environment variable `CLAM` to `CLAM_INSTALL_DIR/bin`, where `CLAM_INSTALL_DIR` is the directory where Clam is installed. 

### Notes about Clam Installation ###

Install all the Clam's [prerequisites](https://github.com/seahorn/clam#requirements-for-compiling-from-sources).
This is the recipe to install Clam with ldd-boxes and Elina assuming LLVM is installed already in your machine:

```
git clone https://github.com/seahorn/clam 
cd clam
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=_CLAM_INSTALL_DIR_ -DLLVM_DIR=__PATH_TO_LLVM_CONFIG -DCRAB_USE_LDD=ON -DCRAB_USE_ELINA=ON ../
cmake --build . --target extra                 
cmake --build . --target crab && cmake ..
cmake --build . --target ldd && cmake ..
cmake --build . --target elina && cmake ..
cmake --build . --target install 
```
### Install `lit` and `OutputCheck` ###

```
 pip3 install lit
 pip3 install OutputCheck
```

## Run programs ##

To run all programs from this tutorial just type:

``` 
make all
```

This command will run Clam on each program and it will check (using `lit` and `OutputCheck`) that the results match the expected ones. 


## Build an analyzer from scratch using C++ Clam API ##

This tutorial includes a standalone LLVM static analyzer that uses the
C++ Clam API. The code of the full analyzer
is
[here](https://github.com/caballa/clam-tutorial/blob/master/api-example/myanalyzer.cpp).
To compile the code, follow these two steps:

1. Modify in `api-example/Makefile` the variables `CLAM_INSTALL`,
   `LLVM_HOME`, `BOOST_ROOT`, `GMP_DIR`, and `MPFR_DIR`.

2. Type `make`.

```
cd api-example
./myanalyzer ./bitcode/test3.ll
```

The directory `api-example/bitcode` has several bitcode samples that you can analyze.



