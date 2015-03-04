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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21
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

action_0 (33) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (33) = happyShift action_2
action_1 _ = happyFail

action_2 (28) = happyShift action_4
action_2 _ = happyFail

action_3 (59) = happyAccept
action_3 _ = happyFail

action_4 (22) = happyShift action_5
action_4 _ = happyFail

action_5 (28) = happyShift action_7
action_5 (5) = happyGoto action_6
action_5 _ = happyFail

action_6 (23) = happyShift action_8
action_6 (27) = happyShift action_9
action_6 _ = happyFail

action_7 _ = happyReduce_2

action_8 (24) = happyShift action_11
action_8 _ = happyFail

action_9 (28) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_3

action_11 (6) = happyGoto action_12
action_11 _ = happyReduce_4

action_12 (39) = happyShift action_14
action_12 (8) = happyGoto action_13
action_12 _ = happyReduce_8

action_13 (34) = happyShift action_18
action_13 (35) = happyShift action_19
action_13 (36) = happyShift action_20
action_13 (9) = happyGoto action_16
action_13 (11) = happyGoto action_17
action_13 _ = happyFail

action_14 (28) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (25) = happyShift action_32
action_15 (27) = happyShift action_9
action_15 _ = happyFail

action_16 (24) = happyShift action_31
action_16 _ = happyFail

action_17 (26) = happyShift action_30
action_17 _ = happyFail

action_18 (28) = happyShift action_29
action_18 _ = happyFail

action_19 (28) = happyShift action_28
action_19 _ = happyFail

action_20 (28) = happyShift action_24
action_20 (36) = happyShift action_20
action_20 (37) = happyShift action_25
action_20 (41) = happyShift action_26
action_20 (44) = happyShift action_27
action_20 (11) = happyGoto action_21
action_20 (12) = happyGoto action_22
action_20 (13) = happyGoto action_23
action_20 _ = happyReduce_17

action_21 _ = happyReduce_24

action_22 (24) = happyShift action_54
action_22 (38) = happyShift action_55
action_22 _ = happyFail

action_23 _ = happyReduce_18

action_24 (22) = happyShift action_52
action_24 (46) = happyShift action_53
action_24 _ = happyReduce_22

action_25 (22) = happyShift action_44
action_25 (28) = happyShift action_45
action_25 (29) = happyShift action_46
action_25 (30) = happyShift action_47
action_25 (54) = happyShift action_48
action_25 (57) = happyShift action_49
action_25 (15) = happyGoto action_51
action_25 (16) = happyGoto action_41
action_25 (17) = happyGoto action_42
action_25 (18) = happyGoto action_43
action_25 _ = happyFail

action_26 (22) = happyShift action_44
action_26 (28) = happyShift action_45
action_26 (29) = happyShift action_46
action_26 (30) = happyShift action_47
action_26 (54) = happyShift action_48
action_26 (57) = happyShift action_49
action_26 (15) = happyGoto action_50
action_26 (16) = happyGoto action_41
action_26 (17) = happyGoto action_42
action_26 (18) = happyGoto action_43
action_26 _ = happyFail

action_27 (22) = happyShift action_44
action_27 (28) = happyShift action_45
action_27 (29) = happyShift action_46
action_27 (30) = happyShift action_47
action_27 (54) = happyShift action_48
action_27 (57) = happyShift action_49
action_27 (15) = happyGoto action_40
action_27 (16) = happyGoto action_41
action_27 (17) = happyGoto action_42
action_27 (18) = happyGoto action_43
action_27 _ = happyFail

action_28 (22) = happyShift action_38
action_28 (24) = happyShift action_39
action_28 _ = happyFail

action_29 (22) = happyShift action_36
action_29 (25) = happyShift action_37
action_29 _ = happyFail

action_30 _ = happyReduce_1

action_31 _ = happyReduce_9

action_32 (31) = happyShift action_34
action_32 (32) = happyShift action_35
action_32 (7) = happyGoto action_33
action_32 _ = happyFail

action_33 (24) = happyShift action_84
action_33 _ = happyFail

action_34 _ = happyReduce_6

action_35 _ = happyReduce_7

