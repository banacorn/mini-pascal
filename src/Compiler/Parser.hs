{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Type
import Compiler.Lexer
import Control.Monad.Except
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26
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

action_0 (40) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (40) = happyShift action_2
action_1 _ = happyFail

action_2 (35) = happyShift action_4
action_2 _ = happyFail

action_3 (66) = happyAccept
action_3 _ = happyFail

action_4 (27) = happyShift action_5
action_4 _ = happyFail

action_5 (35) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (28) = happyShift action_8
action_6 (32) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (29) = happyShift action_11
action_8 _ = happyFail

action_9 (35) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (45) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_11

action_13 (41) = happyShift action_19
action_13 (42) = happyShift action_20
action_13 (43) = happyShift action_21
action_13 (10) = happyGoto action_16
action_13 (11) = happyGoto action_17
action_13 (13) = happyGoto action_18
action_13 _ = happyFail

action_14 (35) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (30) = happyShift action_35
action_15 (32) = happyShift action_9
action_15 _ = happyFail

action_16 (29) = happyShift action_34
action_16 _ = happyFail

action_17 (6) = happyGoto action_33
action_17 _ = happyReduce_4

action_18 (31) = happyShift action_32
action_18 _ = happyFail

action_19 (35) = happyShift action_31
action_19 _ = happyFail

action_20 (35) = happyShift action_30
action_20 _ = happyFail

action_21 (35) = happyShift action_27
action_21 (43) = happyShift action_21
action_21 (48) = happyShift action_28
action_21 (51) = happyShift action_29
action_21 (13) = happyGoto action_22
action_21 (14) = happyGoto action_23
action_21 (15) = happyGoto action_24
action_21 (16) = happyGoto action_25
action_21 (18) = happyGoto action_26
action_21 _ = happyReduce_21

action_22 _ = happyReduce_26

action_23 (29) = happyShift action_61
action_23 (44) = happyShift action_62
action_23 _ = happyFail

action_24 _ = happyReduce_22

action_25 (53) = happyShift action_60
action_25 _ = happyFail

action_26 _ = happyReduce_25

action_27 (27) = happyShift action_58
action_27 (33) = happyShift action_59
action_27 (53) = happyReduce_30
action_27 (17) = happyGoto action_57
action_27 _ = happyReduce_32

action_28 (27) = happyShift action_51
action_28 (35) = happyShift action_52
action_28 (36) = happyShift action_53
action_28 (61) = happyShift action_54
action_28 (64) = happyShift action_55
action_28 (20) = happyGoto action_56
action_28 (21) = happyGoto action_48
action_28 (22) = happyGoto action_49
action_28 (23) = happyGoto action_50
action_28 _ = happyFail

action_29 (27) = happyShift action_51
action_29 (35) = happyShift action_52
action_29 (36) = happyShift action_53
action_29 (61) = happyShift action_54
action_29 (64) = happyShift action_55
action_29 (20) = happyGoto action_47
action_29 (21) = happyGoto action_48
action_29 (22) = happyGoto action_49
action_29 (23) = happyGoto action_50
action_29 _ = happyFail

action_30 (27) = happyShift action_45
action_30 (29) = happyShift action_46
action_30 _ = happyFail

action_31 (27) = happyShift action_43
action_31 (30) = happyShift action_44
action_31 _ = happyFail

action_32 _ = happyReduce_1

action_33 (43) = happyShift action_21
action_33 (45) = happyShift action_14
action_33 (13) = happyGoto action_42
action_33 _ = happyFail

action_34 _ = happyReduce_12

action_35 (37) = happyShift action_38
action_35 (38) = happyShift action_39
action_35 (39) = happyShift action_40
action_35 (46) = happyShift action_41
action_35 (7) = happyGoto action_36
action_35 (8) = happyGoto action_37
action_35 _ = happyFail

action_36 (29) = happyShift action_93
action_36 _ = happyFail

action_37 _ = happyReduce_6

action_38 _ = happyReduce_10

action_39 _ = happyReduce_8

action_40 _ = happyReduce_9

action_41 (33) = happyShift action_92
action_41 _ = happyFail

action_42 _ = happyReduce_13

action_43 (35) = happyShift action_7
action_43 (5) = happyGoto action_88
action_43 (12) = happyGoto action_91
action_43 _ = happyFail

action_44 (37) = happyShift action_38
action_44 (38) = happyShift action_39
action_44 (39) = happyShift action_40
action_44 (8) = happyGoto action_90
action_44 _ = happyFail

action_45 (35) = happyShift action_7
action_45 (5) = happyGoto action_88
action_45 (12) = happyGoto action_89
action_45 _ = happyFail

action_46 _ = happyReduce_16

action_47 (52) = happyShift action_87
action_47 _ = happyFail

action_48 (54) = happyShift action_79
action_48 (55) = happyShift action_80
action_48 (56) = happyShift action_81
action_48 (57) = happyShift action_82
action_48 (58) = happyShift action_83
action_48 (59) = happyShift action_84
action_48 (60) = happyShift action_85
action_48 (61) = happyShift action_86
action_48 (24) = happyGoto action_77
action_48 (26) = happyGoto action_78
action_48 _ = happyReduce_36

action_49 (62) = happyShift action_75
action_49 (63) = happyShift action_76
action_49 (25) = happyGoto action_74
action_49 _ = happyReduce_38

action_50 _ = happyReduce_40

action_51 (27) = happyShift action_51
action_51 (35) = happyShift action_52
action_51 (36) = happyShift action_53
action_51 (61) = happyShift action_54
action_51 (64) = happyShift action_55
action_51 (20) = happyGoto action_73
action_51 (21) = happyGoto action_48
action_51 (22) = happyGoto action_49
action_51 (23) = happyGoto action_50
action_51 _ = happyFail

action_52 (27) = happyShift action_72
action_52 (33) = happyShift action_59
action_52 (17) = happyGoto action_71
action_52 _ = happyReduce_30

action_53 _ = happyReduce_45

action_54 (27) = happyShift action_51
action_54 (35) = happyShift action_52
action_54 (36) = happyShift action_53
action_54 (64) = happyShift action_55
action_54 (23) = happyGoto action_70
action_54 _ = happyFail

action_55 (27) = happyShift action_51
action_55 (35) = happyShift action_52
action_55 (36) = happyShift action_53
action_55 (64) = happyShift action_55
action_55 (23) = happyGoto action_69
action_55 _ = happyFail

action_56 (49) = happyShift action_68
action_56 _ = happyFail

action_57 _ = happyReduce_29

action_58 (27) = happyShift action_51
action_58 (35) = happyShift action_52
action_58 (36) = happyShift action_53
action_58 (61) = happyShift action_54
action_58 (64) = happyShift action_55
action_58 (19) = happyGoto action_66
action_58 (20) = happyGoto action_67
action_58 (21) = happyGoto action_48
action_58 (22) = happyGoto action_49
action_58 (23) = happyGoto action_50
action_58 _ = happyFail

action_59 (27) = happyShift action_51
action_59 (35) = happyShift action_52
action_59 (36) = happyShift action_53
action_59 (61) = happyShift action_54
action_59 (64) = happyShift action_55
action_59 (20) = happyGoto action_65
action_59 (21) = happyGoto action_48
action_59 (22) = happyGoto action_49
action_59 (23) = happyGoto action_50
action_59 _ = happyFail

action_60 (27) = happyShift action_51
action_60 (35) = happyShift action_52
action_60 (36) = happyShift action_53
action_60 (61) = happyShift action_54
action_60 (64) = happyShift action_55
action_60 (20) = happyGoto action_64
action_60 (21) = happyGoto action_48
action_60 (22) = happyGoto action_49
action_60 (23) = happyGoto action_50
action_60 _ = happyFail

action_61 (35) = happyShift action_27
action_61 (43) = happyShift action_21
action_61 (48) = happyShift action_28
action_61 (51) = happyShift action_29
action_61 (13) = happyGoto action_22
action_61 (15) = happyGoto action_63
action_61 (16) = happyGoto action_25
action_61 (18) = happyGoto action_26
action_61 _ = happyFail

action_62 _ = happyReduce_20

action_63 _ = happyReduce_23

action_64 _ = happyReduce_24

action_65 (34) = happyShift action_109
action_65 _ = happyFail

action_66 (28) = happyShift action_107
action_66 (32) = happyShift action_108
action_66 _ = happyFail

action_67 _ = happyReduce_34

action_68 (35) = happyShift action_27
action_68 (43) = happyShift action_21
action_68 (48) = happyShift action_28
action_68 (51) = happyShift action_29
action_68 (13) = happyGoto action_22
action_68 (15) = happyGoto action_106
action_68 (16) = happyGoto action_25
action_68 (18) = happyGoto action_26
action_68 _ = happyFail

action_69 _ = happyReduce_47

action_70 _ = happyReduce_41

action_71 _ = happyReduce_43

action_72 (27) = happyShift action_51
action_72 (35) = happyShift action_52
action_72 (36) = happyShift action_53
action_72 (61) = happyShift action_54
action_72 (64) = happyShift action_55
action_72 (19) = happyGoto action_105
action_72 (20) = happyGoto action_67
action_72 (21) = happyGoto action_48
action_72 (22) = happyGoto action_49
action_72 (23) = happyGoto action_50
action_72 _ = happyFail

action_73 (28) = happyShift action_104
action_73 _ = happyFail

action_74 (27) = happyShift action_51
action_74 (35) = happyShift action_52
action_74 (36) = happyShift action_53
action_74 (64) = happyShift action_55
action_74 (23) = happyGoto action_103
action_74 _ = happyFail

action_75 _ = happyReduce_50

action_76 _ = happyReduce_51

action_77 (27) = happyShift action_51
action_77 (35) = happyShift action_52
action_77 (36) = happyShift action_53
action_77 (61) = happyShift action_54
action_77 (64) = happyShift action_55
action_77 (22) = happyGoto action_102
action_77 (23) = happyGoto action_50
action_77 _ = happyFail

action_78 (27) = happyShift action_51
action_78 (35) = happyShift action_52
action_78 (36) = happyShift action_53
action_78 (61) = happyShift action_54
action_78 (64) = happyShift action_55
action_78 (21) = happyGoto action_101
action_78 (22) = happyGoto action_49
action_78 (23) = happyGoto action_50
action_78 _ = happyFail

action_79 _ = happyReduce_52

action_80 _ = happyReduce_53

action_81 _ = happyReduce_55

action_82 _ = happyReduce_56

action_83 _ = happyReduce_54

action_84 _ = happyReduce_57

action_85 _ = happyReduce_48

action_86 _ = happyReduce_49

action_87 (35) = happyShift action_27
action_87 (43) = happyShift action_21
action_87 (48) = happyShift action_28
action_87 (51) = happyShift action_29
action_87 (13) = happyGoto action_22
action_87 (15) = happyGoto action_100
action_87 (16) = happyGoto action_25
action_87 (18) = happyGoto action_26
action_87 _ = happyFail

action_88 (30) = happyShift action_99
action_88 (32) = happyShift action_9
action_88 _ = happyFail

action_89 (28) = happyShift action_98
action_89 (29) = happyShift action_96
action_89 _ = happyFail

action_90 (29) = happyShift action_97
action_90 _ = happyFail

action_91 (28) = happyShift action_95
action_91 (29) = happyShift action_96
action_91 _ = happyFail

action_92 (36) = happyShift action_94
action_92 _ = happyFail

action_93 _ = happyReduce_5

action_94 (65) = happyShift action_118
action_94 _ = happyFail

action_95 (30) = happyShift action_117
action_95 _ = happyFail

action_96 (35) = happyShift action_7
action_96 (5) = happyGoto action_116
action_96 _ = happyFail

action_97 _ = happyReduce_14

action_98 (29) = happyShift action_115
action_98 _ = happyFail

action_99 (37) = happyShift action_38
action_99 (38) = happyShift action_39
action_99 (39) = happyShift action_40
action_99 (46) = happyShift action_41
action_99 (7) = happyGoto action_114
action_99 (8) = happyGoto action_37
action_99 _ = happyFail

action_100 _ = happyReduce_28

action_101 (60) = happyShift action_85
action_101 (61) = happyShift action_86
action_101 (24) = happyGoto action_77
action_101 _ = happyReduce_37

action_102 (62) = happyShift action_75
action_102 (63) = happyShift action_76
action_102 (25) = happyGoto action_74
action_102 _ = happyReduce_39

action_103 _ = happyReduce_42

action_104 _ = happyReduce_46

action_105 (28) = happyShift action_113
action_105 (32) = happyShift action_108
action_105 _ = happyFail

action_106 (50) = happyShift action_112
action_106 _ = happyFail

action_107 _ = happyReduce_33

action_108 (27) = happyShift action_51
action_108 (35) = happyShift action_52
action_108 (36) = happyShift action_53
action_108 (61) = happyShift action_54
action_108 (64) = happyShift action_55
action_108 (20) = happyGoto action_111
action_108 (21) = happyGoto action_48
action_108 (22) = happyGoto action_49
action_108 (23) = happyGoto action_50
action_108 _ = happyFail

action_109 (33) = happyShift action_59
action_109 (17) = happyGoto action_110
action_109 _ = happyReduce_30

action_110 _ = happyReduce_31

action_111 _ = happyReduce_35

action_112 (35) = happyShift action_27
action_112 (43) = happyShift action_21
action_112 (48) = happyShift action_28
action_112 (51) = happyShift action_29
action_112 (13) = happyGoto action_22
action_112 (15) = happyGoto action_122
action_112 (16) = happyGoto action_25
action_112 (18) = happyGoto action_26
action_112 _ = happyFail

action_113 _ = happyReduce_44

action_114 _ = happyReduce_18

action_115 _ = happyReduce_17

action_116 (30) = happyShift action_121
action_116 (32) = happyShift action_9
action_116 _ = happyFail

action_117 (37) = happyShift action_38
action_117 (38) = happyShift action_39
action_117 (39) = happyShift action_40
action_117 (8) = happyGoto action_120
action_117 _ = happyFail

action_118 (36) = happyShift action_119
action_118 _ = happyFail

action_119 (34) = happyShift action_125
action_119 _ = happyFail

action_120 (29) = happyShift action_124
action_120 _ = happyFail

action_121 (37) = happyShift action_38
action_121 (38) = happyShift action_39
action_121 (39) = happyShift action_40
action_121 (46) = happyShift action_41
action_121 (7) = happyGoto action_123
action_121 (8) = happyGoto action_37
action_121 _ = happyFail

action_122 _ = happyReduce_27

action_123 _ = happyReduce_19

action_124 _ = happyReduce_15

action_125 (47) = happyShift action_126
action_125 _ = happyFail

action_126 (37) = happyShift action_38
action_126 (38) = happyShift action_39
action_126 (39) = happyShift action_40
action_126 (46) = happyShift action_41
action_126 (7) = happyGoto action_127
action_126 (8) = happyGoto action_37
action_126 _ = happyFail

action_127 _ = happyReduce_7

happyReduce_1 = happyReduce 10 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_9) `HappyStk`
	(HappyAbsSyn9  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ProgramNode (toSym happy_var_2) (reverse happy_var_4) (reverse happy_var_7) (reverse happy_var_8) happy_var_9
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn5
		 (toSym happy_var_1 : []
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  5 happyReduction_3
happyReduction_3 (HappyTerminal happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (toSym happy_var_3 : happy_var_1
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
		 (VarDecNode (reverse happy_var_3) happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (BaseTypeNode happy_var_1
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
		 (ArrayTypeNode (happy_var_3, happy_var_5) happy_var_8
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (IntTypeNode
	)

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (RealTypeNode
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn8
		 (StringTypeNode
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
happyReduction_13 (HappyAbsSyn13  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (SubprogDec happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 11 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadFunc (toSym happy_var_2) [] happy_var_4
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 8 11 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadFunc (toSym happy_var_2) happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_3  11 happyReduction_16
happyReduction_16 _
	(HappyTerminal happy_var_2)
	_
	 =  HappyAbsSyn11
		 (SubprogHeadProc (toSym happy_var_2) []
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 6 11 happyReduction_17
happyReduction_17 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (SubprogHeadProc (toSym happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_3  12 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn12
		 (ParameterNode happy_var_1 happy_var_3 : []
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happyReduce 5 12 happyReduction_19
happyReduction_19 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ParameterNode happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  13 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (CompoundStmt (reverse happy_var_2)
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_0  14 happyReduction_21
happyReduction_21  =  HappyAbsSyn14
		 ([]
	)

happyReduce_22 = happySpecReduce_1  14 happyReduction_22
happyReduction_22 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  14 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_3 : happy_var_1
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  15 happyReduction_24
happyReduction_24 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (VarStmtNode happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (ProcStmtNode happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  15 happyReduction_26
happyReduction_26 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (CompStmtNode happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happyReduce 6 15 happyReduction_27
happyReduction_27 ((HappyAbsSyn15  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (BranchStmtNode happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 15 happyReduction_28
happyReduction_28 ((HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (LoopStmtNode happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_2  16 happyReduction_29
happyReduction_29 (HappyAbsSyn17  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn16
		 (Variable (toSym happy_var_1) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  17 happyReduction_30
happyReduction_30  =  HappyAbsSyn17
		 ([]
	)

happyReduce_31 = happyReduce 4 17 happyReduction_31
happyReduction_31 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (happy_var_2 : happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_1  18 happyReduction_32
happyReduction_32 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (ProcedureStmtOnlyID (toSym happy_var_1)
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 18 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (ProcedureStmtWithExprs (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_1  19 happyReduction_34
happyReduction_34 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 : []
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  19 happyReduction_35
happyReduction_35 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_3 : happy_var_1
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  20 happyReduction_36
happyReduction_36 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (UnaryExpr happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn26  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (BinaryExpr happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  21 happyReduction_38
happyReduction_38 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 (SimpleExprTerm happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  21 happyReduction_39
happyReduction_39 (HappyAbsSyn22  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (SimpleExprOp happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  22 happyReduction_40
happyReduction_40 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (FactorTerm happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  22 happyReduction_41
happyReduction_41 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn22
		 (NegTerm happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  22 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  23 happyReduction_43
happyReduction_43 (HappyAbsSyn17  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn23
		 (IDSBFactor (toSym happy_var_1) happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 23 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (IDPFactor (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_1  23 happyReduction_45
happyReduction_45 (HappyTerminal (Token (TokNum happy_var_1) _))
	 =  HappyAbsSyn23
		 (NumFactor happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  23 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (PFactor happy_var_2
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  23 happyReduction_47
happyReduction_47 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (NotFactor happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  24 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn24
		 (Plus
	)

happyReduce_49 = happySpecReduce_1  24 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn24
		 (Minus
	)

happyReduce_50 = happySpecReduce_1  25 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn25
		 (Mul
	)

happyReduce_51 = happySpecReduce_1  25 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn25
		 (Div
	)

happyReduce_52 = happySpecReduce_1  26 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn26
		 (S
	)

happyReduce_53 = happySpecReduce_1  26 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn26
		 (L
	)

happyReduce_54 = happySpecReduce_1  26 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn26
		 (E
	)

happyReduce_55 = happySpecReduce_1  26 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn26
		 (SE
	)

happyReduce_56 = happySpecReduce_1  26 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn26
		 (LE
	)

happyReduce_57 = happySpecReduce_1  26 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn26
		 (NE
	)

happyNewToken action sts stk [] =
	action 66 66 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token TokLParen _ -> cont 27;
	Token TokRParen _ -> cont 28;
	Token TokSemicolon _ -> cont 29;
	Token TokColon _ -> cont 30;
	Token TokPeriod _ -> cont 31;
	Token TokComma _ -> cont 32;
	Token TokLSB _ -> cont 33;
	Token TokRSB _ -> cont 34;
	Token (TokID _) _ -> cont 35;
	Token (TokNum happy_dollar_dollar) _ -> cont 36;
	Token TokTypeStr _ -> cont 37;
	Token TokTypeInt _ -> cont 38;
	Token TokTypeReal _ -> cont 39;
	Token TokProgram _ -> cont 40;
	Token TokFunction _ -> cont 41;
	Token TokProc _ -> cont 42;
	Token TokBegin _ -> cont 43;
	Token TokEnd _ -> cont 44;
	Token TokVar _ -> cont 45;
	Token TokArr _ -> cont 46;
	Token TokOf _ -> cont 47;
	Token TokIf _ -> cont 48;
	Token TokThen _ -> cont 49;
	Token TokElse _ -> cont 50;
	Token TokWhile _ -> cont 51;
	Token TokDo _ -> cont 52;
	Token TokAssign _ -> cont 53;
	Token TokS _ -> cont 54;
	Token TokL _ -> cont 55;
	Token TokSE _ -> cont 56;
	Token TokLE _ -> cont 57;
	Token TokEq _ -> cont 58;
	Token TokNEq _ -> cont 59;
	Token TokPlus _ -> cont 60;
	Token TokMinus _ -> cont 61;
	Token TokTimes _ -> cont 62;
	Token TokDiv _ -> cont 63;
	Token TokNot _ -> cont 64;
	Token TokTo _ -> cont 65;
	_ -> happyError' (tk:tks)
	}

happyError_ 66 tk tks = happyError' tks
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
parseError tokens = throwError (ParseError (maybeHead tokens))
    where   maybeHead [] = Nothing
            maybeHead (x:_) = Just x
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

