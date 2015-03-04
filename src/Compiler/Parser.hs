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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22
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

action_0 (34) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (34) = happyShift action_2
action_1 _ = happyFail

action_2 (29) = happyShift action_4
action_2 _ = happyFail

action_3 (60) = happyAccept
action_3 _ = happyFail

action_4 (23) = happyShift action_5
action_4 _ = happyFail

action_5 (29) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (24) = happyShift action_8
action_6 (28) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (25) = happyShift action_11
action_8 _ = happyFail

action_9 (29) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (40) = happyShift action_14
action_12 (9) = happyGoto action_13
action_12 _ = happyReduce_9

action_13 (35) = happyShift action_18
action_13 (36) = happyShift action_19
action_13 (37) = happyShift action_20
action_13 (10) = happyGoto action_16
action_13 (12) = happyGoto action_17
action_13 _ = happyFail

action_14 (29) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (26) = happyShift action_32
action_15 (28) = happyShift action_9
action_15 _ = happyFail

action_16 (25) = happyShift action_31
action_16 _ = happyFail

action_17 (27) = happyShift action_30
action_17 _ = happyFail

action_18 (29) = happyShift action_29
action_18 _ = happyFail

action_19 (29) = happyShift action_28
action_19 _ = happyFail

action_20 (29) = happyShift action_24
action_20 (37) = happyShift action_20
action_20 (38) = happyShift action_25
action_20 (42) = happyShift action_26
action_20 (45) = happyShift action_27
action_20 (12) = happyGoto action_21
action_20 (13) = happyGoto action_22
action_20 (14) = happyGoto action_23
action_20 _ = happyReduce_18

action_21 _ = happyReduce_25

action_22 (25) = happyShift action_55
action_22 (39) = happyShift action_56
action_22 _ = happyFail

action_23 _ = happyReduce_19

action_24 (23) = happyShift action_53
action_24 (47) = happyShift action_54
action_24 _ = happyReduce_23

action_25 (23) = happyShift action_45
action_25 (29) = happyShift action_46
action_25 (30) = happyShift action_47
action_25 (31) = happyShift action_48
action_25 (55) = happyShift action_49
action_25 (58) = happyShift action_50
action_25 (16) = happyGoto action_52
action_25 (17) = happyGoto action_42
action_25 (18) = happyGoto action_43
action_25 (19) = happyGoto action_44
action_25 _ = happyFail

action_26 (23) = happyShift action_45
action_26 (29) = happyShift action_46
action_26 (30) = happyShift action_47
action_26 (31) = happyShift action_48
action_26 (55) = happyShift action_49
action_26 (58) = happyShift action_50
action_26 (16) = happyGoto action_51
action_26 (17) = happyGoto action_42
action_26 (18) = happyGoto action_43
action_26 (19) = happyGoto action_44
action_26 _ = happyFail

action_27 (23) = happyShift action_45
action_27 (29) = happyShift action_46
action_27 (30) = happyShift action_47
action_27 (31) = happyShift action_48
action_27 (55) = happyShift action_49
action_27 (58) = happyShift action_50
action_27 (16) = happyGoto action_41
action_27 (17) = happyGoto action_42
action_27 (18) = happyGoto action_43
action_27 (19) = happyGoto action_44
action_27 _ = happyFail

action_28 (23) = happyShift action_39
action_28 (25) = happyShift action_40
action_28 _ = happyFail

action_29 (23) = happyShift action_37
action_29 (26) = happyShift action_38
action_29 _ = happyFail

action_30 _ = happyReduce_1

action_31 _ = happyReduce_10

action_32 (32) = happyShift action_35
action_32 (33) = happyShift action_36
action_32 (7) = happyGoto action_33
action_32 (8) = happyGoto action_34
action_32 _ = happyFail

action_33 (25) = happyShift action_85
action_33 _ = happyFail

action_34 _ = happyReduce_6

action_35 _ = happyReduce_7

action_36 _ = happyReduce_8

action_37 (29) = happyShift action_7
action_37 (5) = happyGoto action_81
action_37 (11) = happyGoto action_84
action_37 _ = happyFail