action_36 (28) = happyShift action_7
action_36 (5) = happyGoto action_80
action_36 (10) = happyGoto action_83
action_36 _ = happyFail

action_37 (31) = happyShift action_34
action_37 (32) = happyShift action_35
action_37 (7) = happyGoto action_82
action_37 _ = happyFail

action_38 (28) = happyShift action_7
action_38 (5) = happyGoto action_80
action_38 (10) = happyGoto action_81
action_38 _ = happyFail

action_39 (6) = happyGoto action_79
action_39 _ = happyReduce_4

action_40 (45) = happyShift action_78
action_40 _ = happyFail

action_41 (47) = happyShift action_70
action_41 (48) = happyShift action_71
action_41 (49) = happyShift action_72
action_41 (50) = happyShift action_73
action_41 (51) = happyShift action_74
action_41 (52) = happyShift action_75
action_41 (53) = happyShift action_76
action_41 (54) = happyShift action_77
action_41 (19) = happyGoto action_68
action_41 (21) = happyGoto action_69
action_41 _ = happyReduce_29

action_42 (55) = happyShift action_66
action_42 (56) = happyShift action_67
action_42 (20) = happyGoto action_65
action_42 _ = happyReduce_31

action_43 _ = happyReduce_33

action_44 (22) = happyShift action_44
action_44 (28) = happyShift action_45
action_44 (29) = happyShift action_46
action_44 (30) = happyShift action_47
action_44 (54) = happyShift action_48
action_44 (57) = happyShift action_49
action_44 (15) = happyGoto action_64
action_44 (16) = happyGoto action_41
action_44 (17) = happyGoto action_42
action_44 (18) = happyGoto action_43
action_44 _ = happyFail

action_45 (22) = happyShift action_63
action_45 _ = happyReduce_36

action_46 _ = happyReduce_38

action_47 _ = happyReduce_39

action_48 (22) = happyShift action_44
action_48 (28) = happyShift action_45
action_48 (29) = happyShift action_46
action_48 (30) = happyShift action_47
action_48 (57) = happyShift action_49
action_48 (18) = happyGoto action_62
action_48 _ = happyFail

action_49 (22) = happyShift action_44
action_49 (28) = happyShift action_45
action_49 (29) = happyShift action_46
action_49 (30) = happyShift action_47
action_49 (57) = happyShift action_49
action_49 (18) = happyGoto action_61
action_49 _ = happyFail

action_50 (42) = happyShift action_60
action_50 _ = happyFail

action_51 _ = happyReduce_21

action_52 (22) = happyShift action_44
action_52 (28) = happyShift action_45
action_52 (29) = happyShift action_46
action_52 (30) = happyShift action_47
action_52 (54) = happyShift action_48
action_52 (57) = happyShift action_49
action_52 (14) = happyGoto action_58
action_52 (15) = happyGoto action_59
action_52 (16) = happyGoto action_41
action_52 (17) = happyGoto action_42
action_52 (18) = happyGoto action_43
action_52 _ = happyFail

action_53 (22) = happyShift action_44
action_53 (28) = happyShift action_45
action_53 (29) = happyShift action_46
action_53 (30) = happyShift action_47
action_53 (54) = happyShift action_48
action_53 (57) = happyShift action_49
action_53 (15) = happyGoto action_57
action_53 (16) = happyGoto action_41
action_53 (17) = happyGoto action_42
action_53 (18) = happyGoto action_43
action_53 _ = happyFail

action_54 (28) = happyShift action_24
action_54 (36) = happyShift action_20
action_54 (37) = happyShift action_25
action_54 (41) = happyShift action_26
action_54 (44) = happyShift action_27
action_54 (11) = happyGoto action_21
action_54 (13) = happyGoto action_56
action_54 _ = happyFail

action_55 _ = happyReduce_16

action_56 _ = happyReduce_19

action_57 _ = happyReduce_20

action_58 (23) = happyShift action_98
action_58 (27) = happyShift action_99
action_58 _ = happyFail

action_59 _ = happyReduce_27

