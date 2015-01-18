{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Type
import Compiler.Lexer
import Control.Monad.Except
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24
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

action_0 (38) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (38) = happyShift action_2
action_1 _ = happyFail

action_2 (33) = happyShift action_4
action_2 _ = happyFail

action_3 (64) = happyAccept
action_3 _ = happyFail

action_4 (25) = happyShift action_5
action_4 _ = happyFail

action_5 (33) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (26) = happyShift action_8
action_6 (30) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (27) = happyShift action_11
action_8 _ = happyFail

action_9 (33) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (43) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_11

action_13 (39) = happyShift action_18
action_13 (40) = happyShift action_19
action_13 (41) = happyShift action_20
action_13 (10) = happyGoto action_16
action_13 (12) = happyGoto action_17
action_13 _ = happyFail

action_14 (33) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (28) = happyShift action_32
action_15 (30) = happyShift action_9
action_15 _ = happyFail

action_16 (27) = happyShift action_31
action_16 _ = happyFail

action_17 (29) = happyShift action_30
action_17 _ = happyFail

action_18 (33) = happyShift action_29
action_18 _ = happyFail

action_19 (33) = happyShift action_28
action_19 _ = happyFail

action_20 (33) = happyShift action_25
action_20 (41) = happyShift action_20
action_20 (46) = happyShift action_26
action_20 (49) = happyShift action_27
action_20 (12) = happyGoto action_21
action_20 (13) = happyGoto action_22
action_20 (14) = happyGoto action_23
action_20 (15) = happyGoto action_24
action_20 _ = happyReduce_20

action_21 _ = happyReduce_26

action_22 (27) = happyShift action_57
action_22 (42) = happyShift action_58
action_22 _ = happyFail

action_23 _ = happyReduce_21

action_24 (51) = happyShift action_56
action_24 _ = happyFail

action_25 (25) = happyShift action_54
action_25 (31) = happyShift action_55
action_25 (51) = happyReduce_30
action_25 (16) = happyGoto action_53
action_25 _ = happyReduce_24

action_26 (25) = happyShift action_47
action_26 (33) = happyShift action_48
action_26 (34) = happyShift action_49
action_26 (59) = happyShift action_50
action_26 (62) = happyShift action_51
action_26 (18) = happyGoto action_52
action_26 (19) = happyGoto action_44
action_26 (20) = happyGoto action_45
action_26 (21) = happyGoto action_46
action_26 _ = happyFail

action_27 (25) = happyShift action_47
action_27 (33) = happyShift action_48
action_27 (34) = happyShift action_49
action_27 (59) = happyShift action_50
action_27 (62) = happyShift action_51
action_27 (18) = happyGoto action_43
action_27 (19) = happyGoto action_44
action_27 (20) = happyGoto action_45
action_27 (21) = happyGoto action_46
action_27 _ = happyFail

action_28 (25) = happyShift action_41
action_28 (27) = happyShift action_42
action_28 _ = happyFail

action_29 (25) = happyShift action_39
action_29 (28) = happyShift action_40
action_29 _ = happyFail

action_30 _ = happyReduce_1

action_31 _ = happyReduce_12

action_32 (35) = happyShift action_35
action_32 (36) = happyShift action_36
action_32 (37) = happyShift action_37
action_32 (44) = happyShift action_38
action_32 (7) = happyGoto action_33
action_32 (8) = happyGoto action_34
action_32 _ = happyFail

action_33 (27) = happyShift action_90
action_33 _ = happyFail

action_34 _ = happyReduce_6

action_35 _ = happyReduce_10

action_36 _ = happyReduce_8

action_37 _ = happyReduce_9

action_38 (31) = happyShift action_89
action_38 _ = happyFail

action_39 (33) = happyShift action_7
action_39 (5) = happyGoto action_85
action_39 (11) = happyGoto action_88
action_39 _ = happyFail

action_40 (35) = happyShift action_35
action_40 (36) = happyShift action_36
action_40 (37) = happyShift action_37
action_40 (8) = happyGoto action_87
action_40 _ = happyFail

action_41 (33) = happyShift action_7
action_41 (5) = happyGoto action_85
action_41 (11) = happyGoto action_86
action_41 _ = happyFail

action_42 (6) = happyGoto action_84
action_42 _ = happyReduce_4

action_43 (50) = happyShift action_83
action_43 _ = happyFail

action_44 (52) = happyShift action_75
action_44 (53) = happyShift action_76
action_44 (54) = happyShift action_77
action_44 (55) = happyShift action_78
action_44 (56) = happyShift action_79
action_44 (57) = happyShift action_80
action_44 (58) = happyShift action_81
action_44 (59) = happyShift action_82
action_44 (22) = happyGoto action_73
action_44 (24) = happyGoto action_74
action_44 _ = happyReduce_34

action_45 (60) = happyShift action_71
action_45 (61) = happyShift action_72
action_45 (23) = happyGoto action_70
action_45 _ = happyReduce_36

action_46 _ = happyReduce_38

action_47 (25) = happyShift action_47
action_47 (33) = happyShift action_48
action_47 (34) = happyShift action_49
action_47 (59) = happyShift action_50
action_47 (62) = happyShift action_51
action_47 (18) = happyGoto action_69
action_47 (19) = happyGoto action_44
action_47 (20) = happyGoto action_45
action_47 (21) = happyGoto action_46
action_47 _ = happyFail

action_48 (25) = happyShift action_68
action_48 (31) = happyShift action_55
action_48 (16) = happyGoto action_67
action_48 _ = happyReduce_30

action_49 _ = happyReduce_43

action_50 (25) = happyShift action_47
action_50 (33) = happyShift action_48
action_50 (34) = happyShift action_49
action_50 (62) = happyShift action_51
action_50 (21) = happyGoto action_66
action_50 _ = happyFail

action_51 (25) = happyShift action_47
action_51 (33) = happyShift action_48
action_51 (34) = happyShift action_49
action_51 (62) = happyShift action_51
action_51 (21) = happyGoto action_65
action_51 _ = happyFail

action_52 (47) = happyShift action_64
action_52 _ = happyFail

action_53 _ = happyReduce_29

action_54 (25) = happyShift action_47
action_54 (33) = happyShift action_48
action_54 (34) = happyShift action_49
action_54 (59) = happyShift action_50
action_54 (62) = happyShift action_51
action_54 (17) = happyGoto action_62
action_54 (18) = happyGoto action_63
action_54 (19) = happyGoto action_44
action_54 (20) = happyGoto action_45
action_54 (21) = happyGoto action_46
action_54 _ = happyFail

action_55 (25) = happyShift action_47
action_55 (33) = happyShift action_48
action_55 (34) = happyShift action_49
action_55 (59) = happyShift action_50
action_55 (62) = happyShift action_51
action_55 (18) = happyGoto action_61
action_55 (19) = happyGoto action_44
action_55 (20) = happyGoto action_45
action_55 (21) = happyGoto action_46
action_55 _ = happyFail

action_56 (25) = happyShift action_47
action_56 (33) = happyShift action_48
action_56 (34) = happyShift action_49
action_56 (59) = happyShift action_50
action_56 (62) = happyShift action_51
action_56 (18) = happyGoto action_60
action_56 (19) = happyGoto action_44
action_56 (20) = happyGoto action_45
action_56 (21) = happyGoto action_46
action_56 _ = happyFail

action_57 (33) = happyShift action_25
action_57 (41) = happyShift action_20
action_57 (46) = happyShift action_26
action_57 (49) = happyShift action_27
action_57 (12) = happyGoto action_21
action_57 (14) = happyGoto action_59
action_57 (15) = happyGoto action_24
action_57 _ = happyFail

action_58 _ = happyReduce_19

action_59 _ = happyReduce_22

action_60 _ = happyReduce_23

action_61 (32) = happyShift action_107
action_61 _ = happyFail

action_62 (26) = happyShift action_105
action_62 (30) = happyShift action_106
action_62 _ = happyFail

action_63 _ = happyReduce_32

action_64 (33) = happyShift action_25
action_64 (41) = happyShift action_20
action_64 (46) = happyShift action_26
action_64 (49) = happyShift action_27
action_64 (12) = happyGoto action_21
action_64 (14) = happyGoto action_104
action_64 (15) = happyGoto action_24
action_64 _ = happyFail

action_65 _ = happyReduce_45

action_66 _ = happyReduce_39

action_67 _ = happyReduce_41

action_68 (25) = happyShift action_47
action_68 (33) = happyShift action_48
action_68 (34) = happyShift action_49
action_68 (59) = happyShift action_50
action_68 (62) = happyShift action_51
action_68 (17) = happyGoto action_103
action_68 (18) = happyGoto action_63
action_68 (19) = happyGoto action_44
action_68 (20) = happyGoto action_45
action_68 (21) = happyGoto action_46
action_68 _ = happyFail

action_69 (26) = happyShift action_102
action_69 _ = happyFail

action_70 (25) = happyShift action_47
action_70 (33) = happyShift action_48
action_70 (34) = happyShift action_49
action_70 (62) = happyShift action_51
action_70 (21) = happyGoto action_101
action_70 _ = happyFail

action_71 _ = happyReduce_48

action_72 _ = happyReduce_49

action_73 (25) = happyShift action_47
action_73 (33) = happyShift action_48
action_73 (34) = happyShift action_49
action_73 (59) = happyShift action_50
action_73 (62) = happyShift action_51
action_73 (20) = happyGoto action_100
action_73 (21) = happyGoto action_46
action_73 _ = happyFail

action_74 (25) = happyShift action_47
action_74 (33) = happyShift action_48
action_74 (34) = happyShift action_49
action_74 (59) = happyShift action_50
action_74 (62) = happyShift action_51
action_74 (19) = happyGoto action_99
action_74 (20) = happyGoto action_45
action_74 (21) = happyGoto action_46
action_74 _ = happyFail

action_75 _ = happyReduce_50

action_76 _ = happyReduce_51

action_77 _ = happyReduce_53

action_78 _ = happyReduce_54

action_79 _ = happyReduce_52

action_80 _ = happyReduce_55

action_81 _ = happyReduce_46

action_82 _ = happyReduce_47

action_83 (33) = happyShift action_25
action_83 (41) = happyShift action_20
action_83 (46) = happyShift action_26
action_83 (49) = happyShift action_27
action_83 (12) = happyGoto action_21
action_83 (14) = happyGoto action_98
action_83 (15) = happyGoto action_24
action_83 _ = happyFail

action_84 (41) = happyShift action_20
action_84 (43) = happyShift action_14
action_84 (12) = happyGoto action_97
action_84 _ = happyFail

action_85 (28) = happyShift action_96
action_85 (30) = happyShift action_9
action_85 _ = happyFail

action_86 (26) = happyShift action_95
action_86 (27) = happyShift action_93
action_86 _ = happyFail

action_87 (27) = happyShift action_94
action_87 _ = happyFail

action_88 (26) = happyShift action_92
action_88 (27) = happyShift action_93
action_88 _ = happyFail

action_89 (34) = happyShift action_91
action_89 _ = happyFail

action_90 _ = happyReduce_5

action_91 (63) = happyShift action_117
action_91 _ = happyFail

action_92 (28) = happyShift action_116
action_92 _ = happyFail

action_93 (33) = happyShift action_7
action_93 (5) = happyGoto action_115
action_93 _ = happyFail

action_94 (6) = happyGoto action_114
action_94 _ = happyReduce_4

action_95 (27) = happyShift action_113
action_95 _ = happyFail

action_96 (35) = happyShift action_35
action_96 (36) = happyShift action_36
action_96 (37) = happyShift action_37
action_96 (44) = happyShift action_38
action_96 (7) = happyGoto action_112
action_96 (8) = happyGoto action_34
action_96 _ = happyFail

action_97 _ = happyReduce_15

action_98 _ = happyReduce_28

action_99 (58) = happyShift action_81
action_99 (59) = happyShift action_82
action_99 (22) = happyGoto action_73
action_99 _ = happyReduce_35

action_100 (60) = happyShift action_71
action_100 (61) = happyShift action_72
action_100 (23) = happyGoto action_70
action_100 _ = happyReduce_37

action_101 _ = happyReduce_40

action_102 _ = happyReduce_44

action_103 (26) = happyShift action_111
action_103 (30) = happyShift action_106
action_103 _ = happyFail

action_104 (48) = happyShift action_110
action_104 _ = happyFail

action_105 _ = happyReduce_25

action_106 (25) = happyShift action_47
action_106 (33) = happyShift action_48
action_106 (34) = happyShift action_49
action_106 (59) = happyShift action_50
action_106 (62) = happyShift action_51
action_106 (18) = happyGoto action_109
action_106 (19) = happyGoto action_44
action_106 (20) = happyGoto action_45
action_106 (21) = happyGoto action_46
action_106 _ = happyFail

action_107 (31) = happyShift action_55
action_107 (16) = happyGoto action_108
action_107 _ = happyReduce_30

action_108 _ = happyReduce_31

action_109 _ = happyReduce_33

action_110 (33) = happyShift action_25
action_110 (41) = happyShift action_20
action_110 (46) = happyShift action_26
action_110 (49) = happyShift action_27
action_110 (12) = happyGoto action_21
action_110 (14) = happyGoto action_123
action_110 (15) = happyGoto action_24
action_110 _ = happyFail

action_111 _ = happyReduce_42

action_112 _ = happyReduce_17

action_113 (6) = happyGoto action_122
action_113 _ = happyReduce_4

action_114 (41) = happyShift action_20
action_114 (43) = happyShift action_14
action_114 (12) = happyGoto action_121
action_114 _ = happyFail

action_115 (28) = happyShift action_120
action_115 (30) = happyShift action_9
action_115 _ = happyFail

action_116 (35) = happyShift action_35
action_116 (36) = happyShift action_36
action_116 (37) = happyShift action_37
action_116 (8) = happyGoto action_119
action_116 _ = happyFail

action_117 (34) = happyShift action_118
action_117 _ = happyFail

action_118 (32) = happyShift action_127
action_118 _ = happyFail

action_119 (27) = happyShift action_126
action_119 _ = happyFail

action_120 (35) = happyShift action_35
action_120 (36) = happyShift action_36
action_120 (37) = happyShift action_37
action_120 (44) = happyShift action_38
action_120 (7) = happyGoto action_125
action_120 (8) = happyGoto action_34
action_120 _ = happyFail

action_121 _ = happyReduce_13

action_122 (41) = happyShift action_20
action_122 (43) = happyShift action_14
action_122 (12) = happyGoto action_124
action_122 _ = happyFail

action_123 _ = happyReduce_27

action_124 _ = happyReduce_16

action_125 _ = happyReduce_18

action_126 (6) = happyGoto action_129
action_126 _ = happyReduce_4

action_127 (45) = happyShift action_128
action_127 _ = happyFail

action_128 (35) = happyShift action_35
action_128 (36) = happyShift action_36
action_128 (37) = happyShift action_37
action_128 (44) = happyShift action_38
action_128 (7) = happyGoto action_131
action_128 (8) = happyGoto action_34
action_128 _ = happyFail

action_129 (41) = happyShift action_20
action_129 (43) = happyShift action_14
action_129 (12) = happyGoto action_130
action_129 _ = happyFail

action_130 _ = happyReduce_14

action_131 _ = happyReduce_7

happyReduce_1 = happyReduce 10 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_9) `HappyStk`
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