action_38 (32) = happyShift action_35
action_38 (33) = happyShift action_36
action_38 (8) = happyGoto action_83
action_38 _ = happyFail

action_39 (29) = happyShift action_7
action_39 (5) = happyGoto action_81
action_39 (11) = happyGoto action_82
action_39 _ = happyFail

action_40 (6) = happyGoto action_80
action_40 _ = happyReduce_4

action_41 (46) = happyShift action_79
action_41 _ = happyFail

action_42 (48) = happyShift action_71
action_42 (49) = happyShift action_72
action_42 (50) = happyShift action_73
action_42 (51) = happyShift action_74
action_42 (52) = happyShift action_75
action_42 (53) = happyShift action_76
action_42 (54) = happyShift action_77
action_42 (55) = happyShift action_78
action_42 (20) = happyGoto action_69
action_42 (22) = happyGoto action_70
action_42 _ = happyReduce_30

action_43 (56) = happyShift action_67
action_43 (57) = happyShift action_68
action_43 (21) = happyGoto action_66
action_43 _ = happyReduce_32

action_44 _ = happyReduce_34

action_45 (23) = happyShift action_45
action_45 (29) = happyShift action_46
action_45 (30) = happyShift action_47
action_45 (31) = happyShift action_48
action_45 (55) = happyShift action_49
action_45 (58) = happyShift action_50
action_45 (16) = happyGoto action_65
action_45 (17) = happyGoto action_42
action_45 (18) = happyGoto action_43
action_45 (19) = happyGoto action_44
action_45 _ = happyFail

action_46 (23) = happyShift action_64
action_46 _ = happyReduce_37

action_47 _ = happyReduce_39

action_48 _ = happyReduce_40

action_49 (23) = happyShift action_45
action_49 (29) = happyShift action_46
action_49 (30) = happyShift action_47
action_49 (31) = happyShift action_48
action_49 (58) = happyShift action_50
action_49 (19) = happyGoto action_63
action_49 _ = happyFail

action_50 (23) = happyShift action_45
action_50 (29) = happyShift action_46
action_50 (30) = happyShift action_47
action_50 (31) = happyShift action_48
action_50 (58) = happyShift action_50
action_50 (19) = happyGoto action_62
action_50 _ = happyFail

action_51 (43) = happyShift action_61
action_51 _ = happyFail

action_52 _ = happyReduce_22

action_53 (23) = happyShift action_45
action_53 (29) = happyShift action_46
action_53 (30) = happyShift action_47
action_53 (31) = happyShift action_48
action_53 (55) = happyShift action_49
action_53 (58) = happyShift action_50
action_53 (15) = happyGoto action_59
action_53 (16) = happyGoto action_60
action_53 (17) = happyGoto action_42
action_53 (18) = happyGoto action_43
action_53 (19) = happyGoto action_44
action_53 _ = happyFail

action_54 (23) = happyShift action_45
action_54 (29) = happyShift action_46
action_54 (30) = happyShift action_47
action_54 (31) = happyShift action_48
action_54 (55) = happyShift action_49
action_54 (58) = happyShift action_50
action_54 (16) = happyGoto action_58
action_54 (17) = happyGoto action_42
action_54 (18) = happyGoto action_43
action_54 (19) = happyGoto action_44
action_54 _ = happyFail

action_55 (29) = happyShift action_24
action_55 (37) = happyShift action_20
action_55 (38) = happyShift action_25
action_55 (42) = happyShift action_26
action_55 (45) = happyShift action_27
action_55 (12) = happyGoto action_21
action_55 (14) = happyGoto action_57
action_55 _ = happyFail

action_56 _ = happyReduce_17

action_57 _ = happyReduce_20

action_58 _ = happyReduce_21

action_59 (24) = happyShift action_99
action_59 (28) = happyShift action_100
action_59 _ = happyFail

action_60 _ = happyReduce_28