action_60 (28) = happyShift action_24
action_60 (36) = happyShift action_20
action_60 (37) = happyShift action_25
action_60 (41) = happyShift action_26
action_60 (44) = happyShift action_27
action_60 (11) = happyGoto action_21
action_60 (13) = happyGoto action_97
action_60 _ = happyFail

action_61 _ = happyReduce_41

action_62 _ = happyReduce_34

action_63 (22) = happyShift action_44
action_63 (28) = happyShift action_45
action_63 (29) = happyShift action_46
action_63 (30) = happyShift action_47
action_63 (54) = happyShift action_48
action_63 (57) = happyShift action_49
action_63 (14) = happyGoto action_96
action_63 (15) = happyGoto action_59
action_63 (16) = happyGoto action_41
action_63 (17) = happyGoto action_42
action_63 (18) = happyGoto action_43
action_63 _ = happyFail

action_64 (23) = happyShift action_95
action_64 _ = happyFail

action_65 (22) = happyShift action_44
action_65 (28) = happyShift action_45
action_65 (29) = happyShift action_46
action_65 (30) = happyShift action_47
action_65 (57) = happyShift action_49
action_65 (18) = happyGoto action_94
action_65 _ = happyFail

action_66 _ = happyReduce_44

action_67 _ = happyReduce_45

action_68 (22) = happyShift action_44
action_68 (28) = happyShift action_45
action_68 (29) = happyShift action_46
action_68 (30) = happyShift action_47
action_68 (54) = happyShift action_48
action_68 (57) = happyShift action_49
action_68 (17) = happyGoto action_93
action_68 (18) = happyGoto action_43
action_68 _ = happyFail

action_69 (22) = happyShift action_44
action_69 (28) = happyShift action_45
action_69 (29) = happyShift action_46
action_69 (30) = happyShift action_47
action_69 (54) = happyShift action_48
action_69 (57) = happyShift action_49
action_69 (16) = happyGoto action_92
action_69 (17) = happyGoto action_42
action_69 (18) = happyGoto action_43
action_69 _ = happyFail

action_70 _ = happyReduce_46

action_71 _ = happyReduce_47

action_72 _ = happyReduce_49

action_73 _ = happyReduce_50

action_74 _ = happyReduce_48

action_75 _ = happyReduce_51

action_76 _ = happyReduce_42

action_77 _ = happyReduce_43

action_78 (28) = happyShift action_24
action_78 (36) = happyShift action_20
action_78 (37) = happyShift action_25
action_78 (41) = happyShift action_26
action_78 (44) = happyShift action_27
action_78 (11) = happyGoto action_21
action_78 (13) = happyGoto action_91
action_78 _ = happyFail

action_79 (36) = happyShift action_20
action_79 (39) = happyShift action_14
action_79 (11) = happyGoto action_90
action_79 _ = happyFail

action_80 (25) = happyShift action_89
action_80 (27) = happyShift action_9
action_80 _ = happyFail

action_81 (23) = happyShift action_88
action_81 (24) = happyShift action_86
action_81 _ = happyFail

action_82 (24) = happyShift action_87
action_82 _ = happyFail

action_83 (23) = happyShift action_85
action_83 (24) = happyShift action_86
action_83 _ = happyFail

action_84 _ = happyReduce_5

action_85 (25) = happyShift action_107
action_85 _ = happyFail

action_86 (28) = happyShift action_7
action_86 (5) = happyGoto action_106
action_86 _ = happyFail

action_87 (6) = happyGoto action_105
action_87 _ = happyReduce_4

action_88 (24) = happyShift action_104
action_88 _ = happyFail

action_89 (31) = happyShift action_34
action_89 (32) = happyShift action_35
action_89 (7) = happyGoto action_103
action_89 _ = happyFail

action_90 _ = happyReduce_12

action_91 _ = happyReduce_26

action_92 (53) = happyShift action_76
action_92 (54) = happyShift action_77
action_92 (19) = happyGoto action_68
action_92 _ = happyReduce_30

action_93 (55) = happyShift action_66
action_93 (56) = happyShift action_67
action_93 (20) = happyGoto action_65
action_93 _ = happyReduce_32

action_94 _ = happyReduce_35

action_95 _ = happyReduce_40

