#include "llvm/Analysis/CallGraph.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/SourceMgr.h"

#include "seadsa/AllocWrapInfo.hh"
#include "seadsa/DsaLibFuncInfo.hh"

#include "clam/Clam.hh"
#include "clam/CfgBuilder.hh"
#include "clam/HeapAbstraction.hh"
#include "clam/SeaDsaHeapAbstraction.hh"

using namespace clam;
using namespace llvm;

int main(int argc, char *argv[]) {
  if (argc < 2) {
    llvm::errs() << "Not found input file\n";
    llvm::errs() << "Usage " << argv[0] << " " << "FILE.bc\n";
    return 1;
  }
  
  //////////////////////////////////////  
  // Get module from LLVM file
  //////////////////////////////////////  
  LLVMContext Context;
  SMDiagnostic Err;
  std::unique_ptr<Module> module = parseIRFile(argv[1], Err, Context);
  if (!module) {
    Err.print(argv[0], errs());
    return 1;
  }
  
  const auto& tripleS = module->getTargetTriple();
  Twine tripleT(tripleS);
  Triple triple(tripleT);
  TargetLibraryInfoWrapperPass  TLIW(triple);  

  //////////////////////////////////////
  // Run seadsa -- pointer analysis
  //////////////////////////////////////  
  CallGraph cg(*module);
  seadsa::AllocWrapInfo allocWrapInfo(&TLIW);
  allocWrapInfo.initialize(*module, nullptr);
  seadsa::DsaLibFuncInfo dsaLibFuncInfo;
  dsaLibFuncInfo.initialize(*module);
  std::unique_ptr<HeapAbstraction> mem(new SeaDsaHeapAbstraction(
		*module, cg, TLIW, allocWrapInfo, dsaLibFuncInfo, true));

  //////////////////////////////////////  
  // Run Clam inter-procedural analysis
  //////////////////////////////////////
  
  /// Translation from LLVM to CrabIR
  CrabBuilderParams cparams;
  // Translate all memory operations using seadsa
  cparams.setPrecision(clam::CrabBuilderPrecision::MEM);
  // Deal with unsigned comparisons
  cparams.lowerUnsignedICmpIntoSigned();
  // Print the CFG into dot format
  cparams.dot_cfg = true;
  
  CrabBuilderManager man(cparams, TLIW, std::move(mem));
  
  /// Set Crab parameters
  AnalysisParams aparams;
  // Zones domains (constraints of the form x - y <= k)
  aparams.dom = CrabDomain::ZONES_SPLIT_DBM;
  // Enable inter-procedural analysis
  aparams.run_inter = true;
  // Check for assertions
  aparams.check = clam::CheckerKind::ASSERTION;
  
  /// Create an inter-analysis instance 
  InterGlobalClam ga(*module, man);
  /// Run the Crab analysis
  ClamGlobalAnalysis::abs_dom_map_t assumptions;
  ga.analyze(aparams, assumptions);

  //////////////////////////////////////  
  // Post-processing of the Clam results
  //////////////////////////////////////
  
  // 1. Ask the Clam analysis for the invariants that hold at the
  // entry of each basic block.
  llvm::errs() << "===Invariants at the entry of each block===\n";
  for (auto &f: *module) {
    for (auto &b: f) {
      llvm::Optional<clam_abstract_domain> dom = ga.getPre(&b);
      if (dom.hasValue()) {
	crab::outs() << f.getName() << "#" << b.getName() << ":\n  "
		     << dom.getValue() << "\n";
	crab::outs() << f.getName() << "#" << b.getName() << ":\n  "
		     << dom.getValue().to_linear_constraint_system() << "\n";
      }
    }
  }

  // 2. Ask the Clam analysis API for the ranges of LLVM values
  llvm::errs() << "===Ranges for each Instruction's definition===\n";
  for (auto &f: *module) {
    for (auto &b: f) {
      for (auto &i: b) {
	if (!i.getType()->isVoidTy()) {
	  auto rangeVal = ga.range(i);
	  llvm::errs() << "Range for " << i << " = " << rangeVal << "\n";
	}
      }
    }
  }
  
  /// 3. Print results about assertion checks
  llvm::errs() << "===Assertion checks ===\n";
  ga.getChecksDB().write(crab::outs());
  
  return 0;
}