action_61 (29) = happyShift action_24
action_61 (37) = happyShift action_20
action_61 (38) = happyShift action_25
action_61 (42) = happyShift action_26
action_61 (45) = happyShift action_27
action_61 (12) = happyGoto action_21
action_61 (14) = happyGoto action_98
action_61 _ = happyFail

action_62 _ = happyReduce_42

action_63 _ = happyReduce_35

action_64 (23) = happyShift action_45
action_64 (29) = happyShift action_46
action_64 (30) = happyShift action_47
action_64 (31) = happyShift action_48
action_64 (55) = happyShift action_49
action_64 (58) = happyShift action_50
action_64 (15) = happyGoto action_97
action_64 (16) = happyGoto action_60
action_64 (17) = happyGoto action_42
action_64 (18) = happyGoto action_43
action_64 (19) = happyGoto action_44
action_64 _ = happyFail

action_65 (24) = happyShift action_96
action_65 _ = happyFail

action_66 (23) = happyShift action_45
action_66 (29) = happyShift action_46
action_66 (30) = happyShift action_47
action_66 (31) = happyShift action_48
action_66 (58) = happyShift action_50
action_66 (19) = happyGoto action_95
action_66 _ = happyFail

action_67 _ = happyReduce_45

action_68 _ = happyReduce_46

action_69 (23) = happyShift action_45
action_69 (29) = happyShift action_46
action_69 (30) = happyShift action_47
action_69 (31) = happyShift action_48
action_69 (55) = happyShift action_49
action_69 (58) = happyShift action_50
action_69 (18) = happyGoto action_94
action_69 (19) = happyGoto action_44
action_69 _ = happyFail

action_70 (23) = happyShift action_45
action_70 (29) = happyShift action_46
action_70 (30) = happyShift action_47
action_70 (31) = happyShift action_48
action_70 (55) = happyShift action_49
action_70 (58) = happyShift action_50
action_70 (17) = happyGoto action_93
action_70 (18) = happyGoto action_43
action_70 (19) = happyGoto action_44
action_70 _ = happyFail

action_71 _ = happyReduce_47

action_72 _ = happyReduce_48

action_73 _ = happyReduce_50

action_74 _ = happyReduce_51

action_75 _ = happyReduce_49

action_76 _ = happyReduce_52

action_77 _ = happyReduce_43

action_78 _ = happyReduce_44

action_79 (29) = happyShift action_24
action_79 (37) = happyShift action_20
action_79 (38) = happyShift action_25
action_79 (42) = happyShift action_26
action_79 (45) = happyShift action_27
action_79 (12) = happyGoto action_21
action_79 (14) = happyGoto action_92
action_79 _ = happyFail

action_80 (37) = happyShift action_20
action_80 (40) = happyShift action_14
action_80 (12) = happyGoto action_91
action_80 _ = happyFail

action_81 (26) = happyShift action_90
action_81 (28) = happyShift action_9
action_81 _ = happyFail

action_82 (24) = happyShift action_89
action_82 (25) = happyShift action_87
action_82 _ = happyFail

action_83 (25) = happyShift action_88
action_83 _ = happyFail

action_84 (24) = happyShift action_86
action_84 (25) = happyShift action_87
action_84 _ = happyFail

action_85 _ = happyReduce_5

action_86 (26) = happyShift action_108
action_86 _ = happyFail

action_87 (29) = happyShift action_7
action_87 (5) = happyGoto action_107
action_87 _ = happyFail

action_88 (6) = happyGoto action_106
action_88 _ = happyReduce_4

action_89 (25) = happyShift action_105
action_89 _ = happyFail

action_90 (32) = happyShift action_35
action_90 (33) = happyShift action_36
action_90 (7) = happyGoto action_104
action_90 (8) = happyGoto action_34
action_90 _ = happyFail

action_91 _ = happyReduce_13

action_92 _ = happyReduce_27

action_93 (54) = happyShift action_77
action_93 (55) = happyShift action_78
action_93 (20) = happyGoto action_69
action_93 _ = happyReduce_31

action_94 (56) = happyShift action_67
action_94 (57) = happyShift action_68
action_94 (21) = happyGoto action_66
action_94 _ = happyReduce_33

