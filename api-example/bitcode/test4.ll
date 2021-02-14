; ModuleID = '/var/folders/rd/wyr_48nj7qj5jy6nx62ftjlm0000gq/T/lit_tmp_3PDl0i/clam-cmZBra/test4.pp.bc'
source_filename = "/Users/E30338/Repos/clam-tutorial/test4.c"
target datalayout = "e-m:o-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:128-n8:16:32-S128"
target triple = "i386-apple-macosx10.15.0"

%struct.node = type { i32*, i32, i32, %struct.node* }

; Function Attrs: noinline nounwind ssp uwtable
define internal fastcc i8* @malloc_not_fail(i32 %arg) unnamed_addr #0 {
_2:
  %_3 = call i8* @malloc(i32 %arg) #3
  %_4 = icmp ult i8* null, %_3
  %_call = zext i1 %_4 to i32
  call void @__CRAB_assume(i32 %_call) #4
  ret i8* %_3
}

; Function Attrs: allocsize(0)
declare i8* @malloc(i32) local_unnamed_addr #1

declare void @__CRAB_assume(i32) local_unnamed_addr #2

; Function Attrs: noinline nounwind ssp uwtable
define internal fastcc i32* @mycalloc(i32 %arg) unnamed_addr #0 {
_2:
  %_3 = mul i32 %arg, 4
  %_4 = call fastcc i8* @malloc_not_fail(i32 %_3)
  %_5 = bitcast i8* %_4 to i32*
  %_br = icmp slt i32 0, %arg
  br i1 %_br, label %.peel.begin, label %._crit_edge

.peel.begin:                                      ; preds = %_2
  %_store = getelementptr inbounds i32, i32* %_5, i32 0
  store i32 0, i32* %_store, align 4
  %_8 = add nuw nsw i32 0, 1
  %_br1 = icmp slt i32 %_8, %arg
  br i1 %_br1, label %.lr.ph.peel.newph, label %._crit_edge

.lr.ph.peel.newph:                                ; preds = %.lr.ph.peel.newph, %.peel.begin
  %.01 = phi i32 [ %_11, %.lr.ph.peel.newph ], [ %_8, %.peel.begin ]
  %_store2 = getelementptr inbounds i32, i32* %_5, i32 %.01
  store i32 0, i32* %_store2, align 4
  %_11 = add nuw nsw i32 %.01, 1
  %_br3 = icmp slt i32 %_11, %arg
  br i1 %_br3, label %.lr.ph.peel.newph, label %._crit_edge, !llvm.loop !4

._crit_edge:                                      ; preds = %.lr.ph.peel.newph, %.peel.begin, %_2
  ret i32* %_5
}

; Function Attrs: noinline nounwind ssp uwtable
define internal fastcc %struct.node* @mk_list(i32 %arg, i32 %arg1) unnamed_addr #0 {
_3:
  %_br = icmp slt i32 0, %arg
  br i1 %_br, label %.peel.begin, label %._crit_edge

.peel.begin:                                      ; preds = %_3
  %_5 = call fastcc i32* @mycalloc(i32 %arg1)
  %_6 = call fastcc i8* @malloc_not_fail(i32 16)
  %_store = bitcast i8* %_6 to i32**
  store i32* %_5, i32** %_store, align 4
  %_8 = getelementptr inbounds i8, i8* %_6, i32 8
  %_store2 = bitcast i8* %_8 to i32*
  store i32 %arg1, i32* %_store2, align 4
  %_10 = call i32 @int_nd() #4
  %_11 = icmp slt i32 -1, %_10
  %_call = zext i1 %_11 to i32
  call void @__CRAB_assume(i32 %_call) #4
  %_13 = icmp slt i32 %_10, %arg1
  %_call3 = zext i1 %_13 to i32
  call void @__CRAB_assume(i32 %_call3) #4
  %_15 = getelementptr inbounds i8, i8* %_6, i32 4
  %_store4 = bitcast i8* %_15 to i32*
  store i32 %_10, i32* %_store4, align 4
  %_17 = getelementptr inbounds i8, i8* %_6, i32 12
  %_store5 = bitcast i8* %_17 to %struct.node**
  store %struct.node* null, %struct.node** %_store5, align 4
  %_19 = bitcast i8* %_6 to %struct.node*
  %_20 = add nuw nsw i32 0, 1
  %_br6 = icmp slt i32 %_20, %arg
  br i1 %_br6, label %.lr.ph.peel.newph, label %._crit_edge

