{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Types
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28

action_0 (42) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (42) = happyShift action_2
action_1 _ = happyFail

action_2 (37) = happyShift action_4
action_2 _ = happyFail

action_3 (68) = happyAccept
action_3 _ = happyFail

action_4 (29) = happyShift action_5
action_4 _ = happyFail

action_5 (37) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (30) = happyShift action_8
action_6 (34) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (31) = happyShift action_11
action_8 _ = happyFail

action_9 (37) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (47) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_11

action_13 (43) = happyShift action_19
action_13 (44) = happyShift action_20
action_13 (45) = happyShift action_21
action_13 (10) = happyGoto action_16
action_13 (11) = happyGoto action_17
action_13 (14) = happyGoto action_18
action_13 _ = happyFail

action_14 (37) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (32) = happyShift action_36
action_15 (34) = happyShift action_9
action_15 _ = happyFail

action_16 (31) = happyShift action_35
action_16 _ = happyFail

action_17 (6) = happyGoto action_34
action_17 _ = happyReduce_4

action_18 (33) = happyShift action_33
action_18 _ = happyFail

action_19 (37) = happyShift action_32
action_19 _ = happyFail

action_20 (37) = happyShift action_31
action_20 _ = happyFail

action_21 (37) = happyShift action_28
action_21 (45) = happyShift action_21
action_21 (50) = happyShift action_29
action_21 (53) = happyShift action_30
action_21 (14) = happyGoto action_22
action_21 (15) = happyGoto action_23
action_21 (16) = happyGoto action_24
action_21 (17) = happyGoto action_25
action_21 (18) = happyGoto action_26
action_21 (20) = happyGoto action_27
action_21 _ = happyReduce_21

action_22 _ = happyReduce_27

action_23 (46) = happyShift action_61
action_23 _ = happyFail

action_24 (31) = happyShift action_60
action_24 _ = happyReduce_22

action_25 _ = happyReduce_23

action_26 (55) = happyShift action_59
action_26 _ = happyFail

action_27 _ = happyReduce_26

action_28 (29) = happyShift action_57
action_28 (35) = happyShift action_58
action_28 (55) = happyReduce_31
action_28 (19) = happyGoto action_56
action_28 _ = happyReduce_33

action_29 (29) = happyShift action_51
action_29 (37) = happyShift action_52
action_29 (39) = happyShift action_53
action_29 (66) = happyShift action_54
action_29 (22) = happyGoto action_55
action_29 (23) = happyGoto action_48
action_29 (24) = happyGoto action_49
action_29 (25) = happyGoto action_50
action_29 _ = happyFail

action_30 (29) = happyShift action_51
action_30 (37) = happyShift action_52
action_30 (39) = happyShift action_53
action_30 (66) = happyShift action_54
action_30 (22) = happyGoto action_47
action_30 (23) = happyGoto action_48
action_30 (24) = happyGoto action_49
action_30 (25) = happyGoto action_50
action_30 _ = happyFail

action_31 (29) = happyShift action_45
action_31 (12) = happyGoto action_46
action_31 _ = happyReduce_16

action_32 (29) = happyShift action_45
action_32 (12) = happyGoto action_44
action_32 _ = happyReduce_16

action_33 _ = happyReduce_1

action_34 (45) = happyShift action_21
action_34 (47) = happyShift action_14
action_34 (14) = happyGoto action_43
action_34 _ = happyFail

action_35 _ = happyReduce_12

action_36 (38) = happyShift action_39
action_36 (40) = happyShift action_40
action_36 (41) = happyShift action_41
action_36 (48) = happyShift action_42
action_36 (7) = happyGoto action_37
action_36 (8) = happyGoto action_38
action_36 _ = happyFail

action_37 (31) = happyShift action_91
action_37 _ = happyFail

action_38 _ = happyReduce_6

action_39 _ = happyReduce_10

action_40 _ = happyReduce_8

action_41 _ = happyReduce_9

action_42 (35) = happyShift action_90
action_42 _ = happyFail

action_43 _ = happyReduce_13

action_44 (32) = happyShift action_89
action_44 _ = happyFail

action_45 (37) = happyShift action_7
action_45 (5) = happyGoto action_87
action_45 (13) = happyGoto action_88
action_45 _ = happyFail

action_46 (31) = happyShift action_86
action_46 _ = happyFail

action_47 (54) = happyShift action_85
action_47 _ = happyFail

action_48 (56) = happyShift action_77
action_48 (57) = happyShift action_78
action_48 (58) = happyShift action_79
action_48 (59) = happyShift action_80
action_48 (60) = happyShift action_81
action_48 (61) = happyShift action_82
action_48 (62) = happyShift action_83
action_48 (63) = happyShift action_84
action_48 (26) = happyGoto action_75
action_48 (28) = happyGoto action_76
action_48 _ = happyReduce_37

action_49 (64) = happyShift action_73
action_49 (65) = happyShift action_74
action_49 (27) = happyGoto action_72
action_49 _ = happyReduce_39

action_50 _ = happyReduce_41

action_51 (29) = happyShift action_51
action_51 (37) = happyShift action_52
action_51 (39) = happyShift action_53
action_51 (66) = happyShift action_54
action_51 (22) = happyGoto action_71
action_51 (23) = happyGoto action_48
action_51 (24) = happyGoto action_49
action_51 (25) = happyGoto action_50
action_51 _ = happyFail

action_52 (29) = happyShift action_70
action_52 (35) = happyShift action_58
action_52 (19) = happyGoto action_69
action_52 _ = happyReduce_31

action_53 _ = happyReduce_45

action_54 (29) = happyShift action_51
action_54 (37) = happyShift action_52
action_54 (39) = happyShift action_53
action_54 (66) = happyShift action_54
action_54 (25) = happyGoto action_68
action_54 _ = happyFail

action_55 (51) = happyShift action_67
action_55 _ = happyFail

action_56 _ = happyReduce_30

action_57 (29) = happyShift action_51
action_57 (37) = happyShift action_52
action_57 (39) = happyShift action_53
action_57 (66) = happyShift action_54
action_57 (21) = happyGoto action_65
action_57 (22) = happyGoto action_66
action_57 (23) = happyGoto action_48
action_57 (24) = happyGoto action_49
action_57 (25) = happyGoto action_50
action_57 _ = happyFail

action_58 (29) = happyShift action_51
action_58 (37) = happyShift action_52
action_58 (39) = happyShift action_53
action_58 (66) = happyShift action_54
action_58 (22) = happyGoto action_64
action_58 (23) = happyGoto action_48
action_58 (24) = happyGoto action_49
action_58 (25) = happyGoto action_50
action_58 _ = happyFail

action_59 (29) = happyShift action_51
action_59 (37) = happyShift action_52
action_59 (39) = happyShift action_53
action_59 (66) = happyShift action_54
action_59 (22) = happyGoto action_63
action_59 (23) = happyGoto action_48
action_59 (24) = happyGoto action_49
action_59 (25) = happyGoto action_50
action_59 _ = happyFail

action_60 (37) = happyShift action_28
action_60 (45) = happyShift action_21
action_60 (50) = happyShift action_29
action_60 (53) = happyShift action_30
action_60 (14) = happyGoto action_22
action_60 (17) = happyGoto action_62
action_60 (18) = happyGoto action_26
action_60 (20) = happyGoto action_27
action_60 _ = happyFail

action_61 _ = happyReduce_20

action_62 _ = happyReduce_24

action_63 _ = happyReduce_25

action_64 (36) = happyShift action_106
action_64 _ = happyFail

action_65 (30) = happyShift action_104
action_65 (34) = happyShift action_105
action_65 _ = happyFail

action_66 _ = happyReduce_35

action_67 (37) = happyShift action_28
action_67 (45) = happyShift action_21
action_67 (50) = happyShift action_29
action_67 (53) = happyShift action_30
action_67 (14) = happyGoto action_22
action_67 (17) = happyGoto action_103
action_67 (18) = happyGoto action_26
action_67 (20) = happyGoto action_27
action_67 _ = happyFail

action_68 _ = happyReduce_47

action_69 _ = happyReduce_43

action_70 (29) = happyShift action_51
action_70 (37) = happyShift action_52
action_70 (39) = happyShift action_53
action_70 (66) = happyShift action_54
action_70 (21) = happyGoto action_102
action_70 (22) = happyGoto action_66
action_70 (23) = happyGoto action_48
action_70 (24) = happyGoto action_49
action_70 (25) = happyGoto action_50
action_70 _ = happyFail

action_71 (30) = happyShift action_101
action_71 _ = happyFail

action_72 (29) = happyShift action_51
action_72 (37) = happyShift action_52
action_72 (39) = happyShift action_53
action_72 (66) = happyShift action_54
action_72 (25) = happyGoto action_100
action_72 _ = happyFail

action_73 _ = happyReduce_50

action_74 _ = happyReduce_51

action_75 (29) = happyShift action_51
action_75 (37) = happyShift action_52
action_75 (39) = happyShift action_53
action_75 (66) = happyShift action_54
action_75 (24) = happyGoto action_99
action_75 (25) = happyGoto action_50
action_75 _ = happyFail

action_76 (29) = happyShift action_51
action_76 (37) = happyShift action_52
action_76 (39) = happyShift action_53
action_76 (66) = happyShift action_54
action_76 (23) = happyGoto action_98
action_76 (24) = happyGoto action_49
action_76 (25) = happyGoto action_50
action_76 _ = happyFail

action_77 _ = happyReduce_52

action_78 _ = happyReduce_53

action_79 _ = happyReduce_55

action_80 _ = happyReduce_56

action_81 _ = happyReduce_54

action_82 _ = happyReduce_57

action_83 _ = happyReduce_48

action_84 _ = happyReduce_49

action_85 (37) = happyShift action_28
action_85 (45) = happyShift action_21
action_85 (50) = happyShift action_29
action_85 (53) = happyShift action_30
action_85 (14) = happyGoto action_22
action_85 (17) = happyGoto action_97
action_85 (18) = happyGoto action_26
action_85 (20) = happyGoto action_27
action_85 _ = happyFail

action_86 _ = happyReduce_15

action_87 (32) = happyShift action_96
action_87 (34) = happyShift action_9
action_87 _ = happyFail

action_88 (30) = happyShift action_94
action_88 (31) = happyShift action_95
action_88 _ = happyFail

action_89 (38) = happyShift action_39
action_89 (40) = happyShift action_40
action_89 (41) = happyShift action_41
action_89 (8) = happyGoto action_93
action_89 _ = happyFail

action_90 (39) = happyShift action_92
action_90 _ = happyFail

action_91 _ = happyReduce_5

action_92 (67) = happyShift action_114
action_92 _ = happyFail

action_93 (31) = happyShift action_113
action_93 _ = happyFail

action_94 _ = happyReduce_17

action_95 (37) = happyShift action_7
action_95 (5) = happyGoto action_112
action_95 _ = happyFail

action_96 (38) = happyShift action_39
action_96 (40) = happyShift action_40
action_96 (41) = happyShift action_41
action_96 (48) = happyShift action_42
action_96 (7) = happyGoto action_111
action_96 (8) = happyGoto action_38
action_96 _ = happyFail

action_97 _ = happyReduce_29

action_98 (62) = happyShift action_83
action_98 (63) = happyShift action_84
action_98 (26) = happyGoto action_75
action_98 _ = happyReduce_38

action_99 (64) = happyShift action_73
action_99 (65) = happyShift action_74
action_99 (27) = happyGoto action_72
action_99 _ = happyReduce_40

action_100 _ = happyReduce_42

action_101 _ = happyReduce_46

action_102 (30) = happyShift action_110
action_102 (34) = happyShift action_105
action_102 _ = happyFail

action_103 (52) = happyShift action_109
action_103 _ = happyFail

action_104 _ = happyReduce_34

action_105 (29) = happyShift action_51
action_105 (37) = happyShift action_52
action_105 (39) = happyShift action_53
action_105 (66) = happyShift action_54
action_105 (22) = happyGoto action_108
action_105 (23) = happyGoto action_48
action_105 (24) = happyGoto action_49
action_105 (25) = happyGoto action_50
action_105 _ = happyFail

action_106 (35) = happyShift action_58
action_106 (19) = happyGoto action_107
action_106 _ = happyReduce_31

action_107 _ = happyReduce_32

action_108 _ = happyReduce_36

action_109 (37) = happyShift action_28
action_109 (45) = happyShift action_21
action_109 (50) = happyShift action_29
action_109 (53) = happyShift action_30
action_109 (14) = happyGoto action_22
action_109 (17) = happyGoto action_117
action_109 (18) = happyGoto action_26
action_109 (20) = happyGoto action_27
action_109 _ = happyFail

action_110 _ = happyReduce_44

action_111 _ = happyReduce_18

action_112 (32) = happyShift action_116
action_112 (34) = happyShift action_9
action_112 _ = happyFail

action_113 _ = happyReduce_14

action_114 (39) = happyShift action_115
action_114 _ = happyFail

action_115 (36) = happyShift action_119
action_115 _ = happyFail

action_116 (38) = happyShift action_39
action_116 (40) = happyShift action_40
action_116 (41) = happyShift action_41
action_116 (48) = happyShift action_42
action_116 (7) = happyGoto action_118
action_116 (8) = happyGoto action_38
action_116 _ = happyFail

action_117 _ = happyReduce_28

action_118 _ = happyReduce_19

action_119 (49) = happyShift action_120
action_119 _ = happyFail

action_120 (38) = happyShift action_39
action_120 (40) = happyShift action_40
action_120 (41) = happyShift action_41
action_120 (48) = happyShift action_42
action_120 (7) = happyGoto action_121
action_120 (8) = happyGoto action_38
action_120 _ = happyFail

action_121 _ = happyReduce_7

happyReduce_1 = happyReduce 10 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_9) `HappyStk`
	(HappyAbsSyn9  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Program happy_var_2 happy_var_4 happy_var_7 happy_var_8 happy_var_9
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  5 happyReduction_3
happyReduction_3 (HappyTerminal (TokID happy_var_3))
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_3 : happy_var_1
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_0  6 happyReduction_4
happyReduction_4  =  HappyAbsSyn6
		 ([]
	)

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Declaration happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (StdType happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 8 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokNum happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokNum happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ArrayType (happy_var_3, happy_var_5) happy_var_8
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (IntType
	)

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (RealType
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn8
		 (StringType
	)

happyReduce_11 = happySpecReduce_0  9 happyReduction_11
happyReduction_11  =  HappyAbsSyn9
		 ([]
	)

happyReduce_12 = happySpecReduce_3  9 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2 : happy_var_1
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 (HappyAbsSyn14  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (SubprogDec happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 6 11 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadFunc happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 11 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadProc happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_0  12 happyReduction_16
happyReduction_16  =  HappyAbsSyn12
		 (EmptyArguments
	)

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Arguments happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  13 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn13
		 ([Param happy_var_1 happy_var_3]
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happyReduce 5 13 happyReduction_19
happyReduction_19 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Param happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  14 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_0  15 happyReduction_21
happyReduction_21  =  HappyAbsSyn15
		 ([]
	)

happyReduce_22 = happySpecReduce_1  15 happyReduction_22
happyReduction_22 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 ([happy_var_1]
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  16 happyReduction_23
happyReduction_23 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  16 happyReduction_24
happyReduction_24 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_3 : happy_var_1
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  17 happyReduction_25
happyReduction_25 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (VarStmt happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  17 happyReduction_26
happyReduction_26 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn17
		 (ProcStmt happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn17
		 (CompStmt happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happyReduce 6 17 happyReduction_28
happyReduction_28 ((HappyAbsSyn17  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (BranchStmt happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 4 17 happyReduction_29
happyReduction_29 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (LoopStmt happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_30 = happySpecReduce_2  18 happyReduction_30
happyReduction_30 (HappyAbsSyn19  happy_var_2)
	(HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn18
		 (Variable happy_var_1 happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_0  19 happyReduction_31
happyReduction_31  =  HappyAbsSyn19
		 ([]
	)

happyReduce_32 = happyReduce 4 19 happyReduction_32
happyReduction_32 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (happy_var_2 : happy_var_4
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_1  20 happyReduction_33
happyReduction_33 (HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn20
		 (ProcedureStmtOnlyID happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happyReduce 4 20 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (ProcedureStmtWithExprs happy_var_3
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_1  21 happyReduction_35
happyReduction_35 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 ([happy_var_1]
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  21 happyReduction_36
happyReduction_36 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_3 : happy_var_1
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  22 happyReduction_37
happyReduction_37 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (UnaryExpr happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  22 happyReduction_38
happyReduction_38 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (BinaryExpr happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  23 happyReduction_39
happyReduction_39 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (SimpleExprTerm happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  23 happyReduction_40
happyReduction_40 (HappyAbsSyn24  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (SimpleExprOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  24 happyReduction_41
happyReduction_41 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (FactorTerm happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  24 happyReduction_42
happyReduction_42 (HappyAbsSyn25  happy_var_3)
	(HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  25 happyReduction_43
happyReduction_43 (HappyAbsSyn19  happy_var_2)
	(HappyTerminal (TokID happy_var_1))
	 =  HappyAbsSyn25
		 (IDSBFactor happy_var_1 happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 25 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (IDPFactor happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1  25 happyReduction_45
happyReduction_45 (HappyTerminal (TokNum happy_var_1))
	 =  HappyAbsSyn25
		 (NumFactor happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  25 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (PFactor happy_var_2
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  25 happyReduction_47
happyReduction_47 (HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (NotFactor happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  26 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn26
		 (Plus
	)

happyReduce_49 = happySpecReduce_1  26 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn26
		 (Minus
	)

happyReduce_50 = happySpecReduce_1  27 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn27
		 (Mul
	)

happyReduce_51 = happySpecReduce_1  27 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn27
		 (Div
	)

happyReduce_52 = happySpecReduce_1  28 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn28
		 (S
	)

happyReduce_53 = happySpecReduce_1  28 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn28
		 (L
	)

happyReduce_54 = happySpecReduce_1  28 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn28
		 (E
	)

happyReduce_55 = happySpecReduce_1  28 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn28
		 (SE
	)

happyReduce_56 = happySpecReduce_1  28 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn28
		 (LE
	)

happyReduce_57 = happySpecReduce_1  28 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn28
		 (NE
	)

happyNewToken action sts stk [] =
	action 68 68 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokLParen -> cont 29;
	TokRParen -> cont 30;
	TokSemicolon -> cont 31;
	TokColon -> cont 32;
	TokPeriod -> cont 33;
	TokComma -> cont 34;
	TokLSB -> cont 35;
	TokRSB -> cont 36;
	TokID happy_dollar_dollar -> cont 37;
	TokStr happy_dollar_dollar -> cont 38;
	TokNum happy_dollar_dollar -> cont 39;
	TokTypeInt -> cont 40;
	TokTypeReal -> cont 41;
	TokProgram -> cont 42;
	TokFunction -> cont 43;
	TokProc -> cont 44;
	TokBegin -> cont 45;
	TokEnd -> cont 46;
	TokVar -> cont 47;
	TokArr -> cont 48;
	TokOf -> cont 49;
	TokIf -> cont 50;
	TokThen -> cont 51;
	TokElse -> cont 52;
	TokWhile -> cont 53;
	TokDo -> cont 54;
	TokAssign -> cont 55;
	TokS -> cont 56;
	TokL -> cont 57;
	TokSE -> cont 58;
	TokLE -> cont 59;
	TokEq -> cont 60;
	TokNEq -> cont 61;
	TokPlus -> cont 62;
	TokMinus -> cont 63;
	TokTimes -> cont 64;
	TokDiv -> cont 65;
	TokNot -> cont 66;
	TokTo -> cont 67;
	_ -> happyError' (tk:tks)
	}

happyError_ 68 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure    = return
    a <*> b = (fmap id a) <*> b
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parse tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 


{-# LINE 13 "templates/GenericTemplate.hs" #-}


{-# LINE 46 "templates/GenericTemplate.hs" #-}









{-# LINE 67 "templates/GenericTemplate.hs" #-}


{-# LINE 77 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