action_96 (23) = happyShift action_102
action_96 (27) = happyShift action_99
action_96 _ = happyFail

action_97 (43) = happyShift action_101
action_97 _ = happyFail

action_98 _ = happyReduce_23

action_99 (22) = happyShift action_44
action_99 (28) = happyShift action_45
action_99 (29) = happyShift action_46
action_99 (30) = happyShift action_47
action_99 (54) = happyShift action_48
action_99 (57) = happyShift action_49
action_99 (15) = happyGoto action_100
action_99 (16) = happyGoto action_41
action_99 (17) = happyGoto action_42
action_99 (18) = happyGoto action_43
action_99 _ = happyFail

action_100 _ = happyReduce_28

action_101 (28) = happyShift action_24
action_101 (36) = happyShift action_20
action_101 (37) = happyShift action_25
action_101 (41) = happyShift action_26
action_101 (44) = happyShift action_27
action_101 (11) = happyGoto action_21
action_101 (13) = happyGoto action_112
action_101 _ = happyFail

action_102 _ = happyReduce_37

action_103 _ = happyReduce_14

action_104 (6) = happyGoto action_111
action_104 _ = happyReduce_4

action_105 (36) = happyShift action_20
action_105 (39) = happyShift action_14
action_105 (11) = happyGoto action_110
action_105 _ = happyFail

action_106 (25) = happyShift action_109
action_106 (27) = happyShift action_9
action_106 _ = happyFail

action_107 (31) = happyShift action_34
action_107 (32) = happyShift action_35
action_107 (7) = happyGoto action_108
action_107 _ = happyFail

action_108 (24) = happyShift action_115
action_108 _ = happyFail

action_109 (31) = happyShift action_34
action_109 (32) = happyShift action_35
action_109 (7) = happyGoto action_114
action_109 _ = happyFail

action_110 _ = happyReduce_10

action_111 (36) = happyShift action_20
action_111 (39) = happyShift action_14
action_111 (11) = happyGoto action_113
action_111 _ = happyFail

action_112 _ = happyReduce_25

action_113 _ = happyReduce_13

action_114 _ = happyReduce_15

action_115 (6) = happyGoto action_116
action_115 _ = happyReduce_4

action_116 (36) = happyShift action_20
action_116 (39) = happyShift action_14
action_116 (11) = happyGoto action_117
action_116 _ = happyFail

action_117 _ = happyReduce_11

happyReduce_1 = happyReduce 10 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_9) `HappyStk`
	(HappyAbsSyn8  happy_var_8) `HappyStk`
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
happyReduction_6 _
	 =  HappyAbsSyn7
		 (RawIntType
	)

happyReduce_7 = happySpecReduce_1  7 happyReduction_7
happyReduction_7 _
	 =  HappyAbsSyn7
		 (RawRealType
	)

happyReduce_8 = happySpecReduce_0  8 happyReduction_8
happyReduction_8  =  HappyAbsSyn8
		 ([]
	)

