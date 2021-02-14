; ModuleID = '/var/folders/rd/wyr_48nj7qj5jy6nx62ftjlm0000gq/T/lit_tmp_3PDl0i/clam-EEYZM1/test5.pp.bc'
source_filename = "/Users/E30338/Repos/clam-tutorial/test5.c"
target datalayout = "e-m:o-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:128-n8:16:32-S128"
target triple = "i386-apple-macosx10.15.0"

@.str = private unnamed_addr constant [18 x i8] c"Value of a is %d\0A\00", align 1
@fun_ptr = internal unnamed_addr global void (i32)* @fun3, align 4

; Function Attrs: noinline nounwind ssp uwtable
define internal void @fun1(i32 %arg) #0 {
_2:
  %_3 = getelementptr inbounds [18 x i8], [18 x i8]* @.str, i32 0, i32 0
  %_ret = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) %_3, i32 %arg) #2
  ret void
}

declare i32 @printf(i8*, ...) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
define internal void @fun2(i32 %arg) #0 {
_2:
  %_3 = add nsw i32 %arg, 1
  %_4 = getelementptr inbounds [18 x i8], [18 x i8]* @.str, i32 0, i32 0
  %_ret = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) %_4, i32 %_3) #2
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define internal void @fun3(i32 %arg) #0 {
_2:
  %_3 = add nsw i32 %arg, 2
  %_4 = getelementptr inbounds [18 x i8], [18 x i8]* @.str, i32 0, i32 0
  %_ret = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) %_4, i32 %_3) #2
  ret void
}

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
_1:
  %_2 = bitcast i32 (...)* @nd to i32 ()*
  %_3 = call i32 %_2() #2
  %_4 = icmp slt i32 -1, %_3
  %_call = zext i1 %_4 to i32
  call void @__CRAB_assume(i32 %_call) #2
  %_fun1.fun2 = icmp slt i32 0, %_3
  %fun1.fun2 = select i1 %_fun1.fun2, void (i32)* @fun1, void (i32)* @fun2
  %_storemerge1 = icmp slt i32 %_3, 0
  %storemerge1 = select i1 %_storemerge1, void (i32)* @fun3, void (i32)* %fun1.fun2
  store void (i32)* %storemerge1, void (i32)** @fun_ptr, align 4
  %_8 = icmp ne void (i32)* %storemerge1, @fun3
  %_call1 = zext i1 %_8 to i32
  call void @__CRAB_assert(i32 %_call1) #2
  %_call2 = load void (i32)*, void (i32)** @fun_ptr, align 4
  call void %_call2(i32 %_3) #2
  ret i32 0
}

declare i32 @nd(...) local_unnamed_addr #1

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
