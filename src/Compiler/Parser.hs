{-# OPTIONS_GHC -w #-}
module Compiler.Parser where
import Compiler.Type.Token
import Compiler.Type.Pipeline
import Compiler.Type.DSL
import Compiler.Type.Symbol
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

action_3 (65) = happyAccept
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

action_12 (44) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_10

action_13 (39) = happyShift action_18
action_13 (40) = happyShift action_19
action_13 (41) = happyShift action_20
action_13 (10) = happyGoto action_16
action_13 (12) = happyGoto action_17
action_13 _ = happyFail

action_14 (33) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (28) = happyShift action_33
action_15 (30) = happyShift action_9
action_15 _ = happyFail

action_16 (27) = happyShift action_32
action_16 _ = happyFail

action_17 (29) = happyShift action_31
action_17 _ = happyFail

action_18 (33) = happyShift action_30
action_18 _ = happyFail

action_19 (33) = happyShift action_29
action_19 _ = happyFail

action_20 (33) = happyShift action_25
action_20 (41) = happyShift action_20
action_20 (42) = happyShift action_26
action_20 (47) = happyShift action_27
action_20 (50) = happyShift action_28
action_20 (12) = happyGoto action_21
action_20 (13) = happyGoto action_22
action_20 (14) = happyGoto action_23
action_20 (15) = happyGoto action_24
action_20 _ = happyReduce_19

action_21 _ = happyReduce_26

action_22 (27) = happyShift action_59
action_22 (43) = happyShift action_60
action_22 _ = happyFail

action_23 _ = happyReduce_20

action_24 (52) = happyShift action_58
action_24 _ = happyFail

action_25 (25) = happyShift action_56
action_25 (31) = happyShift action_57
action_25 (52) = happyReduce_30
action_25 (16) = happyGoto action_55
action_25 _ = happyReduce_24

action_26 (25) = happyShift action_47
action_26 (33) = happyShift action_48
action_26 (34) = happyShift action_49
action_26 (35) = happyShift action_50
action_26 (60) = happyShift action_51
action_26 (63) = happyShift action_52
action_26 (18) = happyGoto action_54
action_26 (19) = happyGoto action_44
action_26 (20) = happyGoto action_45
action_26 (21) = happyGoto action_46
action_26 _ = happyFail

action_27 (25) = happyShift action_47
action_27 (33) = happyShift action_48
action_27 (34) = happyShift action_49
action_27 (35) = happyShift action_50
action_27 (60) = happyShift action_51
action_27 (63) = happyShift action_52
action_27 (18) = happyGoto action_53
action_27 (19) = happyGoto action_44
action_27 (20) = happyGoto action_45
action_27 (21) = happyGoto action_46
action_27 _ = happyFail

action_28 (25) = happyShift action_47
action_28 (33) = happyShift action_48
action_28 (34) = happyShift action_49
action_28 (35) = happyShift action_50
action_28 (60) = happyShift action_51
action_28 (63) = happyShift action_52
action_28 (18) = happyGoto action_43
action_28 (19) = happyGoto action_44
action_28 (20) = happyGoto action_45
action_28 (21) = happyGoto action_46
action_28 _ = happyFail

action_29 (25) = happyShift action_41
action_29 (27) = happyShift action_42
action_29 _ = happyFail

action_30 (25) = happyShift action_39
action_30 (28) = happyShift action_40
action_30 _ = happyFail

action_31 _ = happyReduce_1

action_32 _ = happyReduce_11

action_33 (36) = happyShift action_36
action_33 (37) = happyShift action_37
action_33 (45) = happyShift action_38
action_33 (7) = happyGoto action_34
action_33 (8) = happyGoto action_35
action_33 _ = happyFail

action_34 (27) = happyShift action_92
action_34 _ = happyFail

action_35 _ = happyReduce_6

action_36 _ = happyReduce_8

action_37 _ = happyReduce_9

action_38 (31) = happyShift action_91
action_38 _ = happyFail

action_39 (33) = happyShift action_7
action_39 (5) = happyGoto action_87
action_39 (11) = happyGoto action_90
action_39 _ = happyFail

action_40 (36) = happyShift action_36
action_40 (37) = happyShift action_37
action_40 (8) = happyGoto action_89
action_40 _ = happyFail

action_41 (33) = happyShift action_7
action_41 (5) = happyGoto action_87
action_41 (11) = happyGoto action_88
action_41 _ = happyFail

action_42 (6) = happyGoto action_86
action_42 _ = happyReduce_4

action_43 (51) = happyShift action_85
action_43 _ = happyFail

action_44 (53) = happyShift action_77
action_44 (54) = happyShift action_78
action_44 (55) = happyShift action_79
action_44 (56) = happyShift action_80
action_44 (57) = happyShift action_81
action_44 (58) = happyShift action_82
action_44 (59) = happyShift action_83
action_44 (60) = happyShift action_84
action_44 (22) = happyGoto action_75
action_44 (24) = happyGoto action_76
action_44 _ = happyReduce_34

action_45 (61) = happyShift action_73
action_45 (62) = happyShift action_74
action_45 (23) = happyGoto action_72
action_45 _ = happyReduce_36

action_46 _ = happyReduce_38

action_47 (25) = happyShift action_47
action_47 (33) = happyShift action_48
action_47 (34) = happyShift action_49
action_47 (35) = happyShift action_50
action_47 (60) = happyShift action_51
action_47 (63) = happyShift action_52
action_47 (18) = happyGoto action_71
action_47 (19) = happyGoto action_44
action_47 (20) = happyGoto action_45
action_47 (21) = happyGoto action_46
action_47 _ = happyFail

action_48 (25) = happyShift action_70
action_48 (31) = happyShift action_57
action_48 (16) = happyGoto action_69
action_48 _ = happyReduce_30

action_49 _ = happyReduce_43

action_50 _ = happyReduce_44

action_51 (25) = happyShift action_47
action_51 (33) = happyShift action_48
action_51 (34) = happyShift action_49
action_51 (35) = happyShift action_50
action_51 (63) = happyShift action_52
action_51 (21) = happyGoto action_68
action_51 _ = happyFail

action_52 (25) = happyShift action_47
action_52 (33) = happyShift action_48
action_52 (34) = happyShift action_49
action_52 (35) = happyShift action_50
action_52 (63) = happyShift action_52
action_52 (21) = happyGoto action_67
action_52 _ = happyFail

action_53 (48) = happyShift action_66
action_53 _ = happyFail

action_54 _ = happyReduce_23

action_55 _ = happyReduce_29

action_56 (25) = happyShift action_47
action_56 (33) = happyShift action_48
action_56 (34) = happyShift action_49
action_56 (35) = happyShift action_50
action_56 (60) = happyShift action_51
action_56 (63) = happyShift action_52
action_56 (17) = happyGoto action_64
action_56 (18) = happyGoto action_65
action_56 (19) = happyGoto action_44
action_56 (20) = happyGoto action_45
action_56 (21) = happyGoto action_46
action_56 _ = happyFail

action_57 (25) = happyShift action_47
action_57 (33) = happyShift action_48
action_57 (34) = happyShift action_49
action_57 (35) = happyShift action_50
action_57 (60) = happyShift action_51
action_57 (63) = happyShift action_52
action_57 (18) = happyGoto action_63
action_57 (19) = happyGoto action_44
action_57 (20) = happyGoto action_45
action_57 (21) = happyGoto action_46
action_57 _ = happyFail

action_58 (25) = happyShift action_47
action_58 (33) = happyShift action_48
action_58 (34) = happyShift action_49
action_58 (35) = happyShift action_50
action_58 (60) = happyShift action_51
action_58 (63) = happyShift action_52
action_58 (18) = happyGoto action_62
action_58 (19) = happyGoto action_44
action_58 (20) = happyGoto action_45
action_58 (21) = happyGoto action_46
action_58 _ = happyFail

action_59 (33) = happyShift action_25
action_59 (41) = happyShift action_20
action_59 (42) = happyShift action_26
action_59 (47) = happyShift action_27
action_59 (50) = happyShift action_28
action_59 (12) = happyGoto action_21
action_59 (14) = happyGoto action_61
action_59 (15) = happyGoto action_24
action_59 _ = happyFail

action_60 _ = happyReduce_18

action_61 _ = happyReduce_21

action_62 _ = happyReduce_22

action_63 (32) = happyShift action_109
action_63 _ = happyFail

action_64 (26) = happyShift action_107
action_64 (30) = happyShift action_108
action_64 _ = happyFail

action_65 _ = happyReduce_32

action_66 (33) = happyShift action_25
action_66 (41) = happyShift action_20
action_66 (42) = happyShift action_26
action_66 (47) = happyShift action_27
action_66 (50) = happyShift action_28
action_66 (12) = happyGoto action_21
action_66 (14) = happyGoto action_106
action_66 (15) = happyGoto action_24
action_66 _ = happyFail

action_67 _ = happyReduce_46

action_68 _ = happyReduce_39

action_69 _ = happyReduce_41

action_70 (25) = happyShift action_47
action_70 (33) = happyShift action_48
action_70 (34) = happyShift action_49
action_70 (35) = happyShift action_50
action_70 (60) = happyShift action_51
action_70 (63) = happyShift action_52
action_70 (17) = happyGoto action_105
action_70 (18) = happyGoto action_65
action_70 (19) = happyGoto action_44
action_70 (20) = happyGoto action_45
action_70 (21) = happyGoto action_46
action_70 _ = happyFail

action_71 (26) = happyShift action_104
action_71 _ = happyFail

action_72 (25) = happyShift action_47
action_72 (33) = happyShift action_48
action_72 (34) = happyShift action_49
action_72 (35) = happyShift action_50
action_72 (63) = happyShift action_52
action_72 (21) = happyGoto action_103
action_72 _ = happyFail

action_73 _ = happyReduce_49

action_74 _ = happyReduce_50

action_75 (25) = happyShift action_47
action_75 (33) = happyShift action_48
action_75 (34) = happyShift action_49
action_75 (35) = happyShift action_50
action_75 (60) = happyShift action_51
action_75 (63) = happyShift action_52
action_75 (20) = happyGoto action_102
action_75 (21) = happyGoto action_46
action_75 _ = happyFail

action_76 (25) = happyShift action_47
action_76 (33) = happyShift action_48
action_76 (34) = happyShift action_49
action_76 (35) = happyShift action_50
action_76 (60) = happyShift action_51
action_76 (63) = happyShift action_52
action_76 (19) = happyGoto action_101
action_76 (20) = happyGoto action_45
action_76 (21) = happyGoto action_46
action_76 _ = happyFail

action_77 _ = happyReduce_51

action_78 _ = happyReduce_52

action_79 _ = happyReduce_54

action_80 _ = happyReduce_55

action_81 _ = happyReduce_53

action_82 _ = happyReduce_56

action_83 _ = happyReduce_47

action_84 _ = happyReduce_48

action_85 (33) = happyShift action_25
action_85 (41) = happyShift action_20
action_85 (42) = happyShift action_26
action_85 (47) = happyShift action_27
action_85 (50) = happyShift action_28
action_85 (12) = happyGoto action_21
action_85 (14) = happyGoto action_100
action_85 (15) = happyGoto action_24
action_85 _ = happyFail

action_86 (41) = happyShift action_20
action_86 (44) = happyShift action_14
action_86 (12) = happyGoto action_99
action_86 _ = happyFail

action_87 (28) = happyShift action_98
action_87 (30) = happyShift action_9
action_87 _ = happyFail

action_88 (26) = happyShift action_97
action_88 (27) = happyShift action_95
action_88 _ = happyFail

action_89 (27) = happyShift action_96
action_89 _ = happyFail

action_90 (26) = happyShift action_94
action_90 (27) = happyShift action_95
action_90 _ = happyFail

action_91 (34) = happyShift action_93
action_91 _ = happyFail

action_92 _ = happyReduce_5

action_93 (64) = happyShift action_119
action_93 _ = happyFail

action_94 (28) = happyShift action_118
action_94 _ = happyFail

action_95 (33) = happyShift action_7
action_95 (5) = happyGoto action_117
action_95 _ = happyFail

action_96 (6) = happyGoto action_116
action_96 _ = happyReduce_4

action_97 (27) = happyShift action_115
action_97 _ = happyFail

action_98 (36) = happyShift action_36
action_98 (37) = happyShift action_37
action_98 (45) = happyShift action_38
action_98 (7) = happyGoto action_114
action_98 (8) = happyGoto action_35
action_98 _ = happyFail

action_99 _ = happyReduce_14

action_100 _ = happyReduce_28

action_101 (59) = happyShift action_83
action_101 (60) = happyShift action_84
action_101 (22) = happyGoto action_75
action_101 _ = happyReduce_35

action_102 (61) = happyShift action_73
action_102 (62) = happyShift action_74
action_102 (23) = happyGoto action_72
action_102 _ = happyReduce_37

action_103 _ = happyReduce_40

action_104 _ = happyReduce_45

action_105 (26) = happyShift action_113
action_105 (30) = happyShift action_108
action_105 _ = happyFail

action_106 (49) = happyShift action_112
action_106 _ = happyFail

action_107 _ = happyReduce_25

action_108 (25) = happyShift action_47
action_108 (33) = happyShift action_48
action_108 (34) = happyShift action_49
action_108 (35) = happyShift action_50
action_108 (60) = happyShift action_51
action_108 (63) = happyShift action_52
action_108 (18) = happyGoto action_111
action_108 (19) = happyGoto action_44
action_108 (20) = happyGoto action_45
action_108 (21) = happyGoto action_46
action_108 _ = happyFail

action_109 (31) = happyShift action_57
action_109 (16) = happyGoto action_110
action_109 _ = happyReduce_30

action_110 _ = happyReduce_31

action_111 _ = happyReduce_33

action_112 (33) = happyShift action_25
action_112 (41) = happyShift action_20
action_112 (42) = happyShift action_26
action_112 (47) = happyShift action_27
action_112 (50) = happyShift action_28
action_112 (12) = happyGoto action_21
action_112 (14) = happyGoto action_125
action_112 (15) = happyGoto action_24
action_112 _ = happyFail

action_113 _ = happyReduce_42

action_114 _ = happyReduce_16

action_115 (6) = happyGoto action_124
action_115 _ = happyReduce_4

action_116 (41) = happyShift action_20
action_116 (44) = happyShift action_14
action_116 (12) = happyGoto action_123
action_116 _ = happyFail

action_117 (28) = happyShift action_122
action_117 (30) = happyShift action_9
action_117 _ = happyFail

action_118 (36) = happyShift action_36
action_118 (37) = happyShift action_37
action_118 (8) = happyGoto action_121
action_118 _ = happyFail

action_119 (34) = happyShift action_120
action_119 _ = happyFail

action_120 (32) = happyShift action_129
action_120 _ = happyFail

action_121 (27) = happyShift action_128
action_121 _ = happyFail

action_122 (36) = happyShift action_36
action_122 (37) = happyShift action_37
action_122 (45) = happyShift action_38
action_122 (7) = happyGoto action_127
action_122 (8) = happyGoto action_35
action_122 _ = happyFail

action_123 _ = happyReduce_12

action_124 (41) = happyShift action_20
action_124 (44) = happyShift action_14
action_124 (12) = happyGoto action_126
action_124 _ = happyFail

action_125 _ = happyReduce_27

action_126 _ = happyReduce_15

action_127 _ = happyReduce_17

action_128 (6) = happyGoto action_131
action_128 _ = happyReduce_4

action_129 (46) = happyShift action_130
action_129 _ = happyFail

action_130 (36) = happyShift action_36
action_130 (37) = happyShift action_37
action_130 (45) = happyShift action_38
action_130 (7) = happyGoto action_133
action_130 (8) = happyGoto action_35
action_130 _ = happyFail

action_131 (41) = happyShift action_20
action_131 (44) = happyShift action_14
action_131 (12) = happyGoto action_132
action_131 _ = happyFail

action_132 _ = happyReduce_13

action_133 _ = happyReduce_7

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
		 (RawProgram (toSym happy_var_2) (reverse happy_var_4) (reverse happy_var_7) (reverse happy_var_8) happy_var_9
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
		 (Basic happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 8 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Array (getInt (toLiteral happy_var_3), getInt (toLiteral happy_var_5)) happy_var_8
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (RawIntType
	)

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (RawRealType
	)

happyReduce_10 = happySpecReduce_0  9 happyReduction_10
happyReduction_10  =  HappyAbsSyn9
		 ([]
	)

happyReduce_11 = happySpecReduce_3  9 happyReduction_11
happyReduction_11 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2 : happy_var_1
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 7 10 happyReduction_12
happyReduction_12 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (FuncDec (toSym happy_var_2) [] happy_var_4 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 10 10 happyReduction_13
happyReduction_13 ((HappyAbsSyn12  happy_var_10) `HappyStk`
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
		 (FuncDec (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 5 10 happyReduction_14
happyReduction_14 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDec (toSym happy_var_2) [] happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 8 10 happyReduction_15
happyReduction_15 ((HappyAbsSyn12  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDec (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_8
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_3  11 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (Parameter happy_var_1 happy_var_3 : []
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 5 11 happyReduction_17
happyReduction_17 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Parameter happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_3  12 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (reverse happy_var_2
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_0  13 happyReduction_19
happyReduction_19  =  HappyAbsSyn13
		 ([]
	)

happyReduce_20 = happySpecReduce_1  13 happyReduction_20
happyReduction_20 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  13 happyReduction_21
happyReduction_21 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_3 : happy_var_1
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  14 happyReduction_22
happyReduction_22 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (Assignment happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  14 happyReduction_23
happyReduction_23 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Return happy_var_2
	)
happyReduction_23 _ _  = notHappyAtAll 

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
		 (Compound happy_var_1
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
happyReduction_43 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  21 happyReduction_44
happyReduction_44 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn21
		 (NumberFactor (toLiteral happy_var_1)
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
	action 65 65 notHappyAtAll (HappyState action) sts stk []

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
	Token (TokInt _) _ -> cont 34;
	Token (TokReal _) _ -> cont 35;
	Token TokTypeInt _ -> cont 36;
	Token TokTypeReal _ -> cont 37;
	Token TokProgram _ -> cont 38;
	Token TokFunction _ -> cont 39;
	Token TokProc _ -> cont 40;
	Token TokBegin _ -> cont 41;
	Token TokReturn _ -> cont 42;
	Token TokEnd _ -> cont 43;
	Token TokVar _ -> cont 44;
	Token TokArr _ -> cont 45;
	Token TokOf _ -> cont 46;
	Token TokIf _ -> cont 47;
	Token TokThen _ -> cont 48;
	Token TokElse _ -> cont 49;
	Token TokWhile _ -> cont 50;
	Token TokDo _ -> cont 51;
	Token TokAssign _ -> cont 52;
	Token TokS _ -> cont 53;
	Token TokL _ -> cont 54;
	Token TokSE _ -> cont 55;
	Token TokLE _ -> cont 56;
	Token TokEq _ -> cont 57;
	Token TokNEq _ -> cont 58;
	Token TokPlus _ -> cont 59;
	Token TokMinus _ -> cont 60;
	Token TokTimes _ -> cont 61;
	Token TokDiv _ -> cont 62;
	Token TokNot _ -> cont 63;
	Token TokTo _ -> cont 64;
	_ -> happyError' (tk:tks)
	}

happyError_ 65 tk tks = happyError' tks
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