.lr.ph.peel.newph:                                ; preds = %.lr.ph.peel.newph, %.peel.begin
  %.03 = phi i32 [ %_37, %.lr.ph.peel.newph ], [ %_20, %.peel.begin ]
  %.012 = phi %struct.node* [ %_36, %.lr.ph.peel.newph ], [ %_19, %.peel.begin ]
  %_22 = call fastcc i32* @mycalloc(i32 %arg1)
  %_23 = call fastcc i8* @malloc_not_fail(i32 16)
  %_store7 = bitcast i8* %_23 to i32**
  store i32* %_22, i32** %_store7, align 4
  %_25 = getelementptr inbounds i8, i8* %_23, i32 8
  %_store8 = bitcast i8* %_25 to i32*
  store i32 %arg1, i32* %_store8, align 4
  %_27 = call i32 @int_nd() #4
  %_28 = icmp slt i32 -1, %_27
  %_call9 = zext i1 %_28 to i32
  call void @__CRAB_assume(i32 %_call9) #4
  %_30 = icmp slt i32 %_27, %arg1
  %_call10 = zext i1 %_30 to i32
  call void @__CRAB_assume(i32 %_call10) #4
  %_32 = getelementptr inbounds i8, i8* %_23, i32 4
  %_store11 = bitcast i8* %_32 to i32*
  store i32 %_27, i32* %_store11, align 4
  %_34 = getelementptr inbounds i8, i8* %_23, i32 12
  %_store12 = bitcast i8* %_34 to %struct.node**
  store %struct.node* %.012, %struct.node** %_store12, align 4
  %_36 = bitcast i8* %_23 to %struct.node*
  %_37 = add nuw nsw i32 %.03, 1
  %_br13 = icmp slt i32 %_37, %arg
  br i1 %_br13, label %.lr.ph.peel.newph, label %._crit_edge.loopexit, !llvm.loop !6

._crit_edge.loopexit:                             ; preds = %.lr.ph.peel.newph
  %.lcssa5 = phi i8* [ %_23, %.lr.ph.peel.newph ]
  %_br14 = bitcast i8* %.lcssa5 to %struct.node*
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.peel.begin, %_3
  %.01.lcssa = phi %struct.node* [ null, %_3 ], [ %_19, %.peel.begin ], [ %_br14, %._crit_edge.loopexit ]
  ret %struct.node* %.01.lcssa
}

declare i32 @int_nd() local_unnamed_addr #2

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() local_unnamed_addr #0 {
_1:
  %_2 = call i32 @int_nd() #4
  %_3 = icmp slt i32 0, %_2
  %_call = zext i1 %_3 to i32
  call void @__CRAB_assume(i32 %_call) #4
  %_5 = call i32 @int_nd() #4
  %_6 = icmp slt i32 0, %_5
  %_call1 = zext i1 %_6 to i32
  call void @__CRAB_assume(i32 %_call1) #4
  %_8 = call fastcc %struct.node* @mk_list(i32 %_2, i32 %_5)
  %_br = icmp eq %struct.node* %_8, null
  br i1 %_br, label %._crit_edge6, label %.peel.begin8

.peel.begin8:                                     ; preds = %_1
  %_10 = getelementptr inbounds %struct.node, %struct.node* %_8, i32 0, i32 0
  %_11 = load i32*, i32** %_10, align 4
  %_12 = icmp ult i32* null, %_11
  %_call2 = zext i1 %_12 to i32
  call void @__CRAB_assert(i32 %_call2) #4
  %_14 = getelementptr inbounds %struct.node, %struct.node* %_8, i32 0, i32 1
  %_15 = load i32, i32* %_14, align 4
  %_16 = icmp slt i32 %_15, %_5
  %_call3 = zext i1 %_16 to i32
  call void @__CRAB_assert(i32 %_call3) #4
  %_18 = load i32, i32* %_14, align 4
  %_19 = getelementptr inbounds %struct.node, %struct.node* %_8, i32 0, i32 2
  %_20 = load i32, i32* %_19, align 4
  %_21 = icmp sle i32 %_18, %_20
  %_call4 = zext i1 %_21 to i32
  call void @__CRAB_assert(i32 %_call4) #4
  %_br5 = icmp slt i32 0, %_5
  br i1 %_br5, label %.peel.begin.peel, label %._crit_edge.peel

.peel.begin.peel:                                 ; preds = %.peel.begin8
  %_24 = load i32*, i32** %_10, align 4
  %_25 = getelementptr inbounds i32, i32* %_24, i32 0
  %_26 = load i32, i32* %_25, align 4
  %_27 = icmp eq i32 %_26, 0
  %_call6 = zext i1 %_27 to i32
  call void @__CRAB_assert(i32 %_call6) #4
  %_29 = add nuw nsw i32 0, 1
  %_br7 = icmp slt i32 %_29, %_5
  br i1 %_br7, label %.lr.ph.peel.newph.peel, label %._crit_edge.peel

