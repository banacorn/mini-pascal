{-# OPTIONS_GHC -w #-}
module Compiler.Syntax.Parser where

import Compiler.Syntax.Type
import Compiler.PreAST.Type
import Compiler.Type.Pipeline
import Compiler.Syntax.Lexer
import Control.Monad.Except
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

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

action_0 (34) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail

action_1 (34) = happyShift action_2
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
action_12 _ = happyReduce_9

action_13 (35) = happyShift action_18
action_13 (36) = happyShift action_19
action_13 (9) = happyGoto action_16
action_13 (11) = happyGoto action_17
action_13 _ = happyFail

action_14 (28) = happyShift action_7
action_14 (5) = happyGoto action_15
action_14 _ = happyFail

action_15 (25) = happyShift action_30
action_15 (27) = happyShift action_9
action_15 _ = happyFail

action_16 (24) = happyShift action_29
action_16 _ = happyFail

action_17 (26) = happyShift action_28
action_17 _ = happyFail

action_18 (28) = happyShift action_27
action_18 _ = happyFail

action_19 (28) = happyShift action_23
action_19 (36) = happyShift action_19
action_19 (37) = happyShift action_24
action_19 (41) = happyShift action_25
action_19 (44) = happyShift action_26
action_19 (11) = happyGoto action_20
action_19 (12) = happyGoto action_21
action_19 (13) = happyGoto action_22
action_19 _ = happyReduce_16

action_20 _ = happyReduce_23

action_21 (24) = happyShift action_51
action_21 (38) = happyShift action_52
action_21 _ = happyFail

action_22 _ = happyReduce_17

action_23 (22) = happyShift action_49
action_23 (46) = happyShift action_50
action_23 _ = happyReduce_21

action_24 (22) = happyShift action_41
action_24 (28) = happyShift action_42
action_24 (29) = happyShift action_43
action_24 (30) = happyShift action_44
action_24 (54) = happyShift action_45
action_24 (57) = happyShift action_46
action_24 (15) = happyGoto action_48
action_24 (16) = happyGoto action_38
action_24 (17) = happyGoto action_39
action_24 (18) = happyGoto action_40
action_24 _ = happyFail

action_25 (22) = happyShift action_41
action_25 (28) = happyShift action_42
action_25 (29) = happyShift action_43
action_25 (30) = happyShift action_44
action_25 (54) = happyShift action_45
action_25 (57) = happyShift action_46
action_25 (15) = happyGoto action_47
action_25 (16) = happyGoto action_38
action_25 (17) = happyGoto action_39
action_25 (18) = happyGoto action_40
action_25 _ = happyFail

action_26 (22) = happyShift action_41
action_26 (28) = happyShift action_42
action_26 (29) = happyShift action_43
action_26 (30) = happyShift action_44
action_26 (54) = happyShift action_45
action_26 (57) = happyShift action_46
action_26 (15) = happyGoto action_37
action_26 (16) = happyGoto action_38
action_26 (17) = happyGoto action_39
action_26 (18) = happyGoto action_40
action_26 _ = happyFail

action_27 (22) = happyShift action_35
action_27 (25) = happyShift action_36
action_27 _ = happyFail

action_28 _ = happyReduce_1

action_29 _ = happyReduce_10

action_30 (31) = happyShift action_32
action_30 (32) = happyShift action_33
action_30 (33) = happyShift action_34
action_30 (7) = happyGoto action_31
action_30 _ = happyFail

action_31 (24) = happyShift action_79
action_31 _ = happyFail

action_32 _ = happyReduce_6

action_33 _ = happyReduce_7

action_34 _ = happyReduce_8

action_35 (28) = happyShift action_7
action_35 (5) = happyGoto action_77
action_35 (10) = happyGoto action_78
action_35 _ = happyFail

action_36 (31) = happyShift action_32
action_36 (32) = happyShift action_33
action_36 (33) = happyShift action_34
action_36 (7) = happyGoto action_76
action_36 _ = happyFail

action_37 (45) = happyShift action_75
action_37 _ = happyFail

action_38 (47) = happyShift action_67
action_38 (48) = happyShift action_68
action_38 (49) = happyShift action_69
action_38 (50) = happyShift action_70
action_38 (51) = happyShift action_71
action_38 (52) = happyShift action_72
action_38 (53) = happyShift action_73
action_38 (54) = happyShift action_74
action_38 (19) = happyGoto action_65
action_38 (21) = happyGoto action_66
action_38 _ = happyReduce_28

action_39 (55) = happyShift action_63
action_39 (56) = happyShift action_64
action_39 (20) = happyGoto action_62
action_39 _ = happyReduce_30

action_40 _ = happyReduce_32

action_41 (22) = happyShift action_41
action_41 (28) = happyShift action_42
action_41 (29) = happyShift action_43
action_41 (30) = happyShift action_44
action_41 (54) = happyShift action_45
action_41 (57) = happyShift action_46
action_41 (15) = happyGoto action_61
action_41 (16) = happyGoto action_38
action_41 (17) = happyGoto action_39
action_41 (18) = happyGoto action_40
action_41 _ = happyFail

action_42 (22) = happyShift action_60
action_42 _ = happyReduce_35

action_43 _ = happyReduce_37

action_44 _ = happyReduce_38

action_45 (22) = happyShift action_41
action_45 (28) = happyShift action_42
action_45 (29) = happyShift action_43
action_45 (30) = happyShift action_44
action_45 (57) = happyShift action_46
action_45 (18) = happyGoto action_59
action_45 _ = happyFail

action_46 (22) = happyShift action_41
action_46 (28) = happyShift action_42
action_46 (29) = happyShift action_43
action_46 (30) = happyShift action_44
action_46 (57) = happyShift action_46
action_46 (18) = happyGoto action_58
action_46 _ = happyFail

action_47 (42) = happyShift action_57
action_47 _ = happyFail

action_48 _ = happyReduce_20

action_49 (22) = happyShift action_41
action_49 (28) = happyShift action_42
action_49 (29) = happyShift action_43
action_49 (30) = happyShift action_44
action_49 (54) = happyShift action_45
action_49 (57) = happyShift action_46
action_49 (14) = happyGoto action_55
action_49 (15) = happyGoto action_56
action_49 (16) = happyGoto action_38
action_49 (17) = happyGoto action_39
action_49 (18) = happyGoto action_40
action_49 _ = happyFail

action_50 (22) = happyShift action_41
action_50 (28) = happyShift action_42
action_50 (29) = happyShift action_43
action_50 (30) = happyShift action_44
action_50 (54) = happyShift action_45
action_50 (57) = happyShift action_46
action_50 (15) = happyGoto action_54
action_50 (16) = happyGoto action_38
action_50 (17) = happyGoto action_39
action_50 (18) = happyGoto action_40
action_50 _ = happyFail

action_51 (28) = happyShift action_23
action_51 (36) = happyShift action_19
action_51 (37) = happyShift action_24
action_51 (41) = happyShift action_25
action_51 (44) = happyShift action_26
action_51 (11) = happyGoto action_20
action_51 (13) = happyGoto action_53
action_51 _ = happyFail

action_52 _ = happyReduce_15

action_53 _ = happyReduce_18

action_54 _ = happyReduce_19

action_55 (23) = happyShift action_91
action_55 (27) = happyShift action_92
action_55 _ = happyFail

action_56 _ = happyReduce_26

action_57 (28) = happyShift action_23
action_57 (36) = happyShift action_19
action_57 (37) = happyShift action_24
action_57 (41) = happyShift action_25
action_57 (44) = happyShift action_26
action_57 (11) = happyGoto action_20
action_57 (13) = happyGoto action_90
action_57 _ = happyFail

action_58 _ = happyReduce_40

action_59 _ = happyReduce_33

action_60 (22) = happyShift action_41
action_60 (28) = happyShift action_42
action_60 (29) = happyShift action_43
action_60 (30) = happyShift action_44
action_60 (54) = happyShift action_45
action_60 (57) = happyShift action_46
action_60 (14) = happyGoto action_89
action_60 (15) = happyGoto action_56
action_60 (16) = happyGoto action_38
action_60 (17) = happyGoto action_39
action_60 (18) = happyGoto action_40
action_60 _ = happyFail

action_61 (23) = happyShift action_88
action_61 _ = happyFail

action_62 (22) = happyShift action_41
action_62 (28) = happyShift action_42
action_62 (29) = happyShift action_43
action_62 (30) = happyShift action_44
action_62 (57) = happyShift action_46
action_62 (18) = happyGoto action_87
action_62 _ = happyFail

action_63 _ = happyReduce_43

action_64 _ = happyReduce_44

action_65 (22) = happyShift action_41
action_65 (28) = happyShift action_42
action_65 (29) = happyShift action_43
action_65 (30) = happyShift action_44
action_65 (54) = happyShift action_45
action_65 (57) = happyShift action_46
action_65 (17) = happyGoto action_86
action_65 (18) = happyGoto action_40
action_65 _ = happyFail

action_66 (22) = happyShift action_41
action_66 (28) = happyShift action_42
action_66 (29) = happyShift action_43
action_66 (30) = happyShift action_44
action_66 (54) = happyShift action_45
action_66 (57) = happyShift action_46
action_66 (16) = happyGoto action_85
action_66 (17) = happyGoto action_39
action_66 (18) = happyGoto action_40
action_66 _ = happyFail

action_67 _ = happyReduce_45

action_68 _ = happyReduce_46

action_69 _ = happyReduce_48

action_70 _ = happyReduce_49

action_71 _ = happyReduce_47

action_72 _ = happyReduce_50

action_73 _ = happyReduce_41

action_74 _ = happyReduce_42

action_75 (28) = happyShift action_23
action_75 (36) = happyShift action_19
action_75 (37) = happyShift action_24
action_75 (41) = happyShift action_25
action_75 (44) = happyShift action_26
action_75 (11) = happyGoto action_20
action_75 (13) = happyGoto action_84
action_75 _ = happyFail

action_76 (24) = happyShift action_83
action_76 _ = happyFail

action_77 (25) = happyShift action_82
action_77 (27) = happyShift action_9
action_77 _ = happyFail

action_78 (23) = happyShift action_80
action_78 (24) = happyShift action_81
action_78 _ = happyFail

action_79 _ = happyReduce_5

action_80 (25) = happyShift action_99
action_80 _ = happyFail

action_81 (28) = happyShift action_7
action_81 (5) = happyGoto action_98
action_81 _ = happyFail

action_82 (31) = happyShift action_32
action_82 (32) = happyShift action_33
action_82 (33) = happyShift action_34
action_82 (7) = happyGoto action_97
action_82 _ = happyFail

action_83 (6) = happyGoto action_96
action_83 _ = happyReduce_4

action_84 _ = happyReduce_25

action_85 (53) = happyShift action_73
action_85 (54) = happyShift action_74
action_85 (19) = happyGoto action_65
action_85 _ = happyReduce_29

action_86 (55) = happyShift action_63
action_86 (56) = happyShift action_64
action_86 (20) = happyGoto action_62
action_86 _ = happyReduce_31

action_87 _ = happyReduce_34

action_88 _ = happyReduce_39

action_89 (23) = happyShift action_95
action_89 (27) = happyShift action_92
action_89 _ = happyFail

action_90 (43) = happyShift action_94
action_90 _ = happyFail

action_91 _ = happyReduce_22

action_92 (22) = happyShift action_41
action_92 (28) = happyShift action_42
action_92 (29) = happyShift action_43
action_92 (30) = happyShift action_44
action_92 (54) = happyShift action_45
action_92 (57) = happyShift action_46
action_92 (15) = happyGoto action_93
action_92 (16) = happyGoto action_38
action_92 (17) = happyGoto action_39
action_92 (18) = happyGoto action_40
action_92 _ = happyFail

action_93 _ = happyReduce_27

action_94 (28) = happyShift action_23
action_94 (36) = happyShift action_19
action_94 (37) = happyShift action_24
action_94 (41) = happyShift action_25
action_94 (44) = happyShift action_26
action_94 (11) = happyGoto action_20
action_94 (13) = happyGoto action_103
action_94 _ = happyFail

action_95 _ = happyReduce_36

action_96 (36) = happyShift action_19
action_96 (39) = happyShift action_14
action_96 (11) = happyGoto action_102
action_96 _ = happyFail

action_97 _ = happyReduce_13

action_98 (25) = happyShift action_101
action_98 (27) = happyShift action_9
action_98 _ = happyFail

action_99 (31) = happyShift action_32
action_99 (32) = happyShift action_33
action_99 (33) = happyShift action_34
action_99 (7) = happyGoto action_100
action_99 _ = happyFail

action_100 (24) = happyShift action_105
action_100 _ = happyFail

action_101 (31) = happyShift action_32
action_101 (32) = happyShift action_33
action_101 (33) = happyShift action_34
action_101 (7) = happyGoto action_104
action_101 _ = happyFail

action_102 _ = happyReduce_11

action_103 _ = happyReduce_24

action_104 _ = happyReduce_14

action_105 (6) = happyGoto action_106
action_105 _ = happyReduce_4

action_106 (36) = happyShift action_19
action_106 (39) = happyShift action_14
action_106 (11) = happyGoto action_107
action_106 _ = happyFail

action_107 _ = happyReduce_12

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
		 (RawProgram (toSym happy_var_2) (reverse happy_var_4) (reverse happy_var_7) (reverse happy_var_8 ++ [FuncDec (Symbol "main" Unknown) [] RawVoidType [] happy_var_9])
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

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn7
		 (RawVoidType
	)

happyReduce_9 = happySpecReduce_0  8 happyReduction_9
happyReduction_9  =  HappyAbsSyn8
		 ([]
	)

happyReduce_10 = happySpecReduce_3  8 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2 : happy_var_1
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 7 9 happyReduction_11
happyReduction_11 ((HappyAbsSyn11  happy_var_7) `HappyStk`
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

happyReduce_12 = happyReduce 10 9 happyReduction_12
happyReduction_12 ((HappyAbsSyn11  happy_var_10) `HappyStk`
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
		 (FuncDec (toSym happy_var_2) (reverse happy_var_4) happy_var_7 happy_var_9 happy_var_10
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_3  10 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (Parameter happy_var_1 happy_var_3 : []
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 10 happyReduction_14
happyReduction_14 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Parameter happy_var_3 happy_var_5 : happy_var_1
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_3  11 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (reverse happy_var_2
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_0  12 happyReduction_16
happyReduction_16  =  HappyAbsSyn12
		 ([]
	)

happyReduce_17 = happySpecReduce_1  12 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  12 happyReduction_18
happyReduction_18 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_3 : happy_var_1
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  13 happyReduction_19
happyReduction_19 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (Assignment (toSym happy_var_1) happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  13 happyReduction_20
happyReduction_20 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Return happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (Invocation (toSym happy_var_1) []
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happyReduce 4 13 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Invocation (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  13 happyReduction_23
happyReduction_23 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn13
		 (Compound happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happyReduce 6 13 happyReduction_24
happyReduction_24 ((HappyAbsSyn13  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Branch happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 4 13 happyReduction_25
happyReduction_25 ((HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Loop happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : []
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  14 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_3 : happy_var_1
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  15 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (UnaryExpression happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_3)
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (BinaryExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (TermSimpleExpression happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  16 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_3)
	(HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (OpSimpleExpression happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (FactorTerm happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  17 happyReduction_33
happyReduction_33 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (NegTerm happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  17 happyReduction_34
happyReduction_34 (HappyAbsSyn18  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (OpTerm happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (VariableFactor (toSym happy_var_1)
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happyReduce 4 18 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (InvocationFactor (toSym happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1  18 happyReduction_37
happyReduction_37 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  18 happyReduction_38
happyReduction_38 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn18
		 (NumberFactor (toLiteral happy_var_1)
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  18 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (SubFactor happy_var_2
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  18 happyReduction_40
happyReduction_40 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (NotFactor happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  19 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn19
		 (Plus
	)

happyReduce_42 = happySpecReduce_1  19 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn19
		 (Minus
	)

happyReduce_43 = happySpecReduce_1  20 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn20
		 (Mul
	)

happyReduce_44 = happySpecReduce_1  20 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn20
		 (Div
	)

happyReduce_45 = happySpecReduce_1  21 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn21
		 (S
	)

happyReduce_46 = happySpecReduce_1  21 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn21
		 (L
	)

happyReduce_47 = happySpecReduce_1  21 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn21
		 (E
	)

happyReduce_48 = happySpecReduce_1  21 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn21
		 (SE
	)

happyReduce_49 = happySpecReduce_1  21 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn21
		 (LE
	)

happyReduce_50 = happySpecReduce_1  21 happyReduction_50
happyReduction_50 _
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
	Token TokTypeVoid _ -> cont 33;
	Token TokProgram _ -> cont 34;
	Token TokFunction _ -> cont 35;
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
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

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

{-# LINE 256 "templates/GenericTemplate.hs" #-}
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

{-# LINE 322 "templates/GenericTemplate.hs" #-}
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
