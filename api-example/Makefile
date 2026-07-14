# ===========================================================================
# Build the example analyzer (myanalyzer) against the Clam C++ API.
#
# Every location and option below can be overridden on the command line, e.g.:
#
#     make CLAM_INSTALL=/path/to/clam LLVM_HOME=/path/to/llvm
#     make CLAM_EXTERNAL_LIBS=1          # if Clam was built with ldd/apron/elina
#     make CLAM_EXTERNAL_LIBS=1 ELINA_OR_APRON=ELINA
# ===========================================================================

# Installation directory for Clam
CLAM_INSTALL ?= ${HOME}/Repos/clam14/install-release
# Installation directory for LLVM
LLVM_HOME    ?= ${HOME}/src/llvm-14.0.0.src/install-release
# Installation prefixes for Boost, GMP and MPFR.
# (MPFR is only used when CLAM_EXTERNAL_LIBS=1, i.e. with Apron/Elina.)
BOOST_ROOT   ?= /opt/homebrew
GMP_DIR      ?= /opt/homebrew
MPFR_DIR     ?= /opt/homebrew
# Name of llvm-config, searched under $(LLVM_HOME)/bin
LLVM_CONFIG  ?= llvm-config

# Set to 1 if Clam was built WITH external libraries (ldd, apron, elina),
# or 0 if it was built without them.
CLAM_EXTERNAL_LIBS ?= 0
# When using external libraries, which relational domain Clam was built with:
# APRON (-DCRAB_USE_APRON=ON) or ELINA (-DCRAB_USE_ELINA=ON).
ELINA_OR_APRON     ?= APRON
# Set to 1 if Clam was also built with the LDD boxes library
# (-DCRAB_USE_LDD=ON). Only consulted when CLAM_EXTERNAL_LIBS=1.
CLAM_USE_LDD       ?= 1

# --- Base include dirs and libraries (common to both configurations) --------
CLAM_INCLUDE := \
	-I$(CLAM_INSTALL)/crab/include \
	-I$(CLAM_INSTALL)/include \
	-I$(BOOST_ROOT)/include \
	-I$(GMP_DIR)/include

CLAM_LIBS := \
	$(CLAM_INSTALL)/lib/libClamAnalysis.a \
	$(CLAM_INSTALL)/lib/libSeaDsaAnalysis.a \
	$(CLAM_INSTALL)/crab/lib/libCrab.a

# Extra link flags; extended by Makefile.external.config when needed.
SYS_LIBS     := -lncurses -lz
MPFR_LDFLAGS :=

# --- Configuration-specific pieces (external libraries: ldd, apron/elina) ---
ifeq ($(CLAM_EXTERNAL_LIBS),1)
    include Makefile.external.config
endif

# --- Common compiler/linker flags and build rules ---------------------------
include Makefile.common