happyReduce_9 = happySpecReduce_3  8 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2 : happy_var_1
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 7 9 happyReduction_10
happyReduction_10 ((HappyAbsSyn11  happy_var_7) `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FuncDec (toSym happy_var_2) [] happy_var_4 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 10 9 happyReduction_11
happyReduction_11 ((HappyAbsSyn11  happy_var_10) `HappyStk`
	(HappyAbsSyn6  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FuncDec (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 9 happyReduction_12
happyReduction_12 ((HappyAbsSyn11  happy_var_5) `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (ProcDec (toSym happy_var_2) [] happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 8 9 happyReduction_13
happyReduction_13 ((HappyAbsSyn11  happy_var_8) `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (ProcDec (toSym happy_var_2) happy_var_4 happy_var_7 happy_var_8
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_3  10 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (Parameter happy_var_1 happy_var_3 : []
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happyReduce 5 10 happyReduction_15
happyReduction_15 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Parameter happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_3  11 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (reverse happy_var_2
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_0  12 happyReduction_17
happyReduction_17  =  HappyAbsSyn12
		 ([]
	)

happyReduce_18 = happySpecReduce_1  12 happyReduction_18
happyReduction_18 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  12 happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_3 : happy_var_1
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  13 happyReduction_20
happyReduction_20 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (Assignment (toSym happy_var_1) happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  13 happyReduction_21
happyReduction_21 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Return happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  13 happyReduction_22
happyReduction_22 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (Invocation (toSym happy_var_1) []
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happyReduce 4 13 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Invocation (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_1  13 happyReduction_24
happyReduction_24 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn13
		 (Compound happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happyReduce 6 13 happyReduction_25
happyReduction_25 ((HappyAbsSyn13  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Branch happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 4 13 happyReduction_26
happyReduction_26 ((HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Loop happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_1  14 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : []
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  14 happyReduction_28
happyReduction_28 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_3 : happy_var_1
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  15 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (UnaryExpression happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  15 happyReduction_30
happyReduction_30 (HappyAbsSyn16  happy_var_3)
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (BinaryExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  16 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (TermSimpleExpression happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  16 happyReduction_32
happyReduction_32 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (OpSimpleExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  17 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (FactorTerm happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  17 happyReduction_34
happyReduction_34 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (NegTerm happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  17 happyReduction_35
happyReduction_35 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  18 happyReduction_36
happyReduction_36 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (ArrayAccessFactor (toSym happy_var_1)
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happyReduce 4 18 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (InvocationFactor (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_1  18 happyReduction_38
happyReduction_38 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  18 happyReduction_39
happyReduction_39 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  18 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (SubFactor happy_var_2
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  18 happyReduction_41
happyReduction_41 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (NotFactor happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  19 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn19
		 (Plus
	)

happyReduce_43 = happySpecReduce_1  19 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn19
		 (Minus
	)

happyReduce_44 = happySpecReduce_1  20 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn20
		 (Mul
	)

happyReduce_45 = happySpecReduce_1  20 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn20
		 (Div
	)

happyReduce_46 = happySpecReduce_1  21 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn21
		 (S
	)

happyReduce_47 = happySpecReduce_1  21 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn21
		 (L
	)

happyReduce_48 = happySpecReduce_1  21 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn21
		 (E
	)

happyReduce_49 = happySpecReduce_1  21 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn21
		 (SE
	)

happyReduce_50 = happySpecReduce_1  21 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn21
		 (LE
	)

happyReduce_51 = happySpecReduce_1  21 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn21
		 (NE
	)

happyNewToken action sts stk [] =
	action 59 59 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token TokLParen _ -> cont 22;
	Token TokRParen _ -> cont 23;
	Token TokSemicolon _ -> cont 24;
	Token TokColon _ -> cont 25;
	Token TokPeriod _ -> cont 26;
	Token TokComma _ -> cont 27;
	Token (TokID _) _ -> cont 28;
	Token (TokInt _) _ -> cont 29;
	Token (TokReal _) _ -> cont 30;
	Token TokTypeInt _ -> cont 31;
	Token TokTypeReal _ -> cont 32;
	Token TokProgram _ -> cont 33;
	Token TokFunction _ -> cont 34;
	Token TokProc _ -> cont 35;
	Token TokBegin _ -> cont 36;
	Token TokReturn _ -> cont 37;
	Token TokEnd _ -> cont 38;
	Token TokVar _ -> cont 39;
	Token TokOf _ -> cont 40;
	Token TokIf _ -> cont 41;
	Token TokThen _ -> cont 42;
	Token TokElse _ -> cont 43;
	Token TokWhile _ -> cont 44;
	Token TokDo _ -> cont 45;
	Token TokAssign _ -> cont 46;
	Token TokS _ -> cont 47;
	Token TokL _ -> cont 48;
	Token TokSE _ -> cont 49;
	Token TokLE _ -> cont 50;
	Token TokEq _ -> cont 51;
	Token TokNEq _ -> cont 52;
	Token TokPlus _ -> cont 53;
	Token TokMinus _ -> cont 54;
	Token TokTimes _ -> cont 55;
	Token TokDiv _ -> cont 56;
	Token TokNot _ -> cont 57;
	Token TokTo _ -> cont 58;
	_ -> happyError' (tk:tks)
	}

happyError_ 59 tk tks = happyError' tks
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

