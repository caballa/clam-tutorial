; ModuleID = '/var/folders/rd/wyr_48nj7qj5jy6nx62ftjlm0000gq/T/lit_tmp_3PDl0i/clam-0nWY4n/test3.pp.bc'
source_filename = "/Users/E30338/Repos/clam-tutorial/test3.c"
target datalayout = "e-m:o-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:128-n8:16:32-S128"
target triple = "i386-apple-macosx10.15.0"

; Function Attrs: noinline nounwind ssp uwtable
define internal fastcc i32* @init(i32 %arg) unnamed_addr #0 {
_2:
  %_3 = mul i32 %arg, 4
  %_4 = call i8* @malloc(i32 %_3) #3
  %_ret = bitcast i8* %_4 to i32*
  ret i32* %_ret
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i32) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
_1:
  %_2 = call i32 @int_nd() #4
  %_3 = icmp slt i32 0, %_2
  %_call = zext i1 %_3 to i32
  call void @__CRAB_assume(i32 %_call) #4
  %_5 = call fastcc i32* @init(i32 %_2)
  %_6 = icmp slt i32 0, %_2
  %_br = call i32 @int_nd() #4
  br i1 %_6, label %.peel.begin, label %._crit_edge

.peel.begin:                                      ; preds = %_1
  %_8 = icmp eq i32 %_br, 0
  %_9 = zext i1 %_8 to i32
  %_store = getelementptr inbounds i32, i32* %_5, i32 0
  store i32 %_9, i32* %_store, align 4
  %_11 = add nuw nsw i32 0, 1
  %_12 = icmp slt i32 %_11, %_2
  %_br1 = call i32 @int_nd() #4
  br i1 %_12, label %.lr.ph.peel.newph, label %._crit_edge

.lr.ph.peel.newph:                                ; preds = %.lr.ph.peel.newph, %.peel.begin
  %_.01 = phi i32 [ %_br3, %.lr.ph.peel.newph ], [ %_br1, %.peel.begin ]
  %.01 = phi i32 [ %_18, %.lr.ph.peel.newph ], [ %_11, %.peel.begin ]
  %_15 = icmp eq i32 %_.01, 0
  %_16 = zext i1 %_15 to i32
  %_store2 = getelementptr inbounds i32, i32* %_5, i32 %.01
  store i32 %_16, i32* %_store2, align 4
  %_18 = add nuw nsw i32 %.01, 1
  %_19 = icmp slt i32 %_18, %_2
  %_br3 = call i32 @int_nd() #4
  br i1 %_19, label %.lr.ph.peel.newph, label %._crit_edge, !llvm.loop !4

._crit_edge:                                      ; preds = %.lr.ph.peel.newph, %.peel.begin, %_1
  %.lcssa = phi i32 [ %_br, %_1 ], [ %_br1, %.peel.begin ], [ %_br3, %.lr.ph.peel.newph ]
  %_21 = icmp slt i32 -1, %.lcssa
  %_call4 = zext i1 %_21 to i32
  call void @__CRAB_assume(i32 %_call4) #4
  %_23 = icmp slt i32 %.lcssa, %_2
  %_call5 = zext i1 %_23 to i32
  call void @__CRAB_assume(i32 %_call5) #4
  %_25 = getelementptr inbounds i32, i32* %_5, i32 %.lcssa
  %_26 = load i32, i32* %_25, align 4
  %_27 = icmp slt i32 -1, %_26
  %_call6 = zext i1 %_27 to i32
  call void @__CRAB_assert(i32 %_call6) #4
  %_29 = icmp slt i32 %_26, 2
  %_call7 = zext i1 %_29 to i32
  call void @__CRAB_assert(i32 %_call7) #4
  ret i32 0
}

declare i32 @int_nd() local_unnamed_addr #2

declare void @__CRAB_assume(i32) local_unnamed_addr #2

declare void @__CRAB_assert(i32) local_unnamed_addr #2

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind allocsize(0) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"NumRegisterParameters", i32 0}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"clang version 10.0.0 "}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.peeled.count", i32 1}