.lr.ph.peel.newph.peel:                           ; preds = %.lr.ph.peel.newph.peel, %.peel.begin.peel
  %.02.peel = phi i32 [ %_36, %.lr.ph.peel.newph.peel ], [ %_29, %.peel.begin.peel ]
  %_31 = load i32*, i32** %_10, align 4
  %_32 = getelementptr inbounds i32, i32* %_31, i32 %.02.peel
  %_33 = load i32, i32* %_32, align 4
  %_34 = icmp eq i32 %_33, 0
  %_call8 = zext i1 %_34 to i32
  call void @__CRAB_assert(i32 %_call8) #4
  %_36 = add nuw nsw i32 %.02.peel, 1
  %_br9 = icmp slt i32 %_36, %_5
  br i1 %_br9, label %.lr.ph.peel.newph.peel, label %._crit_edge.peel, !llvm.loop !7

._crit_edge.peel:                                 ; preds = %.lr.ph.peel.newph.peel, %.peel.begin.peel, %.peel.begin8
  %_38 = getelementptr inbounds %struct.node, %struct.node* %_8, i32 0, i32 3
  %_39 = load %struct.node*, %struct.node** %_38, align 4
  %_br10 = icmp eq %struct.node* %_39, null
  br i1 %_br10, label %._crit_edge6, label %.lr.ph5.peel.newph

.lr.ph5.peel.newph:                               ; preds = %._crit_edge.peel
  %_41 = icmp slt i32 0, %_5
  %_br11 = icmp slt i32 1, %_5
  br label %_.013

_.013:                                            ; preds = %._crit_edge, %.lr.ph5.peel.newph
  %.013 = phi %struct.node* [ %_39, %.lr.ph5.peel.newph ], [ %_70, %._crit_edge ]
  %_44 = getelementptr inbounds %struct.node, %struct.node* %.013, i32 0, i32 0
  %_45 = load i32*, i32** %_44, align 4
  %_46 = icmp ult i32* null, %_45
  %_call12 = zext i1 %_46 to i32
  call void @__CRAB_assert(i32 %_call12) #4
  %_48 = getelementptr inbounds %struct.node, %struct.node* %.013, i32 0, i32 1
  %_49 = load i32, i32* %_48, align 4
  %_50 = icmp slt i32 %_49, %_5
  %_call13 = zext i1 %_50 to i32
  call void @__CRAB_assert(i32 %_call13) #4
  %_52 = load i32, i32* %_48, align 4
  %_53 = getelementptr inbounds %struct.node, %struct.node* %.013, i32 0, i32 2
  %_54 = load i32, i32* %_53, align 4
  %_55 = icmp sle i32 %_52, %_54
  %_call14 = zext i1 %_55 to i32
  call void @__CRAB_assert(i32 %_call14) #4
  br i1 %_41, label %.peel.begin, label %._crit_edge

.peel.begin:                                      ; preds = %_.013
  %_57 = load i32*, i32** %_44, align 4
  %_58 = getelementptr inbounds i32, i32* %_57, i32 0
  %_59 = load i32, i32* %_58, align 4
  %_60 = icmp eq i32 %_59, 0
  %_call15 = zext i1 %_60 to i32
  call void @__CRAB_assert(i32 %_call15) #4
  br i1 %_br11, label %.lr.ph.peel.newph, label %._crit_edge

.lr.ph.peel.newph:                                ; preds = %.lr.ph.peel.newph, %.peel.begin
  %.02 = phi i32 [ %_67, %.lr.ph.peel.newph ], [ 1, %.peel.begin ]
  %_62 = load i32*, i32** %_44, align 4
  %_63 = getelementptr inbounds i32, i32* %_62, i32 %.02
  %_64 = load i32, i32* %_63, align 4
  %_65 = icmp eq i32 %_64, 0
  %_call16 = zext i1 %_65 to i32
  call void @__CRAB_assert(i32 %_call16) #4
  %_67 = add nuw nsw i32 %.02, 1
  %_br17 = icmp slt i32 %_67, %_5
  br i1 %_br17, label %.lr.ph.peel.newph, label %._crit_edge, !llvm.loop !7

._crit_edge:                                      ; preds = %.lr.ph.peel.newph, %.peel.begin, %_.013
  %_69 = getelementptr inbounds %struct.node, %struct.node* %.013, i32 0, i32 3
  %_70 = load %struct.node*, %struct.node** %_69, align 4
  %_br18 = icmp eq %struct.node* %_70, null
  br i1 %_br18, label %._crit_edge6, label %_.013, !llvm.loop !8

._crit_edge6:                                     ; preds = %._crit_edge, %._crit_edge.peel, %_1
  ret i32 0
}

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
!6 = distinct !{!6, !5}
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !5}
