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

By default, `make all` looks up both `clam.py` and `clang` from your `PATH`.
If they are not on your `PATH`, or you want to use a specific build, override
them on the command line:

```
make all CLAM=/path/to/clam/build/run/bin/clam.py CLANG=/path/to/clang-14
```

- `CLAM`: path to `clam.py`, the Clam driver.
- `CLANG`: path to the `clang` executable. It **must** be clang 14: Apple's
  `/usr/bin/clang` (and other newer clangs) emit bitcode that Clam's LLVM 14
  cannot read. `make all` checks this and stops with an error otherwise. This
  exact clang is passed explicitly to `clam.py` (via the `CLANG` environment
  variable), so it is used regardless of what `clang` is on your `PATH`.

To run a single test instead of the whole suite, use the `test` target and set
`TEST` to the test file (relative to the repo root):

```
make test TEST=test1.c
make test TEST=inter/inter0.c
```

The same `CLAM` and `CLANG` overrides apply, e.g.:

```
make test TEST=test1.c CLANG=/path/to/clang-14
```


## Build an analyzer from scratch using C++ Clam API ##

This tutorial includes a standalone LLVM static analyzer that uses the
C++ Clam API. The code of the full analyzer
is
[here](https://github.com/caballa/clam-tutorial/blob/master/api-example/myanalyzer.cpp).
To compile it:

```
cd api-example
make CLAM_INSTALL=/path/to/clam LLVM_HOME=/path/to/llvm
./myanalyzer ./bitcode/test3.ll
```

All build locations and options can be overridden on the command line (no need
to edit the Makefile); the defaults are shown in `api-example/Makefile`:

- `CLAM_INSTALL`, `LLVM_HOME`, `BOOST_ROOT`, `GMP_DIR`, `MPFR_DIR`: install
  locations of Clam, LLVM, Boost, GMP and MPFR.
- `LLVM_CONFIG`: name of `llvm-config` (searched under `$(LLVM_HOME)/bin`).
- `CLAM_EXTERNAL_LIBS`: set to `1` if Clam was built with external libraries
  (ldd, apron, elina); `0` (the default) otherwise. When `1`:
  - `ELINA_OR_APRON`: `APRON` (default) or `ELINA`, matching how Clam was built.
  - `CLAM_USE_LDD`: set to `1` (default) if Clam was also built with LDD boxes
    (`-DCRAB_USE_LDD=ON`), or `0` otherwise.

For example, for a Clam built with Apron and LDD:

```
make CLAM_EXTERNAL_LIBS=1
```

The directory `api-example/bitcode` has several bitcode samples that you can analyze.



