; ModuleID = '/var/folders/rd/wyr_48nj7qj5jy6nx62ftjlm0000gq/T/lit_tmp_3PDl0i/clam-PDx2Z8/test1.pp.bc'
source_filename = "/Users/E30338/Repos/clam-tutorial/test1.c"
target datalayout = "e-m:o-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:128-n8:16:32-S128"
target triple = "i386-apple-macosx10.15.0"

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
_1:
  %_2 = call i32 @nd_int() #2
  %_3 = icmp slt i32 -1, %_2
  %_call = zext i1 %_3 to i32
  call void @__CRAB_assume(i32 %_call) #2
  br label %_.02

_.02:                                             ; preds = %_7, %_1
  %.02 = phi i32 [ 0, %_1 ], [ %_8, %_7 ]
  %.01 = phi i32 [ 0, %_1 ], [ %_9, %_7 ]
  %.0 = phi i32 [ 0, %_1 ], [ %_br1, %_7 ]
  %_br = icmp slt i32 %.0, %_2
  br i1 %_br, label %_7, label %_11

_7:                                               ; preds = %_.02
  %_8 = add nuw nsw i32 %.02, 3
  %_9 = add nuw nsw i32 %.01, 1
  %_br1 = add nuw nsw i32 %.0, 1
  br label %_.02

_11:                                              ; preds = %_.02
  %_12 = mul nsw i32 %.01, 3
  %_13 = icmp eq i32 %.02, %_12
  %_call2 = zext i1 %_13 to i32
  call void @__CRAB_assert(i32 %_call2) #2
  ret i32 0
}

declare i32 @nd_int() local_unnamed_addr #1

declare void @__CRAB_assume(i32) local_unnamed_addr #1

declare void @__CRAB_assert(i32) local_unnamed_addr #1

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 "}