action_95 _ = happyReduce_36

action_96 _ = happyReduce_41

action_97 (24) = happyShift action_103
action_97 (28) = happyShift action_100
action_97 _ = happyFail

action_98 (44) = happyShift action_102
action_98 _ = happyFail

action_99 _ = happyReduce_24

action_100 (23) = happyShift action_45
action_100 (29) = happyShift action_46
action_100 (30) = happyShift action_47
action_100 (31) = happyShift action_48
action_100 (55) = happyShift action_49
action_100 (58) = happyShift action_50
action_100 (16) = happyGoto action_101
action_100 (17) = happyGoto action_42
action_100 (18) = happyGoto action_43
action_100 (19) = happyGoto action_44
action_100 _ = happyFail

action_101 _ = happyReduce_29

action_102 (29) = happyShift action_24
action_102 (37) = happyShift action_20
action_102 (38) = happyShift action_25
action_102 (42) = happyShift action_26
action_102 (45) = happyShift action_27
action_102 (12) = happyGoto action_21
action_102 (14) = happyGoto action_113
action_102 _ = happyFail

action_103 _ = happyReduce_38

action_104 _ = happyReduce_15

action_105 (6) = happyGoto action_112
action_105 _ = happyReduce_4

action_106 (37) = happyShift action_20
action_106 (40) = happyShift action_14
action_106 (12) = happyGoto action_111
action_106 _ = happyFail

action_107 (26) = happyShift action_110
action_107 (28) = happyShift action_9
action_107 _ = happyFail

action_108 (32) = happyShift action_35
action_108 (33) = happyShift action_36
action_108 (8) = happyGoto action_109
action_108 _ = happyFail

action_109 (25) = happyShift action_116
action_109 _ = happyFail

action_110 (32) = happyShift action_35
action_110 (33) = happyShift action_36
action_110 (7) = happyGoto action_115
action_110 (8) = happyGoto action_34
action_110 _ = happyFail

action_111 _ = happyReduce_11

action_112 (37) = happyShift action_20
action_112 (40) = happyShift action_14
action_112 (12) = happyGoto action_114
action_112 _ = happyFail

action_113 _ = happyReduce_26

action_114 _ = happyReduce_14

action_115 _ = happyReduce_16

action_116 (6) = happyGoto action_117
action_116 _ = happyReduce_4

action_117 (37) = happyShift action_20
action_117 (40) = happyShift action_14
action_117 (12) = happyGoto action_118
action_117 _ = happyFail

action_118 _ = happyReduce_12

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

happyReduce_7 = happySpecReduce_1  8 happyReduction_7
happyReduction_7 _
	 =  HappyAbsSyn8
		 (RawIntType
	)

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (RawRealType
	)

happyReduce_9 = happySpecReduce_0  9 happyReduction_9
happyReduction_9  =  HappyAbsSyn9
		 ([]
	)

