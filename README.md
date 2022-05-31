# Clam Tutorial #

## Prerequisites ##

Install [Clam](https://github.com/seahorn/crab-llvm#requirements-for-compiling-from-sources) and make sure that `CLAM_INSTALL_DIR/bin` is in your `PATH` environment variable or set environment variable `CLAM` to `CLAM_INSTALL_DIR/bin`, where `CLAM_INSTALL_DIR` is the directory where Clam is installed. 

### Notes about Clam Installation ###

This is the recipe to install Clam with ldd-boxes and Elina assuming LLVM 10 is installed already in your machine:

```
git clone https://github.com/seahorn/crab-llvm clam
cd clam
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=_CLAM_INSTALL_DIR_ -DLLVM_DIR=__PATH_TO_LLVM_CONFIG -DCRAB_USE_LDD=ON -DCRAB_USE_ELINA=ON ../
cmake --build . --target extra                 
cmake --build . --target crab && cmake ..
cmake --build . --target ldd && cmake ..
cmake --build . --target elina && cmake ..
cmake --build . --target install 
```

## Run programs ##

Run all programs with `lit`:

``` 
make all
```

## Build an analyzer from scratch using C++ Clam API ##

This tutorial includes a standalone LLVM static analyzer that uses
the C++ Clam API. The code of the full analyzer is [here](https://github.com/caballa/clam-tutorial/blob/master/api-example/myanalyzer.cpp). 
To compile the code, follow these two steps: 

1. Modify in `api-example/Makefile` the variables `CLAM_INSTALL_DIR` and `LLVM_HOME`.
2. Type `make`.

```
cd api-example
./myanalyzer ./bitcode/test3.ll
```

The directory `api-example/bitcode` has several bitcode samples that you can analyze.



