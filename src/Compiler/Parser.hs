{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Type.Token
import Compiler.Type.Pipeline
import Compiler.Type.AST
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

action_0 (40) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (40) = happyShift action_2
action_1 _ = happyFail

action_2 (33) = happyShift action_4
action_2 _ = happyFail

action_3 (66) = happyAccept
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

action_12 (45) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_11

action_13 (41) = happyShift action_18
action_13 (42) = happyShift action_19
action_13 (43) = happyShift action_20
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
action_20 (43) = happyShift action_20
action_20 (48) = happyShift action_26
action_20 (51) = happyShift action_27
action_20 (12) = happyGoto action_21
action_20 (13) = happyGoto action_22
action_20 (14) = happyGoto action_23
action_20 (15) = happyGoto action_24
action_20 _ = happyReduce_20

action_21 _ = happyReduce_26

action_22 (27) = happyShift action_58
action_22 (44) = happyShift action_59
action_22 _ = happyFail

action_23 _ = happyReduce_21

action_24 (53) = happyShift action_57
action_24 _ = happyFail

action_25 (25) = happyShift action_55
action_25 (31) = happyShift action_56
action_25 (53) = happyReduce_30
action_25 (16) = happyGoto action_54
action_25 _ = happyReduce_24

action_26 (25) = happyShift action_47
action_26 (33) = happyShift action_48
action_26 (35) = happyShift action_49
action_26 (36) = happyShift action_50
action_26 (61) = happyShift action_51
action_26 (64) = happyShift action_52
action_26 (18) = happyGoto action_53
action_26 (19) = happyGoto action_44
action_26 (20) = happyGoto action_45
action_26 (21) = happyGoto action_46
action_26 _ = happyFail

action_27 (25) = happyShift action_47
action_27 (33) = happyShift action_48
action_27 (35) = happyShift action_49
action_27 (36) = happyShift action_50
action_27 (61) = happyShift action_51
action_27 (64) = happyShift action_52
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

action_32 (37) = happyShift action_35
action_32 (38) = happyShift action_36
action_32 (39) = happyShift action_37
action_32 (46) = happyShift action_38
action_32 (7) = happyGoto action_33
action_32 (8) = happyGoto action_34
action_32 _ = happyFail

action_33 (27) = happyShift action_91
action_33 _ = happyFail

action_34 _ = happyReduce_6

action_35 _ = happyReduce_10

action_36 _ = happyReduce_8

action_37 _ = happyReduce_9

action_38 (31) = happyShift action_90
action_38 _ = happyFail

action_39 (33) = happyShift action_7
action_39 (5) = happyGoto action_86
action_39 (11) = happyGoto action_89
action_39 _ = happyFail

action_40 (37) = happyShift action_35
action_40 (38) = happyShift action_36
action_40 (39) = happyShift action_37
action_40 (8) = happyGoto action_88
action_40 _ = happyFail

action_41 (33) = happyShift action_7
action_41 (5) = happyGoto action_86
action_41 (11) = happyGoto action_87
action_41 _ = happyFail

action_42 (6) = happyGoto action_85
action_42 _ = happyReduce_4

action_43 (52) = happyShift action_84
action_43 _ = happyFail

action_44 (54) = happyShift action_76
action_44 (55) = happyShift action_77
action_44 (56) = happyShift action_78
action_44 (57) = happyShift action_79
action_44 (58) = happyShift action_80
action_44 (59) = happyShift action_81
action_44 (60) = happyShift action_82
action_44 (61) = happyShift action_83
action_44 (22) = happyGoto action_74
action_44 (24) = happyGoto action_75
action_44 _ = happyReduce_34

action_45 (62) = happyShift action_72
action_45 (63) = happyShift action_73
action_45 (23) = happyGoto action_71
action_45 _ = happyReduce_36

action_46 _ = happyReduce_38

action_47 (25) = happyShift action_47
action_47 (33) = happyShift action_48
action_47 (35) = happyShift action_49
action_47 (36) = happyShift action_50
action_47 (61) = happyShift action_51
action_47 (64) = happyShift action_52
action_47 (18) = happyGoto action_70
action_47 (19) = happyGoto action_44
action_47 (20) = happyGoto action_45
action_47 (21) = happyGoto action_46
action_47 _ = happyFail

action_48 (25) = happyShift action_69
action_48 (31) = happyShift action_56
action_48 (16) = happyGoto action_68
action_48 _ = happyReduce_30

action_49 _ = happyReduce_43

action_50 _ = happyReduce_44

action_51 (25) = happyShift action_47
action_51 (33) = happyShift action_48
action_51 (35) = happyShift action_49
action_51 (36) = happyShift action_50
action_51 (64) = happyShift action_52
action_51 (21) = happyGoto action_67
action_51 _ = happyFail

action_52 (25) = happyShift action_47
action_52 (33) = happyShift action_48
action_52 (35) = happyShift action_49
action_52 (36) = happyShift action_50
action_52 (64) = happyShift action_52
action_52 (21) = happyGoto action_66
action_52 _ = happyFail

action_53 (49) = happyShift action_65
action_53 _ = happyFail

action_54 _ = happyReduce_29

action_55 (25) = happyShift action_47
action_55 (33) = happyShift action_48
action_55 (35) = happyShift action_49
action_55 (36) = happyShift action_50
action_55 (61) = happyShift action_51
action_55 (64) = happyShift action_52
action_55 (17) = happyGoto action_63
action_55 (18) = happyGoto action_64
action_55 (19) = happyGoto action_44
action_55 (20) = happyGoto action_45
action_55 (21) = happyGoto action_46
action_55 _ = happyFail

action_56 (25) = happyShift action_47
action_56 (33) = happyShift action_48
action_56 (35) = happyShift action_49
action_56 (36) = happyShift action_50
action_56 (61) = happyShift action_51
action_56 (64) = happyShift action_52
action_56 (18) = happyGoto action_62
action_56 (19) = happyGoto action_44
action_56 (20) = happyGoto action_45
action_56 (21) = happyGoto action_46
action_56 _ = happyFail

action_57 (25) = happyShift action_47
action_57 (33) = happyShift action_48
action_57 (35) = happyShift action_49
action_57 (36) = happyShift action_50
action_57 (61) = happyShift action_51
action_57 (64) = happyShift action_52
action_57 (18) = happyGoto action_61
action_57 (19) = happyGoto action_44
action_57 (20) = happyGoto action_45
action_57 (21) = happyGoto action_46
action_57 _ = happyFail

action_58 (33) = happyShift action_25
action_58 (43) = happyShift action_20
action_58 (48) = happyShift action_26
action_58 (51) = happyShift action_27
action_58 (12) = happyGoto action_21
action_58 (14) = happyGoto action_60
action_58 (15) = happyGoto action_24
action_58 _ = happyFail

action_59 _ = happyReduce_19

action_60 _ = happyReduce_22

action_61 _ = happyReduce_23

action_62 (32) = happyShift action_108
action_62 _ = happyFail

action_63 (26) = happyShift action_106
action_63 (30) = happyShift action_107
action_63 _ = happyFail

action_64 _ = happyReduce_32

action_65 (33) = happyShift action_25
action_65 (43) = happyShift action_20
action_65 (48) = happyShift action_26
action_65 (51) = happyShift action_27
action_65 (12) = happyGoto action_21
action_65 (14) = happyGoto action_105
action_65 (15) = happyGoto action_24
action_65 _ = happyFail

action_66 _ = happyReduce_46

action_67 _ = happyReduce_39

action_68 _ = happyReduce_41

action_69 (25) = happyShift action_47
action_69 (33) = happyShift action_48
action_69 (35) = happyShift action_49
action_69 (36) = happyShift action_50
action_69 (61) = happyShift action_51
action_69 (64) = happyShift action_52
action_69 (17) = happyGoto action_104
action_69 (18) = happyGoto action_64
action_69 (19) = happyGoto action_44
action_69 (20) = happyGoto action_45
action_69 (21) = happyGoto action_46
action_69 _ = happyFail

action_70 (26) = happyShift action_103
action_70 _ = happyFail

action_71 (25) = happyShift action_47
action_71 (33) = happyShift action_48
action_71 (35) = happyShift action_49
action_71 (36) = happyShift action_50
action_71 (64) = happyShift action_52
action_71 (21) = happyGoto action_102
action_71 _ = happyFail

action_72 _ = happyReduce_49

action_73 _ = happyReduce_50

action_74 (25) = happyShift action_47
action_74 (33) = happyShift action_48
action_74 (35) = happyShift action_49
action_74 (36) = happyShift action_50
action_74 (61) = happyShift action_51
action_74 (64) = happyShift action_52
action_74 (20) = happyGoto action_101
action_74 (21) = happyGoto action_46
action_74 _ = happyFail

action_75 (25) = happyShift action_47
action_75 (33) = happyShift action_48
action_75 (35) = happyShift action_49
action_75 (36) = happyShift action_50
action_75 (61) = happyShift action_51
action_75 (64) = happyShift action_52
action_75 (19) = happyGoto action_100
action_75 (20) = happyGoto action_45
action_75 (21) = happyGoto action_46
action_75 _ = happyFail

action_76 _ = happyReduce_51

action_77 _ = happyReduce_52

action_78 _ = happyReduce_54

action_79 _ = happyReduce_55

action_80 _ = happyReduce_53

action_81 _ = happyReduce_56

action_82 _ = happyReduce_47

action_83 _ = happyReduce_48

action_84 (33) = happyShift action_25
action_84 (43) = happyShift action_20
action_84 (48) = happyShift action_26
action_84 (51) = happyShift action_27
action_84 (12) = happyGoto action_21
action_84 (14) = happyGoto action_99
action_84 (15) = happyGoto action_24
action_84 _ = happyFail

action_85 (43) = happyShift action_20
action_85 (45) = happyShift action_14
action_85 (12) = happyGoto action_98
action_85 _ = happyFail

action_86 (28) = happyShift action_97
action_86 (30) = happyShift action_9
action_86 _ = happyFail

action_87 (26) = happyShift action_96
action_87 (27) = happyShift action_94
action_87 _ = happyFail

action_88 (27) = happyShift action_95
action_88 _ = happyFail

action_89 (26) = happyShift action_93
action_89 (27) = happyShift action_94
action_89 _ = happyFail

action_90 (35) = happyShift action_92
action_90 _ = happyFail

action_91 _ = happyReduce_5

action_92 (65) = happyShift action_118
action_92 _ = happyFail

action_93 (28) = happyShift action_117
action_93 _ = happyFail

action_94 (33) = happyShift action_7
action_94 (5) = happyGoto action_116
action_94 _ = happyFail

action_95 (6) = happyGoto action_115
action_95 _ = happyReduce_4

action_96 (27) = happyShift action_114
action_96 _ = happyFail

action_97 (37) = happyShift action_35
action_97 (38) = happyShift action_36
action_97 (39) = happyShift action_37
action_97 (46) = happyShift action_38
action_97 (7) = happyGoto action_113
action_97 (8) = happyGoto action_34
action_97 _ = happyFail

action_98 _ = happyReduce_15

action_99 _ = happyReduce_28

action_100 (60) = happyShift action_82
action_100 (61) = happyShift action_83
action_100 (22) = happyGoto action_74
action_100 _ = happyReduce_35

action_101 (62) = happyShift action_72
action_101 (63) = happyShift action_73
action_101 (23) = happyGoto action_71
action_101 _ = happyReduce_37

action_102 _ = happyReduce_40

action_103 _ = happyReduce_45

action_104 (26) = happyShift action_112
action_104 (30) = happyShift action_107
action_104 _ = happyFail

action_105 (50) = happyShift action_111
action_105 _ = happyFail

action_106 _ = happyReduce_25

action_107 (25) = happyShift action_47
action_107 (33) = happyShift action_48
action_107 (35) = happyShift action_49
action_107 (36) = happyShift action_50
action_107 (61) = happyShift action_51
action_107 (64) = happyShift action_52
action_107 (18) = happyGoto action_110
action_107 (19) = happyGoto action_44
action_107 (20) = happyGoto action_45
action_107 (21) = happyGoto action_46
action_107 _ = happyFail

action_108 (31) = happyShift action_56
action_108 (16) = happyGoto action_109
action_108 _ = happyReduce_30

action_109 _ = happyReduce_31

action_110 _ = happyReduce_33

action_111 (33) = happyShift action_25
action_111 (43) = happyShift action_20
action_111 (48) = happyShift action_26
action_111 (51) = happyShift action_27
action_111 (12) = happyGoto action_21
action_111 (14) = happyGoto action_124
action_111 (15) = happyGoto action_24
action_111 _ = happyFail

action_112 _ = happyReduce_42

action_113 _ = happyReduce_17

action_114 (6) = happyGoto action_123
action_114 _ = happyReduce_4

action_115 (43) = happyShift action_20
action_115 (45) = happyShift action_14
action_115 (12) = happyGoto action_122
action_115 _ = happyFail

action_116 (28) = happyShift action_121
action_116 (30) = happyShift action_9
action_116 _ = happyFail

action_117 (37) = happyShift action_35
action_117 (38) = happyShift action_36
action_117 (39) = happyShift action_37
action_117 (8) = happyGoto action_120
action_117 _ = happyFail

action_118 (35) = happyShift action_119
action_118 _ = happyFail

action_119 (32) = happyShift action_128
action_119 _ = happyFail

action_120 (27) = happyShift action_127
action_120 _ = happyFail

action_121 (37) = happyShift action_35
action_121 (38) = happyShift action_36
action_121 (39) = happyShift action_37
action_121 (46) = happyShift action_38
action_121 (7) = happyGoto action_126
action_121 (8) = happyGoto action_34
action_121 _ = happyFail

action_122 _ = happyReduce_13

action_123 (43) = happyShift action_20
action_123 (45) = happyShift action_14
action_123 (12) = happyGoto action_125
action_123 _ = happyFail

action_124 _ = happyReduce_27

action_125 _ = happyReduce_16

action_126 _ = happyReduce_18

action_127 (6) = happyGoto action_130
action_127 _ = happyReduce_4

action_128 (47) = happyShift action_129
action_128 _ = happyFail

action_129 (37) = happyShift action_35
action_129 (38) = happyShift action_36
action_129 (39) = happyShift action_37
action_129 (46) = happyShift action_38
action_129 (7) = happyGoto action_132
action_129 (8) = happyGoto action_34
action_129 _ = happyFail

action_130 (43) = happyShift action_20
action_130 (45) = happyShift action_14
action_130 (12) = happyGoto action_131
action_130 _ = happyFail

action_131 _ = happyReduce_14

action_132 _ = happyReduce_7

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
		 (Program (toSym happy_var_2) (reverse happy_var_4) (reverse happy_var_7) (reverse happy_var_8) (CompoundStmt happy_var_9)
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
		 (VarDec (reverse happy_var_3) happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (BaseType happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 8 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokInt happy_var_5) _)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token (TokInt happy_var_3) _)) `HappyStk`
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
		 (FuncDec (toSym happy_var_2) [] happy_var_4 happy_var_6 (CompoundStmt happy_var_7)
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
		 (FuncDec (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_9 (CompoundStmt happy_var_10)
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 5 10 happyReduction_15
happyReduction_15 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDec (toSym happy_var_2) [] happy_var_4 (CompoundStmt happy_var_5)
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
		 (ProcDec (toSym happy_var_2) happy_var_4 happy_var_7 (CompoundStmt happy_var_8)
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_3  11 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (Parameter happy_var_1 happy_var_3 : []
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
		 (Parameter happy_var_3 happy_var_5 : happy_var_1
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
		 (Assignment happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 (Invocation (toSym happy_var_1) []
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happyReduce 4 14 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Invocation (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (Compound (CompoundStmt happy_var_1)
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
		 (Branch happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 4 14 happyReduction_28
happyReduction_28 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Loop happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_2  15 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn15
		 (Assignee (toSym happy_var_1) happy_var_2
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
		 (UnaryExpression happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  18 happyReduction_35
happyReduction_35 (HappyAbsSyn19  happy_var_3)
	(HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (BinaryExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  19 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (TermSimpleExpression happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  19 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_3)
	(HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (OpSimpleExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  20 happyReduction_38
happyReduction_38 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (FactorTerm happy_var_1
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  20 happyReduction_39
happyReduction_39 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (NegTerm happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  20 happyReduction_40
happyReduction_40 (HappyAbsSyn21  happy_var_3)
	(HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  21 happyReduction_41
happyReduction_41 (HappyAbsSyn16  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (ArrayAccessFactor (toSym happy_var_1) happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happyReduce 4 21 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (InvocationFactor (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_1  21 happyReduction_43
happyReduction_43 (HappyTerminal (Token (TokInt happy_var_1) _))
	 =  HappyAbsSyn21
		 (IntFactor happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  21 happyReduction_44
happyReduction_44 (HappyTerminal (Token (TokReal happy_var_1) _))
	 =  HappyAbsSyn21
		 (RealFactor happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  21 happyReduction_45
happyReduction_45 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (SubFactor happy_var_2
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  21 happyReduction_46
happyReduction_46 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (NotFactor happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  22 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn22
		 (Plus
	)

happyReduce_48 = happySpecReduce_1  22 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn22
		 (Minus
	)

happyReduce_49 = happySpecReduce_1  23 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn23
		 (Mul
	)

happyReduce_50 = happySpecReduce_1  23 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn23
		 (Div
	)

happyReduce_51 = happySpecReduce_1  24 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn24
		 (S
	)

happyReduce_52 = happySpecReduce_1  24 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn24
		 (L
	)

happyReduce_53 = happySpecReduce_1  24 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn24
		 (E
	)

happyReduce_54 = happySpecReduce_1  24 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn24
		 (SE
	)

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn24
		 (LE
	)

happyReduce_56 = happySpecReduce_1  24 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn24
		 (NE
	)

happyNewToken action sts stk [] =
	action 66 66 notHappyAtAll (HappyState action) sts stk []

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
	Token (TokStr happy_dollar_dollar) _ -> cont 34;
	Token (TokInt happy_dollar_dollar) _ -> cont 35;
	Token (TokReal happy_dollar_dollar) _ -> cont 36;
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
parseError tokens = throwError (SyntaxErrorClass (maybeHead tokens))
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