happyReduce_10 = happySpecReduce_3  9 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_2 : happy_var_1
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 7 10 happyReduction_11
happyReduction_11 ((HappyAbsSyn12  happy_var_7) `HappyStk`
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

happyReduce_12 = happyReduce 10 10 happyReduction_12
happyReduction_12 ((HappyAbsSyn12  happy_var_10) `HappyStk`
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

happyReduce_13 = happyReduce 5 10 happyReduction_13
happyReduction_13 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (ProcDec (toSym happy_var_2) [] happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 8 10 happyReduction_14
happyReduction_14 ((HappyAbsSyn12  happy_var_8) `HappyStk`
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

happyReduce_15 = happySpecReduce_3  11 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (Parameter happy_var_1 happy_var_3 : []
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 5 11 happyReduction_16
happyReduction_16 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Parameter happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_3  12 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (reverse happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_0  13 happyReduction_18
happyReduction_18  =  HappyAbsSyn13
		 ([]
	)

happyReduce_19 = happySpecReduce_1  13 happyReduction_19
happyReduction_19 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  13 happyReduction_20
happyReduction_20 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_3 : happy_var_1
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  14 happyReduction_21
happyReduction_21 (HappyAbsSyn16  happy_var_3)
	_
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 (Assignment (toSym happy_var_1) happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  14 happyReduction_22
happyReduction_22 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Return happy_var_2
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn14
		 (Invocation (toSym happy_var_1) []
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happyReduce 4 14 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Invocation (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1  14 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (Compound happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 6 14 happyReduction_26
happyReduction_26 ((HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Branch happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 4 14 happyReduction_27
happyReduction_27 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Loop happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_1  15 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 : []
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_3 : happy_var_1
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (UnaryExpression happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  16 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (BinaryExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (TermSimpleExpression happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  17 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (OpSimpleExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  18 happyReduction_34
happyReduction_34 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (FactorTerm happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  18 happyReduction_35
happyReduction_35 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (NegTerm happy_var_2
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  18 happyReduction_36
happyReduction_36 (HappyAbsSyn19  happy_var_3)
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  19 happyReduction_37
happyReduction_37 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn19
		 (ArrayAccessFactor (toSym happy_var_1)
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happyReduce 4 19 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (InvocationFactor (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_1  19 happyReduction_39
happyReduction_39 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn19
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  19 happyReduction_40
happyReduction_40 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn19
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  19 happyReduction_41
happyReduction_41 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (SubFactor happy_var_2
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  19 happyReduction_42
happyReduction_42 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (NotFactor happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  20 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn20
		 (Plus
	)

happyReduce_44 = happySpecReduce_1  20 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn20
		 (Minus
	)

happyReduce_45 = happySpecReduce_1  21 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn21
		 (Mul
	)

happyReduce_46 = happySpecReduce_1  21 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn21
		 (Div
	)

happyReduce_47 = happySpecReduce_1  22 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn22
		 (S
	)

happyReduce_48 = happySpecReduce_1  22 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn22
		 (L
	)

happyReduce_49 = happySpecReduce_1  22 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn22
		 (E
	)

happyReduce_50 = happySpecReduce_1  22 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn22
		 (SE
	)

happyReduce_51 = happySpecReduce_1  22 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn22
		 (LE
	)

happyReduce_52 = happySpecReduce_1  22 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn22
		 (NE
	)

happyNewToken action sts stk [] =
	action 60 60 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token TokLParen _ -> cont 23;
	Token TokRParen _ -> cont 24;
	Token TokSemicolon _ -> cont 25;
	Token TokColon _ -> cont 26;
	Token TokPeriod _ -> cont 27;
	Token TokComma _ -> cont 28;
	Token (TokID _) _ -> cont 29;
	Token (TokInt _) _ -> cont 30;
	Token (TokReal _) _ -> cont 31;
	Token TokTypeInt _ -> cont 32;
	Token TokTypeReal _ -> cont 33;
	Token TokProgram _ -> cont 34;
	Token TokFunction _ -> cont 35;
	Token TokProc _ -> cont 36;
	Token TokBegin _ -> cont 37;
	Token TokReturn _ -> cont 38;
	Token TokEnd _ -> cont 39;
	Token TokVar _ -> cont 40;
	Token TokOf _ -> cont 41;
	Token TokIf _ -> cont 42;
	Token TokThen _ -> cont 43;
	Token TokElse _ -> cont 44;
	Token TokWhile _ -> cont 45;
	Token TokDo _ -> cont 46;
	Token TokAssign _ -> cont 47;
	Token TokS _ -> cont 48;
	Token TokL _ -> cont 49;
	Token TokSE _ -> cont 50;
	Token TokLE _ -> cont 51;
	Token TokEq _ -> cont 52;
	Token TokNEq _ -> cont 53;
	Token TokPlus _ -> cont 54;
	Token TokMinus _ -> cont 55;
	Token TokTimes _ -> cont 56;
	Token TokDiv _ -> cont 57;
	Token TokNot _ -> cont 58;
	Token TokTo _ -> cont 59;
	_ -> happyError' (tk:tks)
	}

happyError_ 60 tk tks = happyError' tks
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

