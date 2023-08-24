# To build the docker image by yourself 
#
#    docker build -t clam-tutorial -f clam-tutorial.Dockerfile .
#
# To load the image, just type:
#
#    docker run -v `pwd`:/host -it clam-tutorial
########################################################

ARG BASE_IMAGE=jammy-llvm14
FROM seahorn/buildpack-deps-seahorn:$BASE_IMAGE

# Needed to run clang with -m32
RUN apt-get install -yqq libc6-dev-i386

### Download crab
RUN cd / && rm -rf /crab && \
    git clone -b dev https://github.com/seahorn/crab crab;

## Download/install clam
RUN cd / && rm -rf /clam && \
    git clone -b dev14 https://github.com/seahorn/clam.git clam; \
    mkdir -p /clam/build
WORKDIR /clam/build
RUN cmake -GNinja \
          -DCMAKE_BUILD_TYPE=RelWithDebInfo \
          -DCMAKE_INSTALL_PREFIX=run \
          -DCMAKE_CXX_COMPILER=clang++-14 \
	  -DCMAKE_C_COMPILER=clang-14 \
	  -DCRAB_ROOT=/crab \
          -DCRAB_USE_APRON=ON \
          -DCRAB_USE_LDD=ON \	  	  
          -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
          ../ && \
    cmake --build . --target extra  && cmake .. && \
    cmake --build . --target ldd  && cmake .. && \
    cmake --build . --target apron  && cmake .. && \
    cmake --build . --target install

RUN ln -s /usr/bin/clang-14 /usr/bin/clang
RUN ln -s /usr/bin/llvm-dis-14 /usr/bin/llvm-dis
ENV PATH "/usr/bin:$PATH"
ENV PATH "/clam/build/run/bin:$PATH"
ENV CLAM "/clam/build/run/bin"

WORKDIR /

## Download clam-tutorial
RUN git clone https://github.com/caballa/clam-tutorial.git
WORKDIR /clam-tutorial

## Run examples
RUN make all

