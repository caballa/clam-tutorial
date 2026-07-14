# ---------------------------------------------------------------------------
# Tool locations
#
# Both tools default to being looked up from your PATH. To use a different
# build, override them on the command line, e.g.:
#
#     make all CLAM=/path/to/clam/build/run/bin/clam.py \
#              CLANG=/usr/lib/llvm-14/bin/clang
#
# CLAM  : path to clam.py, the Clam driver (discovered by lit.cfg).
# CLANG : path to the clang executable used to compile C into LLVM bitcode.
#         It MUST be clang 14: Apple's /usr/bin/clang (and other newer
#         clangs) produce bitcode that Clam's LLVM 14 cannot read.
# ---------------------------------------------------------------------------
CLAM  ?= clam.py
CLANG ?= clang

# Resolve CLANG to an absolute path (this also works when it is a bare name
# found on PATH). 'override' is needed so this still applies when CLANG is
# given on the command line, whose value would otherwise win. If it cannot be
# resolved, keep the literal value so check-clang can report what was passed.
override CLANG := $(or $(abspath $(shell command -v $(CLANG) 2>/dev/null)),$(CLANG))

# Directory containing clam.py.
CLAM_DIR := $(dir $(abspath $(shell command -v $(CLAM) 2>/dev/null)))

# Put clam.py's directory on PATH so lit.cfg can discover it (it also reads
# the CLAM env var). Export CLANG so that clam.py uses exactly this clang:
# lit forwards CLANG into the test environment, and clam.py reads it to
# locate the clang binary (falling back to PATH only if CLANG is unset).
export CLAM  := $(CLAM_DIR)
export CLANG
export PATH  := $(CLAM_DIR):$(PATH)

all: check-clang
	lit --param test_dir=. ./

# Run a single test, e.g.:  make test TEST=test1.c  or  make test TEST=inter/inter0.c
test: check-clang
	@if [ -z "$(TEST)" ]; then \
	  echo "ERROR: no test specified. Usage: make test TEST=test1.c"; \
	  exit 1; \
	fi
	lit -v --param test_dir=. ./$(TEST)

# Fail early with an actionable message unless clang 14 is available.
check-clang:
	@v=`$(CLANG) --version 2>/dev/null | sed -n 's/.*version \([0-9][0-9]*\).*/\1/p' | head -1`; \
	if [ -z "$$v" ]; then \
	  echo "ERROR: could not run clang ('$(CLANG)')."; \
	  echo "       Clam requires clang 14. Install it and pass its path with:"; \
	  echo "           make all CLANG=/path/to/clang-14"; \
	  exit 1; \
	fi; \
	if [ "$$v" != "14" ]; then \
	  echo "ERROR: Clam requires clang 14, but '$(CLANG)' is version $$v."; \
	  echo "       Newer clangs (e.g. Apple's /usr/bin/clang) emit bitcode that"; \
	  echo "       Clam's LLVM 14 cannot read. Pass a clang 14 with:"; \
	  echo "           make all CLANG=/path/to/clang-14"; \
	  exit 1; \
	fi

clean:
	rm -Rf Output
	rm -Rf inter/Output
	rm -Rf tag/Output
	rm -f *.dot