happyReduce_13 = happyReduce 7 10 happyReduction_13
happyReduction_13 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (FuncDecNode (toSym happy_var_2) [] happy_var_4 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 10 10 happyReduction_14
happyReduction_14 ((HappyAbsSyn12  happy_var_10) `HappyStk`
	(HappyAbsSyn6  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (FuncDecNode (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 5 10 happyReduction_15
happyReduction_15 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDecNode (toSym happy_var_2) [] happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 8 10 happyReduction_16
happyReduction_16 ((HappyAbsSyn12  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDecNode (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_8
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_3  11 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (ParameterNode happy_var_1 happy_var_3 : []
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happyReduce 5 11 happyReduction_18
happyReduction_18 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (ParameterNode happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_19 = happySpecReduce_3  12 happyReduction_19
happyReduction_19 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (reverse happy_var_2
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_0  13 happyReduction_20
happyReduction_20  =  HappyAbsSyn13
		 ([]
	)

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_3 : happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  14 happyReduction_23
happyReduction_23 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (AssignStmtNode happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 (SubprogInvokeStmtNode (toSym happy_var_1) []
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happyReduce 4 14 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (SubprogInvokeStmtNode (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (CompStmtNode happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happyReduce 6 14 happyReduction_27
happyReduction_27 ((HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (BranchStmtNode happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 14 happyReduction_28
happyReduction_28 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (LoopStmtNode happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_2  15 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 (VariableNode (toSym happy_var_1) happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  16 happyReduction_30
happyReduction_30  =  HappyAbsSyn16
		 ([]
	)

happyReduce_31 = happyReduce 4 16 happyReduction_31
happyReduction_31 ((HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (happy_var_2 : happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 : []
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  17 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_3 : happy_var_1
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  18 happyReduction_34
happyReduction_34 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (UnaryExprNode happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  18 happyReduction_35
happyReduction_35 (HappyAbsSyn19  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (BinaryExprNode happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  19 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (SimpleExprTermNode happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  19 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_3)
	(HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (SimpleExprOpNode happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  20 happyReduction_38
happyReduction_38 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (FactorTermNode happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  20 happyReduction_39
happyReduction_39 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (NegTermNode happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  20 happyReduction_40
happyReduction_40 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (OpTermNode happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  21 happyReduction_41
happyReduction_41 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (ArrayAccessFactorNode (toSym happy_var_1) happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 4 21 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (SubprogInvokeFactorNode (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  21 happyReduction_43
happyReduction_43 (HappyTerminal (Token (TokNum happy_var_1) _))
	 =  HappyAbsSyn21
		 (NumFactorNode happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  21 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (SubFactorNode happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  21 happyReduction_45
happyReduction_45 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (NotFactorNode happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  22 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn22
		 (Plus
	)

happyReduce_47 = happySpecReduce_1  22 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn22
		 (Minus
	)

happyReduce_48 = happySpecReduce_1  23 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn23
		 (Mul
	)

happyReduce_49 = happySpecReduce_1  23 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn23
		 (Div
	)

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn24
		 (S
	)

happyReduce_51 = happySpecReduce_1  24 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn24
		 (L
	)

happyReduce_52 = happySpecReduce_1  24 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn24
		 (E
	)

happyReduce_53 = happySpecReduce_1  24 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn24
		 (SE
	)

happyReduce_54 = happySpecReduce_1  24 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn24
		 (LE
	)

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn24
		 (NE
	)

happyNewToken action sts stk [] =
	action 64 64 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token TokLParen _ -> cont 25;
	Token TokRParen _ -> cont 26;
	Token TokSemicolon _ -> cont 27;
	Token TokColon _ -> cont 28;
	Token TokPeriod _ -> cont 29;
	Token TokComma _ -> cont 30;
	Token TokLSB _ -> cont 31;
	Token TokRSB _ -> cont 32;
	Token (TokID _) _ -> cont 33;
	Token (TokNum happy_dollar_dollar) _ -> cont 34;
	Token TokTypeStr _ -> cont 35;
	Token TokTypeInt _ -> cont 36;
	Token TokTypeReal _ -> cont 37;
	Token TokProgram _ -> cont 38;
	Token TokFunction _ -> cont 39;
	Token TokProc _ -> cont 40;
	Token TokBegin _ -> cont 41;
	Token TokEnd _ -> cont 42;
	Token TokVar _ -> cont 43;
	Token TokArr _ -> cont 44;
	Token TokOf _ -> cont 45;
	Token TokIf _ -> cont 46;
	Token TokThen _ -> cont 47;
	Token TokElse _ -> cont 48;
	Token TokWhile _ -> cont 49;
	Token TokDo _ -> cont 50;
	Token TokAssign _ -> cont 51;
	Token TokS _ -> cont 52;
	Token TokL _ -> cont 53;
	Token TokSE _ -> cont 54;
	Token TokLE _ -> cont 55;
	Token TokEq _ -> cont 56;
	Token TokNEq _ -> cont 57;
	Token TokPlus _ -> cont 58;
	Token TokMinus _ -> cont 59;
	Token TokTimes _ -> cont 60;
	Token TokDiv _ -> cont 61;
	Token TokNot _ -> cont 62;
	Token TokTo _ -> cont 63;
	_ -> happyError' (tk:tks)
	}

happyError_ 64 tk tks = happyError' tks
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

