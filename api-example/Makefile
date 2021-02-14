# Installation directory for clam
CLAM_INSTALL=${HOME}/Repos/clam-dev10/install-release
# Installation directory for llvm
LLVM_HOME=${HOME}/src/clang+llvm-10.0.0-x86_64-apple-darwin

ifeq ($(LLVM_CONFIG),)
	LLVM_CONFIG=llvm-config
endif

LLVM_CFG = $(LLVM_HOME)/bin/$(LLVM_CONFIG)

CLAM_INCLUDE := \
	-I/usr/local/include \
	-I${CLAM_INSTALL}/crab/include \
	-I${CLAM_INSTALL}/ldd/include \
	-I${CLAM_INSTALL}/elina/include \
	-I${CLAM_INSTALL}/apron/include \
	-I${CLAM_INSTALL}/include

#LLVM_INCLUDE := $(shell ${LLVM_CFG} --includedir)

CXXFLAGS := \
	$(shell  ${LLVM_CFG} --cxxflags) \
	-fPIC -std=c++14 \
	-fvisibility-inlines-hidden -Werror=date-time -Wno-unused-local-typedef \
	-Wno-redeclared-class-member -Wno-sometimes-uninitialized \
	-Wno-deprecated-declarations -fcxx-exceptions -Wno-covered-switch-default \
	-Wno-inconsistent-missing-override \
	-D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS \
	-g -O2 -DNDEBUG \
	$(CLAM_INCLUDE) \
	$(LLVM_INCLUDE)

LLVM_LIBS := $(shell ${LLVM_CFG} --libs)

CRAB_LIBS := ${CLAM_INSTALL}/crab/lib/libCrab.a


CLAM_LIBS := \
	$(CLAM_INSTALL)/lib/libClamAnalysis.a \
	$(CLAM_INSTALL)/lib/libSeaDsaAnalysis.a 
CLAM_LIBS += ${CRAB_LIBS}

# to use APRON, pass MOD=APRON in make invocation
MOD ?= APRON
ifeq ($(MOD),ELINA)
    MOD := ELINA
    mod := elina
else
    MOD := APRON
    mod := apron
endif

MODINSTALL := ${CLAM_INSTALL}/$(mod)

ifeq ($(MOD),ELINA)
    CLAM_LIBS += \
        $(MODINSTALL)/lib/libelinalinearize.so \
        $(MODINSTALL)/lib/libelinaux.so \
        $(MODINSTALL)/lib/liboptoct.so \
        $(MODINSTALL)/lib/liboptpoly.so \
        $(MODINSTALL)/lib/liboptzones.so \
        $(MODINSTALL)/lib/libpartitions.so
else
    CLAM_LIBS += \
        $(MODINSTALL)/lib/libpolkaMPQ.a \
        $(MODINSTALL)/lib/liboctD.a \
        $(MODINSTALL)/lib/liboptoct.a \
        $(MODINSTALL)/lib/liblinkedlistapi.a \
        $(MODINSTALL)/lib/libapron.a \
        $(MODINSTALL)/lib/libboxMPQ.a \
        $(MODINSTALL)/lib/libitvMPQ.a
endif

LDDINSTALL=$(CLAM_INSTALL)/ldd

CLAM_LIBS += \
    $(LDDINSTALL)/lib/libtvpi.a \
    $(LDDINSTALL)/lib/libcudd.a \
    $(LDDINSTALL)/lib/libst.a \
    $(LDDINSTALL)/lib/libutil.a \
    $(LDDINSTALL)/lib/libmtr.a \
    $(LDDINSTALL)/lib/libepd.a \
    $(LDDINSTALL)/lib/libldd.a \


LDLIBS := \
     $(CLAM_LIBS) $(LLVM_LIBS) \
     -lmpfr -lgmpxx -lgmp -lm -lncurses

LLVM_LDFLAGS= $(shell ${LLVM_CFG} --ldflags)
LDFLAGS := $(LLVM_LDFLAGS)

TOOL=myanalyzer

all: $(TOOL)

%.o:  $(CXX) $(CXXFLAGS) $< -c -o $@

$(TOOL): $(TOOL).o
	$(CXX) $(LDFLAGS) $(TOOL).o $(LDLIBS) -o $(TOOL)

clean:
	rm -f $(TOOL).o $(TOOL)
