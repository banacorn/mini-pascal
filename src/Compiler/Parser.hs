{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Type
import Compiler.Lexer
import Control.Monad.Except
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27
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

action_0 (41) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (41) = happyShift action_2
action_1 _ = happyFail

action_2 (36) = happyShift action_4
action_2 _ = happyFail

action_3 (67) = happyAccept
action_3 _ = happyFail

action_4 (28) = happyShift action_5
action_4 _ = happyFail

action_5 (36) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (29) = happyShift action_8
action_6 (33) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (30) = happyShift action_11
action_8 _ = happyFail

action_9 (36) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (46) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_11

action_13 (42) = happyShift action_19
action_13 (43) = happyShift action_20
action_13 (44) = happyShift action_21
action_13 (10) = happyGoto action_16
action_13 (11) = happyGoto action_17
action_13 (14) = happyGoto action_18
action_13 _ = happyFail

action_14 (36) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (31) = happyShift action_35
action_15 (33) = happyShift action_9
action_15 _ = happyFail

action_16 (30) = happyShift action_34
action_16 _ = happyFail

action_17 (6) = happyGoto action_33
action_17 _ = happyReduce_4

action_18 (32) = happyShift action_32
action_18 _ = happyFail

action_19 (36) = happyShift action_31
action_19 _ = happyFail

action_20 (36) = happyShift action_30
action_20 _ = happyFail

action_21 (36) = happyShift action_27
action_21 (44) = happyShift action_21
action_21 (49) = happyShift action_28
action_21 (52) = happyShift action_29
action_21 (14) = happyGoto action_22
action_21 (15) = happyGoto action_23
action_21 (16) = happyGoto action_24
action_21 (17) = happyGoto action_25
action_21 (19) = happyGoto action_26
action_21 _ = happyReduce_21

action_22 _ = happyReduce_26

action_23 (30) = happyShift action_60
action_23 (45) = happyShift action_61
action_23 _ = happyFail

action_24 _ = happyReduce_22

action_25 (54) = happyShift action_59
action_25 _ = happyFail

action_26 _ = happyReduce_25

action_27 (28) = happyShift action_57
action_27 (34) = happyShift action_58
action_27 (54) = happyReduce_30
action_27 (18) = happyGoto action_56
action_27 _ = happyReduce_32

action_28 (28) = happyShift action_50
action_28 (36) = happyShift action_51
action_28 (37) = happyShift action_52
action_28 (62) = happyShift action_53
action_28 (65) = happyShift action_54
action_28 (21) = happyGoto action_55
action_28 (22) = happyGoto action_47
action_28 (23) = happyGoto action_48
action_28 (24) = happyGoto action_49
action_28 _ = happyFail

action_29 (28) = happyShift action_50
action_29 (36) = happyShift action_51
action_29 (37) = happyShift action_52
action_29 (62) = happyShift action_53
action_29 (65) = happyShift action_54
action_29 (21) = happyGoto action_46
action_29 (22) = happyGoto action_47
action_29 (23) = happyGoto action_48
action_29 (24) = happyGoto action_49
action_29 _ = happyFail

action_30 (28) = happyShift action_44
action_30 (12) = happyGoto action_45
action_30 _ = happyReduce_16

action_31 (28) = happyShift action_44
action_31 (12) = happyGoto action_43
action_31 _ = happyReduce_16

action_32 _ = happyReduce_1

action_33 (44) = happyShift action_21
action_33 (46) = happyShift action_14
action_33 (14) = happyGoto action_42
action_33 _ = happyFail

action_34 _ = happyReduce_12

action_35 (38) = happyShift action_38
action_35 (39) = happyShift action_39
action_35 (40) = happyShift action_40
action_35 (47) = happyShift action_41
action_35 (7) = happyGoto action_36
action_35 (8) = happyGoto action_37
action_35 _ = happyFail

action_36 (30) = happyShift action_92
action_36 _ = happyFail

action_37 _ = happyReduce_6

action_38 _ = happyReduce_10

action_39 _ = happyReduce_8

action_40 _ = happyReduce_9

action_41 (34) = happyShift action_91
action_41 _ = happyFail

action_42 _ = happyReduce_13

action_43 (31) = happyShift action_90
action_43 _ = happyFail

action_44 (36) = happyShift action_7
action_44 (5) = happyGoto action_88
action_44 (13) = happyGoto action_89
action_44 _ = happyFail

action_45 (30) = happyShift action_87
action_45 _ = happyFail

action_46 (53) = happyShift action_86
action_46 _ = happyFail

action_47 (55) = happyShift action_78
action_47 (56) = happyShift action_79
action_47 (57) = happyShift action_80
action_47 (58) = happyShift action_81
action_47 (59) = happyShift action_82
action_47 (60) = happyShift action_83
action_47 (61) = happyShift action_84
action_47 (62) = happyShift action_85
action_47 (25) = happyGoto action_76
action_47 (27) = happyGoto action_77
action_47 _ = happyReduce_36

action_48 (63) = happyShift action_74
action_48 (64) = happyShift action_75
action_48 (26) = happyGoto action_73
action_48 _ = happyReduce_38

action_49 _ = happyReduce_40

action_50 (28) = happyShift action_50
action_50 (36) = happyShift action_51
action_50 (37) = happyShift action_52
action_50 (62) = happyShift action_53
action_50 (65) = happyShift action_54
action_50 (21) = happyGoto action_72
action_50 (22) = happyGoto action_47
action_50 (23) = happyGoto action_48
action_50 (24) = happyGoto action_49
action_50 _ = happyFail

action_51 (28) = happyShift action_71
action_51 (34) = happyShift action_58
action_51 (18) = happyGoto action_70
action_51 _ = happyReduce_30

action_52 _ = happyReduce_45

action_53 (28) = happyShift action_50
action_53 (36) = happyShift action_51
action_53 (37) = happyShift action_52
action_53 (65) = happyShift action_54
action_53 (24) = happyGoto action_69
action_53 _ = happyFail

action_54 (28) = happyShift action_50
action_54 (36) = happyShift action_51
action_54 (37) = happyShift action_52
action_54 (65) = happyShift action_54
action_54 (24) = happyGoto action_68
action_54 _ = happyFail

action_55 (50) = happyShift action_67
action_55 _ = happyFail

action_56 _ = happyReduce_29

action_57 (28) = happyShift action_50
action_57 (36) = happyShift action_51
action_57 (37) = happyShift action_52
action_57 (62) = happyShift action_53
action_57 (65) = happyShift action_54
action_57 (20) = happyGoto action_65
action_57 (21) = happyGoto action_66
action_57 (22) = happyGoto action_47
action_57 (23) = happyGoto action_48
action_57 (24) = happyGoto action_49
action_57 _ = happyFail

action_58 (28) = happyShift action_50
action_58 (36) = happyShift action_51
action_58 (37) = happyShift action_52
action_58 (62) = happyShift action_53
action_58 (65) = happyShift action_54
action_58 (21) = happyGoto action_64
action_58 (22) = happyGoto action_47
action_58 (23) = happyGoto action_48
action_58 (24) = happyGoto action_49
action_58 _ = happyFail

action_59 (28) = happyShift action_50
action_59 (36) = happyShift action_51
action_59 (37) = happyShift action_52
action_59 (62) = happyShift action_53
action_59 (65) = happyShift action_54
action_59 (21) = happyGoto action_63
action_59 (22) = happyGoto action_47
action_59 (23) = happyGoto action_48
action_59 (24) = happyGoto action_49
action_59 _ = happyFail

action_60 (36) = happyShift action_27
action_60 (44) = happyShift action_21
action_60 (49) = happyShift action_28
action_60 (52) = happyShift action_29
action_60 (14) = happyGoto action_22
action_60 (16) = happyGoto action_62
action_60 (17) = happyGoto action_25
action_60 (19) = happyGoto action_26
action_60 _ = happyFail

action_61 _ = happyReduce_20

action_62 _ = happyReduce_23

action_63 _ = happyReduce_24

action_64 (35) = happyShift action_107
action_64 _ = happyFail

action_65 (29) = happyShift action_105
action_65 (33) = happyShift action_106
action_65 _ = happyFail

action_66 _ = happyReduce_34

action_67 (36) = happyShift action_27
action_67 (44) = happyShift action_21
action_67 (49) = happyShift action_28
action_67 (52) = happyShift action_29
action_67 (14) = happyGoto action_22
action_67 (16) = happyGoto action_104
action_67 (17) = happyGoto action_25
action_67 (19) = happyGoto action_26
action_67 _ = happyFail

action_68 _ = happyReduce_47

action_69 _ = happyReduce_41

action_70 _ = happyReduce_43

action_71 (28) = happyShift action_50
action_71 (36) = happyShift action_51
action_71 (37) = happyShift action_52
action_71 (62) = happyShift action_53
action_71 (65) = happyShift action_54
action_71 (20) = happyGoto action_103
action_71 (21) = happyGoto action_66
action_71 (22) = happyGoto action_47
action_71 (23) = happyGoto action_48
action_71 (24) = happyGoto action_49
action_71 _ = happyFail

action_72 (29) = happyShift action_102
action_72 _ = happyFail

action_73 (28) = happyShift action_50
action_73 (36) = happyShift action_51
action_73 (37) = happyShift action_52
action_73 (65) = happyShift action_54
action_73 (24) = happyGoto action_101
action_73 _ = happyFail

action_74 _ = happyReduce_50

action_75 _ = happyReduce_51

action_76 (28) = happyShift action_50
action_76 (36) = happyShift action_51
action_76 (37) = happyShift action_52
action_76 (62) = happyShift action_53
action_76 (65) = happyShift action_54
action_76 (23) = happyGoto action_100
action_76 (24) = happyGoto action_49
action_76 _ = happyFail

action_77 (28) = happyShift action_50
action_77 (36) = happyShift action_51
action_77 (37) = happyShift action_52
action_77 (62) = happyShift action_53
action_77 (65) = happyShift action_54
action_77 (22) = happyGoto action_99
action_77 (23) = happyGoto action_48
action_77 (24) = happyGoto action_49
action_77 _ = happyFail

action_78 _ = happyReduce_52

action_79 _ = happyReduce_53

action_80 _ = happyReduce_55

action_81 _ = happyReduce_56

action_82 _ = happyReduce_54

action_83 _ = happyReduce_57

action_84 _ = happyReduce_48

action_85 _ = happyReduce_49

action_86 (36) = happyShift action_27
action_86 (44) = happyShift action_21
action_86 (49) = happyShift action_28
action_86 (52) = happyShift action_29
action_86 (14) = happyGoto action_22
action_86 (16) = happyGoto action_98
action_86 (17) = happyGoto action_25
action_86 (19) = happyGoto action_26
action_86 _ = happyFail

action_87 _ = happyReduce_15

action_88 (31) = happyShift action_97
action_88 (33) = happyShift action_9
action_88 _ = happyFail

action_89 (29) = happyShift action_95
action_89 (30) = happyShift action_96
action_89 _ = happyFail

action_90 (38) = happyShift action_38
action_90 (39) = happyShift action_39
action_90 (40) = happyShift action_40
action_90 (8) = happyGoto action_94
action_90 _ = happyFail

action_91 (37) = happyShift action_93
action_91 _ = happyFail

action_92 _ = happyReduce_5

action_93 (66) = happyShift action_115
action_93 _ = happyFail

action_94 (30) = happyShift action_114
action_94 _ = happyFail

action_95 _ = happyReduce_17

action_96 (36) = happyShift action_7
action_96 (5) = happyGoto action_113
action_96 _ = happyFail

action_97 (38) = happyShift action_38
action_97 (39) = happyShift action_39
action_97 (40) = happyShift action_40
action_97 (47) = happyShift action_41
action_97 (7) = happyGoto action_112
action_97 (8) = happyGoto action_37
action_97 _ = happyFail

action_98 _ = happyReduce_28

action_99 (61) = happyShift action_84
action_99 (62) = happyShift action_85
action_99 (25) = happyGoto action_76
action_99 _ = happyReduce_37

action_100 (63) = happyShift action_74
action_100 (64) = happyShift action_75
action_100 (26) = happyGoto action_73
action_100 _ = happyReduce_39

action_101 _ = happyReduce_42

action_102 _ = happyReduce_46

action_103 (29) = happyShift action_111
action_103 (33) = happyShift action_106
action_103 _ = happyFail

action_104 (51) = happyShift action_110
action_104 _ = happyFail

action_105 _ = happyReduce_33

action_106 (28) = happyShift action_50
action_106 (36) = happyShift action_51
action_106 (37) = happyShift action_52
action_106 (62) = happyShift action_53
action_106 (65) = happyShift action_54
action_106 (21) = happyGoto action_109
action_106 (22) = happyGoto action_47
action_106 (23) = happyGoto action_48
action_106 (24) = happyGoto action_49
action_106 _ = happyFail

action_107 (34) = happyShift action_58
action_107 (18) = happyGoto action_108
action_107 _ = happyReduce_30

action_108 _ = happyReduce_31

action_109 _ = happyReduce_35

action_110 (36) = happyShift action_27
action_110 (44) = happyShift action_21
action_110 (49) = happyShift action_28
action_110 (52) = happyShift action_29
action_110 (14) = happyGoto action_22
action_110 (16) = happyGoto action_118
action_110 (17) = happyGoto action_25
action_110 (19) = happyGoto action_26
action_110 _ = happyFail

action_111 _ = happyReduce_44

action_112 _ = happyReduce_18

action_113 (31) = happyShift action_117
action_113 (33) = happyShift action_9
action_113 _ = happyFail

action_114 _ = happyReduce_14

action_115 (37) = happyShift action_116
action_115 _ = happyFail

action_116 (35) = happyShift action_120
action_116 _ = happyFail

action_117 (38) = happyShift action_38
action_117 (39) = happyShift action_39
action_117 (40) = happyShift action_40
action_117 (47) = happyShift action_41
action_117 (7) = happyGoto action_119
action_117 (8) = happyGoto action_37
action_117 _ = happyFail

action_118 _ = happyReduce_27

action_119 _ = happyReduce_19

action_120 (48) = happyShift action_121
action_120 _ = happyFail

action_121 (38) = happyShift action_38
action_121 (39) = happyShift action_39
action_121 (40) = happyShift action_40
action_121 (47) = happyShift action_41
action_121 (7) = happyGoto action_122
action_121 (8) = happyGoto action_37
action_121 _ = happyFail

action_122 _ = happyReduce_7

happyReduce_1 = happyReduce 10 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_9) `HappyStk`
	(HappyAbsSyn9  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokID happy_var_2) _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ParseTree (Program happy_var_2 (reverse happy_var_4) (reverse happy_var_7) (reverse happy_var_8) happy_var_9)
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (Token (TokID happy_var_1) _))
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  5 happyReduction_3
happyReduction_3 (HappyTerminal (Token (TokID happy_var_3) _))
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
		 (Declaration (reverse happy_var_3) happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (StdTypeN happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 8 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokNum happy_var_5) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokNum happy_var_3) _)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ArrayTypeN (happy_var_3, happy_var_5) happy_var_8
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (IntTypeN
	)

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (RealTypeN
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn8
		 (StringTypeN
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
	(HappyTerminal (Token (TokID happy_var_2) _)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadFunc happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 11 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (Token (TokID happy_var_2) _)) `HappyStk`
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
		 (CompoundStmt (reverse happy_var_2)
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

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_3 : happy_var_1
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  16 happyReduction_24
happyReduction_24 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (VarStmt happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  16 happyReduction_25
happyReduction_25 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn16
		 (ProcStmt happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  16 happyReduction_26
happyReduction_26 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn16
		 (CompStmt happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happyReduce 6 16 happyReduction_27
happyReduction_27 ((HappyAbsSyn16  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (BranchStmt happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 16 happyReduction_28
happyReduction_28 ((HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (LoopStmt happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_2  17 happyReduction_29
happyReduction_29 (HappyAbsSyn18  happy_var_2)
	(HappyTerminal (Token (TokID happy_var_1) _))
	 =  HappyAbsSyn17
		 (Variable happy_var_1 happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  18 happyReduction_30
happyReduction_30  =  HappyAbsSyn18
		 ([]
	)

happyReduce_31 = happyReduce 4 18 happyReduction_31
happyReduction_31 ((HappyAbsSyn18  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (happy_var_2 : happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_1  19 happyReduction_32
happyReduction_32 (HappyTerminal (Token (TokID happy_var_1) _))
	 =  HappyAbsSyn19
		 (ProcedureStmtOnlyID happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 19 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (ProcedureStmtWithExprs happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_1  20 happyReduction_34
happyReduction_34 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 ([happy_var_1]
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  20 happyReduction_35
happyReduction_35 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_3 : happy_var_1
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  21 happyReduction_36
happyReduction_36 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 (UnaryExpr happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  21 happyReduction_37
happyReduction_37 (HappyAbsSyn22  happy_var_3)
	(HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 (BinaryExpr happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  22 happyReduction_38
happyReduction_38 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (SimpleExprTerm happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  22 happyReduction_39
happyReduction_39 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (SimpleExprOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  23 happyReduction_40
happyReduction_40 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (FactorTerm happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  23 happyReduction_41
happyReduction_41 (HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (NegTerm happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  23 happyReduction_42
happyReduction_42 (HappyAbsSyn24  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  24 happyReduction_43
happyReduction_43 (HappyAbsSyn18  happy_var_2)
	(HappyTerminal (Token (TokID happy_var_1) _))
	 =  HappyAbsSyn24
		 (IDSBFactor happy_var_1 happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 24 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokID happy_var_1) _)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (IDPFactor happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1  24 happyReduction_45
happyReduction_45 (HappyTerminal (Token (TokNum happy_var_1) _))
	 =  HappyAbsSyn24
		 (NumFactor happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  24 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (PFactor happy_var_2
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  24 happyReduction_47
happyReduction_47 (HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (NotFactor happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  25 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn25
		 (Plus
	)

happyReduce_49 = happySpecReduce_1  25 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn25
		 (Minus
	)

happyReduce_50 = happySpecReduce_1  26 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn26
		 (Mul
	)

happyReduce_51 = happySpecReduce_1  26 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn26
		 (Div
	)

happyReduce_52 = happySpecReduce_1  27 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn27
		 (S
	)

happyReduce_53 = happySpecReduce_1  27 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn27
		 (L
	)

happyReduce_54 = happySpecReduce_1  27 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn27
		 (E
	)

happyReduce_55 = happySpecReduce_1  27 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn27
		 (SE
	)

happyReduce_56 = happySpecReduce_1  27 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn27
		 (LE
	)

happyReduce_57 = happySpecReduce_1  27 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn27
		 (NE
	)

happyNewToken action sts stk [] =
	action 67 67 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token TokLParen _ -> cont 28;
	Token TokRParen _ -> cont 29;
	Token TokSemicolon _ -> cont 30;
	Token TokColon _ -> cont 31;
	Token TokPeriod _ -> cont 32;
	Token TokComma _ -> cont 33;
	Token TokLSB _ -> cont 34;
	Token TokRSB _ -> cont 35;
	Token (TokID happy_dollar_dollar) _ -> cont 36;
	Token (TokNum happy_dollar_dollar) _ -> cont 37;
	Token TokTypeStr _ -> cont 38;
	Token TokTypeInt _ -> cont 39;
	Token TokTypeReal _ -> cont 40;
	Token TokProgram _ -> cont 41;
	Token TokFunction _ -> cont 42;
	Token TokProc _ -> cont 43;
	Token TokBegin _ -> cont 44;
	Token TokEnd _ -> cont 45;
	Token TokVar _ -> cont 46;
	Token TokArr _ -> cont 47;
	Token TokOf _ -> cont 48;
	Token TokIf _ -> cont 49;
	Token TokThen _ -> cont 50;
	Token TokElse _ -> cont 51;
	Token TokWhile _ -> cont 52;
	Token TokDo _ -> cont 53;
	Token TokAssign _ -> cont 54;
	Token TokS _ -> cont 55;
	Token TokL _ -> cont 56;
	Token TokSE _ -> cont 57;
	Token TokLE _ -> cont 58;
	Token TokEq _ -> cont 59;
	Token TokNEq _ -> cont 60;
	Token TokPlus _ -> cont 61;
	Token TokMinus _ -> cont 62;
	Token TokTimes _ -> cont 63;
	Token TokDiv _ -> cont 64;
	Token TokNot _ -> cont 65;
	Token TokTo _ -> cont 66;
	_ -> happyError' (tk:tks)
	}

happyError_ 67 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Pipeline a -> (a -> Pipeline b) -> Pipeline b
happyThen = (>>=)
happyReturn :: () => a -> Pipeline a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Pipeline a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> Pipeline a
happyError' = parseError

parse tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Pipeline a
parseError tokens = throwError (ParseError (head tokens))
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

