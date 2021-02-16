# Clam Tutorial #

## Prerequisites ##

Install [Clam](https://github.com/seahorn/crab-llvm#requirements-for-compiling-from-sources) and make sure that `CLAM_INSTALL_DIR/bin` is in your `PATH` environment variable or set environment variable `CLAM` to `CLAM_INSTALL_DIR/bin`, where `CLAM_INSTALL_DIR` is the directory where Clam is installed. 

Run all programs with `lit`:

``` 
lit --param test_dir=. ./
```

This tutorial also includes a standalone LLVM static analyzer that uses
the C++ Clam API. The code of the full analyzer is in
`api-example/myanalyzer.cpp`.




