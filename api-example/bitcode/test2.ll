; ModuleID = '/var/folders/rd/wyr_48nj7qj5jy6nx62ftjlm0000gq/T/clam-33lbmu89/yusen.pp.bc'
source_filename = "yusen.c"
target datalayout = "e-m:o-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:128-n8:16:32-S128"
target triple = "i386-apple-macosx10.15.0"

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
_1:
  %_2 = call i32 @int_nd() #2
  %_3 = icmp slt i32 0, %_2
  %_call = zext i1 %_3 to i32
  call void @__CRAB_assume(i32 %_call) #2
  %_5 = icmp slt i32 %_2, 10
  %_call1 = zext i1 %_5 to i32
  call void @__CRAB_assume(i32 %_call1) #2
  %_malloc = mul i32 %_2, 4
  %malloc = alloca i8, i32 %_malloc, align 1
  %_call2 = bitcast i8* %malloc to i32*
  call void @memhavoc(i32* nonnull %_call2, i32 %_malloc) #2
  %_9 = icmp ult i32 %_2, %_malloc
  %_call3 = zext i1 %_9 to i32
  call void @__CRAB_assert(i32 %_call3) #2
  ret i32 0
}

declare i32 @int_nd() local_unnamed_addr #1

declare void @__CRAB_assume(i32) local_unnamed_addr #1

declare void @memhavoc(i32*, i32) local_unnamed_addr #1

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
