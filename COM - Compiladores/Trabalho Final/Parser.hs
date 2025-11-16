{-# OPTIONS_GHC -w #-}
module Parser where

import Token
import RI
import qualified Lex as L
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31
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
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,403) ([0,0,1024,3840,0,0,2352,6144,0,0,0,49152,0,0,0,0,0,0,0,960,252,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18816,32768,0,0,12288,9,24,0,0,294,768,0,0,8192,0,0,0,0,0,0,0,0,2048,7680,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,7902,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48128,61,0,0,0,0,0,0,0,16,0,0,8192,49664,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,32768,0,128,0,57344,2066,32,0,0,512,0,0,0,16384,0,0,0,0,8,0,0,0,256,0,0,0,8192,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,23552,6,4,0,0,0,0,0,0,4096,1536,0,0,61440,16130,0,0,0,0,0,0,0,1176,2048,0,0,37632,0,1,0,24576,18,32,0,0,588,1024,0,0,18816,32768,0,0,12288,9,16,0,0,294,512,0,0,9408,16384,0,0,38912,4,8,0,0,147,256,0,0,4704,8192,0,0,19456,2,6,0,32768,73,192,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,960,0,0,0,30720,0,0,0,0,15,0,0,0,480,0,0,0,15360,0,0,0,0,0,0,0,0,0,0,0,0,6144,0,0,0,0,3,0,0,0,376,0,0,0,0,0,0,0,0,0,0,0,0,60,0,0,0,4096,2,0,0,0,0,0,0,0,0,0,0,0,2048,28672,0,0,37632,32768,1,0,0,0,480,0,0,588,1536,0,0,19328,32768,0,0,0,0,16,0,0,33008,0,0,0,0,16,0,0,0,0,0,0,0,151,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,32768,2048,123,0,0,0,0,0,0,0,32,0,0,0,0,0,0,15360,32,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,376,0,0,0,8192,0,0,0,0,32772,1,0,0,0,128,0,0,0,4,0,0,0,0,256,0,0,64,24,0,0,2048,1,0,0,0,0,0,0,0,0,32,0,0,8192,0,0,0,0,0,0,0,28672,9,16,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,56,0,0,1024,0,0,0,2416,4096,0,0,9728,1,3,0,0,0,8192,0,0,16384,0,0,0,0,64,0,0,0,2048,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15748,0,32768,75,128,0,0,0,1540,0,0,61440,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,32768,7,0,32768,7,0,0,0,0,0,0,0,0,16388,984,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","ExprL","ExprR","Expr","Programa","ListaFuncoes","Funcao","TipoRetorno","DeclParametros","Parametro","BlocoPrincipal","Declaracoes","Declaracao","Tipo","ListaId","Bloco","ListaCmd","Comando","Retorno","CmdSe","CmdEnquanto","CmdFor","CmdAtrib","AtribSimples","CmdEscrita","CmdLeitura","ChamadaProc","ChamadaFuncao","ListaParametros","CInt","CDouble","literal","'+'","'-'","'*'","'/'","'('","')'","'['","']'","'{'","'}'","','","';'","'>='","'<='","'<'","'>'","'=='","'!='","'&&'","'||'","'!'","id","int","string","double","void","return","read","'='","print","while","for","if","else","%eof"]
        bit_start = st * 69
        bit_end = (st + 1) * 69
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..68]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (43) = happyShift action_18
action_0 (57) = happyShift action_19
action_0 (58) = happyShift action_20
action_0 (59) = happyShift action_21
action_0 (60) = happyShift action_22
action_0 (7) = happyGoto action_12
action_0 (8) = happyGoto action_13
action_0 (9) = happyGoto action_14
action_0 (10) = happyGoto action_15
action_0 (13) = happyGoto action_16
action_0 (16) = happyGoto action_17
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (32) = happyShift action_6
action_1 (33) = happyShift action_7
action_1 (36) = happyShift action_8
action_1 (39) = happyShift action_9
action_1 (55) = happyShift action_10
action_1 (56) = happyShift action_11
action_1 (4) = happyGoto action_2
action_1 (5) = happyGoto action_3
action_1 (6) = happyGoto action_4
action_1 (30) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (53) = happyShift action_63
action_2 (54) = happyShift action_64
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_5

action_4 (35) = happyShift action_53
action_4 (36) = happyShift action_54
action_4 (37) = happyShift action_55
action_4 (38) = happyShift action_56
action_4 (47) = happyShift action_57
action_4 (48) = happyShift action_58
action_4 (49) = happyShift action_59
action_4 (50) = happyShift action_60
action_4 (51) = happyShift action_61
action_4 (52) = happyShift action_62
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_20

action_6 _ = happyReduce_18

action_7 _ = happyReduce_19

action_8 (32) = happyShift action_6
action_8 (33) = happyShift action_7
action_8 (36) = happyShift action_8
action_8 (39) = happyShift action_52
action_8 (56) = happyShift action_11
action_8 (6) = happyGoto action_51
action_8 (30) = happyGoto action_5
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (32) = happyShift action_6
action_9 (33) = happyShift action_7
action_9 (36) = happyShift action_8
action_9 (39) = happyShift action_9
action_9 (55) = happyShift action_10
action_9 (56) = happyShift action_11
action_9 (4) = happyGoto action_49
action_9 (5) = happyGoto action_3
action_9 (6) = happyGoto action_50
action_9 (30) = happyGoto action_5
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (32) = happyShift action_6
action_10 (33) = happyShift action_7
action_10 (36) = happyShift action_8
action_10 (39) = happyShift action_9
action_10 (55) = happyShift action_10
action_10 (56) = happyShift action_11
action_10 (4) = happyGoto action_48
action_10 (5) = happyGoto action_3
action_10 (6) = happyGoto action_4
action_10 (30) = happyGoto action_5
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (39) = happyShift action_47
action_11 _ = happyReduce_21

action_12 (69) = happyAccept
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (43) = happyShift action_18
action_13 (57) = happyShift action_19
action_13 (58) = happyShift action_20
action_13 (59) = happyShift action_21
action_13 (60) = happyShift action_22
action_13 (9) = happyGoto action_45
action_13 (10) = happyGoto action_15
action_13 (13) = happyGoto action_46
action_13 (16) = happyGoto action_17
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_25

action_15 (56) = happyShift action_44
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_23

action_17 _ = happyReduce_28

action_18 (56) = happyShift action_37
action_18 (57) = happyShift action_19
action_18 (58) = happyShift action_20
action_18 (59) = happyShift action_21
action_18 (61) = happyShift action_38
action_18 (62) = happyShift action_39
action_18 (64) = happyShift action_40
action_18 (65) = happyShift action_41
action_18 (66) = happyShift action_42
action_18 (67) = happyShift action_43
action_18 (14) = happyGoto action_23
action_18 (15) = happyGoto action_24
action_18 (16) = happyGoto action_25
action_18 (19) = happyGoto action_26
action_18 (20) = happyGoto action_27
action_18 (21) = happyGoto action_28
action_18 (22) = happyGoto action_29
action_18 (23) = happyGoto action_30
action_18 (24) = happyGoto action_31
action_18 (25) = happyGoto action_32
action_18 (27) = happyGoto action_33
action_18 (28) = happyGoto action_34
action_18 (29) = happyGoto action_35
action_18 (30) = happyGoto action_36
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_38

action_20 _ = happyReduce_39

action_21 _ = happyReduce_40

action_22 _ = happyReduce_29

action_23 (56) = happyShift action_37
action_23 (57) = happyShift action_19
action_23 (58) = happyShift action_20
action_23 (59) = happyShift action_21
action_23 (61) = happyShift action_38
action_23 (62) = happyShift action_39
action_23 (64) = happyShift action_40
action_23 (65) = happyShift action_41
action_23 (66) = happyShift action_42
action_23 (67) = happyShift action_43
action_23 (15) = happyGoto action_99
action_23 (16) = happyGoto action_25
action_23 (19) = happyGoto action_100
action_23 (20) = happyGoto action_27
action_23 (21) = happyGoto action_28
action_23 (22) = happyGoto action_29
action_23 (23) = happyGoto action_30
action_23 (24) = happyGoto action_31
action_23 (25) = happyGoto action_32
action_23 (27) = happyGoto action_33
action_23 (28) = happyGoto action_34
action_23 (29) = happyGoto action_35
action_23 (30) = happyGoto action_36
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_36

action_25 (56) = happyShift action_98
action_25 (17) = happyGoto action_97
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (44) = happyShift action_96
action_26 (56) = happyShift action_37
action_26 (61) = happyShift action_38
action_26 (62) = happyShift action_39
action_26 (64) = happyShift action_40
action_26 (65) = happyShift action_41
action_26 (66) = happyShift action_42
action_26 (67) = happyShift action_43
action_26 (20) = happyGoto action_95
action_26 (21) = happyGoto action_28
action_26 (22) = happyGoto action_29
action_26 (23) = happyGoto action_30
action_26 (24) = happyGoto action_31
action_26 (25) = happyGoto action_32
action_26 (27) = happyGoto action_33
action_26 (28) = happyGoto action_34
action_26 (29) = happyGoto action_35
action_26 (30) = happyGoto action_36
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_45

action_28 _ = happyReduce_53

action_29 _ = happyReduce_46

action_30 _ = happyReduce_47

action_31 _ = happyReduce_48

action_32 _ = happyReduce_49

action_33 _ = happyReduce_50

action_34 _ = happyReduce_51

action_35 _ = happyReduce_52

action_36 (46) = happyShift action_94
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (39) = happyShift action_47
action_37 (63) = happyShift action_93
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (32) = happyShift action_6
action_38 (33) = happyShift action_7
action_38 (34) = happyShift action_91
action_38 (36) = happyShift action_8
action_38 (39) = happyShift action_52
action_38 (46) = happyShift action_92
action_38 (56) = happyShift action_11
action_38 (6) = happyGoto action_90
action_38 (30) = happyGoto action_5
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (39) = happyShift action_89
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (39) = happyShift action_88
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (39) = happyShift action_87
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (39) = happyShift action_86
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (39) = happyShift action_85
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (39) = happyShift action_84
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_24

action_46 _ = happyReduce_22

action_47 (32) = happyShift action_6
action_47 (33) = happyShift action_7
action_47 (34) = happyShift action_82
action_47 (36) = happyShift action_8
action_47 (39) = happyShift action_52
action_47 (40) = happyShift action_83
action_47 (56) = happyShift action_11
action_47 (6) = happyGoto action_80
action_47 (30) = happyGoto action_5
action_47 (31) = happyGoto action_81
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_3

action_49 (40) = happyShift action_79
action_49 (53) = happyShift action_63
action_49 (54) = happyShift action_64
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (35) = happyShift action_53
action_50 (36) = happyShift action_54
action_50 (37) = happyShift action_55
action_50 (38) = happyShift action_56
action_50 (40) = happyShift action_78
action_50 (47) = happyShift action_57
action_50 (48) = happyShift action_58
action_50 (49) = happyShift action_59
action_50 (50) = happyShift action_60
action_50 (51) = happyShift action_61
action_50 (52) = happyShift action_62
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_16

action_52 (32) = happyShift action_6
action_52 (33) = happyShift action_7
action_52 (36) = happyShift action_8
action_52 (39) = happyShift action_52
action_52 (56) = happyShift action_11
action_52 (6) = happyGoto action_77
action_52 (30) = happyGoto action_5
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (32) = happyShift action_6
action_53 (33) = happyShift action_7
action_53 (36) = happyShift action_8
action_53 (39) = happyShift action_52
action_53 (56) = happyShift action_11
action_53 (6) = happyGoto action_76
action_53 (30) = happyGoto action_5
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (32) = happyShift action_6
action_54 (33) = happyShift action_7
action_54 (36) = happyShift action_8
action_54 (39) = happyShift action_52
action_54 (56) = happyShift action_11
action_54 (6) = happyGoto action_75
action_54 (30) = happyGoto action_5
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (32) = happyShift action_6
action_55 (33) = happyShift action_7
action_55 (36) = happyShift action_8
action_55 (39) = happyShift action_52
action_55 (56) = happyShift action_11
action_55 (6) = happyGoto action_74
action_55 (30) = happyGoto action_5
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (32) = happyShift action_6
action_56 (33) = happyShift action_7
action_56 (36) = happyShift action_8
action_56 (39) = happyShift action_52
action_56 (56) = happyShift action_11
action_56 (6) = happyGoto action_73
action_56 (30) = happyGoto action_5
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (32) = happyShift action_6
action_57 (33) = happyShift action_7
action_57 (36) = happyShift action_8
action_57 (39) = happyShift action_52
action_57 (56) = happyShift action_11
action_57 (6) = happyGoto action_72
action_57 (30) = happyGoto action_5
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (32) = happyShift action_6
action_58 (33) = happyShift action_7
action_58 (36) = happyShift action_8
action_58 (39) = happyShift action_52
action_58 (56) = happyShift action_11
action_58 (6) = happyGoto action_71
action_58 (30) = happyGoto action_5
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (32) = happyShift action_6
action_59 (33) = happyShift action_7
action_59 (36) = happyShift action_8
action_59 (39) = happyShift action_52
action_59 (56) = happyShift action_11
action_59 (6) = happyGoto action_70
action_59 (30) = happyGoto action_5
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (32) = happyShift action_6
action_60 (33) = happyShift action_7
action_60 (36) = happyShift action_8
action_60 (39) = happyShift action_52
action_60 (56) = happyShift action_11
action_60 (6) = happyGoto action_69
action_60 (30) = happyGoto action_5
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (32) = happyShift action_6
action_61 (33) = happyShift action_7
action_61 (36) = happyShift action_8
action_61 (39) = happyShift action_52
action_61 (56) = happyShift action_11
action_61 (6) = happyGoto action_68
action_61 (30) = happyGoto action_5
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (32) = happyShift action_6
action_62 (33) = happyShift action_7
action_62 (36) = happyShift action_8
action_62 (39) = happyShift action_52
action_62 (56) = happyShift action_11
action_62 (6) = happyGoto action_67
action_62 (30) = happyGoto action_5
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (32) = happyShift action_6
action_63 (33) = happyShift action_7
action_63 (36) = happyShift action_8
action_63 (39) = happyShift action_9
action_63 (55) = happyShift action_10
action_63 (56) = happyShift action_11
action_63 (4) = happyGoto action_66
action_63 (5) = happyGoto action_3
action_63 (6) = happyGoto action_4
action_63 (30) = happyGoto action_5
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (32) = happyShift action_6
action_64 (33) = happyShift action_7
action_64 (36) = happyShift action_8
action_64 (39) = happyShift action_9
action_64 (55) = happyShift action_10
action_64 (56) = happyShift action_11
action_64 (4) = happyGoto action_65
action_64 (5) = happyGoto action_3
action_64 (6) = happyGoto action_4
action_64 (30) = happyGoto action_5
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_2

action_66 _ = happyReduce_1

action_67 (35) = happyShift action_53
action_67 (36) = happyShift action_54
action_67 (37) = happyShift action_55
action_67 (38) = happyShift action_56
action_67 _ = happyReduce_7

action_68 (35) = happyShift action_53
action_68 (36) = happyShift action_54
action_68 (37) = happyShift action_55
action_68 (38) = happyShift action_56
action_68 _ = happyReduce_6

action_69 (35) = happyShift action_53
action_69 (36) = happyShift action_54
action_69 (37) = happyShift action_55
action_69 (38) = happyShift action_56
action_69 _ = happyReduce_8

action_70 (35) = happyShift action_53
action_70 (36) = happyShift action_54
action_70 (37) = happyShift action_55
action_70 (38) = happyShift action_56
action_70 _ = happyReduce_9

action_71 (35) = happyShift action_53
action_71 (36) = happyShift action_54
action_71 (37) = happyShift action_55
action_71 (38) = happyShift action_56
action_71 _ = happyReduce_11

action_72 (35) = happyShift action_53
action_72 (36) = happyShift action_54
action_72 (37) = happyShift action_55
action_72 (38) = happyShift action_56
action_72 _ = happyReduce_10

action_73 _ = happyReduce_15

action_74 _ = happyReduce_14

action_75 (37) = happyShift action_55
action_75 (38) = happyShift action_56
action_75 _ = happyReduce_13

action_76 (37) = happyShift action_55
action_76 (38) = happyShift action_56
action_76 _ = happyReduce_12

action_77 (35) = happyShift action_53
action_77 (36) = happyShift action_54
action_77 (37) = happyShift action_55
action_77 (38) = happyShift action_56
action_77 (40) = happyShift action_78
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_17

action_79 _ = happyReduce_4

action_80 (35) = happyShift action_53
action_80 (36) = happyShift action_54
action_80 (37) = happyShift action_55
action_80 (38) = happyShift action_56
action_80 _ = happyReduce_75

action_81 (40) = happyShift action_120
action_81 (45) = happyShift action_121
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_76

action_83 _ = happyReduce_72

action_84 (40) = happyShift action_119
action_84 (57) = happyShift action_19
action_84 (58) = happyShift action_20
action_84 (59) = happyShift action_21
action_84 (11) = happyGoto action_116
action_84 (12) = happyGoto action_117
action_84 (16) = happyGoto action_118
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (32) = happyShift action_6
action_85 (33) = happyShift action_7
action_85 (36) = happyShift action_8
action_85 (39) = happyShift action_9
action_85 (55) = happyShift action_10
action_85 (56) = happyShift action_11
action_85 (4) = happyGoto action_115
action_85 (5) = happyGoto action_3
action_85 (6) = happyGoto action_4
action_85 (30) = happyGoto action_5
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (56) = happyShift action_114
action_86 (57) = happyShift action_19
action_86 (58) = happyShift action_20
action_86 (59) = happyShift action_21
action_86 (16) = happyGoto action_112
action_86 (26) = happyGoto action_113
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (32) = happyShift action_6
action_87 (33) = happyShift action_7
action_87 (36) = happyShift action_8
action_87 (39) = happyShift action_9
action_87 (55) = happyShift action_10
action_87 (56) = happyShift action_11
action_87 (4) = happyGoto action_111
action_87 (5) = happyGoto action_3
action_87 (6) = happyGoto action_4
action_87 (30) = happyGoto action_5
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (32) = happyShift action_6
action_88 (33) = happyShift action_7
action_88 (34) = happyShift action_110
action_88 (36) = happyShift action_8
action_88 (39) = happyShift action_52
action_88 (56) = happyShift action_11
action_88 (6) = happyGoto action_109
action_88 (30) = happyGoto action_5
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (56) = happyShift action_108
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (35) = happyShift action_53
action_90 (36) = happyShift action_54
action_90 (37) = happyShift action_55
action_90 (38) = happyShift action_56
action_90 (46) = happyShift action_107
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (46) = happyShift action_106
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_56

action_93 (32) = happyShift action_6
action_93 (33) = happyShift action_7
action_93 (34) = happyShift action_105
action_93 (36) = happyShift action_8
action_93 (39) = happyShift action_52
action_93 (56) = happyShift action_11
action_93 (6) = happyGoto action_104
action_93 (30) = happyGoto action_5
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_70

action_95 _ = happyReduce_44

action_96 _ = happyReduce_34

action_97 (45) = happyShift action_102
action_97 (46) = happyShift action_103
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_42

action_99 _ = happyReduce_35

action_100 (44) = happyShift action_101
action_100 (56) = happyShift action_37
action_100 (61) = happyShift action_38
action_100 (62) = happyShift action_39
action_100 (64) = happyShift action_40
action_100 (65) = happyShift action_41
action_100 (66) = happyShift action_42
action_100 (67) = happyShift action_43
action_100 (20) = happyGoto action_95
action_100 (21) = happyGoto action_28
action_100 (22) = happyGoto action_29
action_100 (23) = happyGoto action_30
action_100 (24) = happyGoto action_31
action_100 (25) = happyGoto action_32
action_100 (27) = happyGoto action_33
action_100 (28) = happyGoto action_34
action_100 (29) = happyGoto action_35
action_100 (30) = happyGoto action_36
action_100 _ = happyFail (happyExpListPerState 100)

action_101 _ = happyReduce_33

action_102 (56) = happyShift action_138
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_37

action_104 (35) = happyShift action_53
action_104 (36) = happyShift action_54
action_104 (37) = happyShift action_55
action_104 (38) = happyShift action_56
action_104 (46) = happyShift action_137
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (46) = happyShift action_136
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_55

action_107 _ = happyReduce_54

action_108 (40) = happyShift action_135
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (35) = happyShift action_53
action_109 (36) = happyShift action_54
action_109 (37) = happyShift action_55
action_109 (38) = happyShift action_56
action_109 (40) = happyShift action_134
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (40) = happyShift action_133
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (40) = happyShift action_132
action_111 (53) = happyShift action_63
action_111 (54) = happyShift action_64
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (56) = happyShift action_131
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (46) = happyShift action_130
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (63) = happyShift action_129
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (40) = happyShift action_128
action_115 (53) = happyShift action_63
action_115 (54) = happyShift action_64
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (40) = happyShift action_126
action_116 (45) = happyShift action_127
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_31

action_118 (56) = happyShift action_125
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (43) = happyShift action_18
action_119 (13) = happyGoto action_124
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_71

action_121 (32) = happyShift action_6
action_121 (33) = happyShift action_7
action_121 (34) = happyShift action_123
action_121 (36) = happyShift action_8
action_121 (39) = happyShift action_52
action_121 (56) = happyShift action_11
action_121 (6) = happyGoto action_122
action_121 (30) = happyGoto action_5
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (35) = happyShift action_53
action_122 (36) = happyShift action_54
action_122 (37) = happyShift action_55
action_122 (38) = happyShift action_56
action_122 _ = happyReduce_73

action_123 _ = happyReduce_74

action_124 _ = happyReduce_27

action_125 _ = happyReduce_32

action_126 (43) = happyShift action_18
action_126 (13) = happyGoto action_150
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (57) = happyShift action_19
action_127 (58) = happyShift action_20
action_127 (59) = happyShift action_21
action_127 (12) = happyGoto action_149
action_127 (16) = happyGoto action_118
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (43) = happyShift action_143
action_128 (18) = happyGoto action_148
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (32) = happyShift action_6
action_129 (33) = happyShift action_7
action_129 (34) = happyShift action_147
action_129 (36) = happyShift action_8
action_129 (39) = happyShift action_52
action_129 (56) = happyShift action_11
action_129 (6) = happyGoto action_146
action_129 (30) = happyGoto action_5
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (32) = happyShift action_6
action_130 (33) = happyShift action_7
action_130 (36) = happyShift action_8
action_130 (39) = happyShift action_9
action_130 (55) = happyShift action_10
action_130 (56) = happyShift action_11
action_130 (4) = happyGoto action_145
action_130 (5) = happyGoto action_3
action_130 (6) = happyGoto action_4
action_130 (30) = happyGoto action_5
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (63) = happyShift action_144
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (43) = happyShift action_143
action_132 (18) = happyGoto action_142
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (46) = happyShift action_141
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (46) = happyShift action_140
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (46) = happyShift action_139
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_62

action_137 _ = happyReduce_61

action_138 _ = happyReduce_41

action_139 _ = happyReduce_69

action_140 _ = happyReduce_67

action_141 _ = happyReduce_68

action_142 _ = happyReduce_59

action_143 (56) = happyShift action_37
action_143 (61) = happyShift action_38
action_143 (62) = happyShift action_39
action_143 (64) = happyShift action_40
action_143 (65) = happyShift action_41
action_143 (66) = happyShift action_42
action_143 (67) = happyShift action_43
action_143 (19) = happyGoto action_155
action_143 (20) = happyGoto action_27
action_143 (21) = happyGoto action_28
action_143 (22) = happyGoto action_29
action_143 (23) = happyGoto action_30
action_143 (24) = happyGoto action_31
action_143 (25) = happyGoto action_32
action_143 (27) = happyGoto action_33
action_143 (28) = happyGoto action_34
action_143 (29) = happyGoto action_35
action_143 (30) = happyGoto action_36
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (32) = happyShift action_6
action_144 (33) = happyShift action_7
action_144 (34) = happyShift action_154
action_144 (36) = happyShift action_8
action_144 (39) = happyShift action_52
action_144 (56) = happyShift action_11
action_144 (6) = happyGoto action_153
action_144 (30) = happyGoto action_5
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (46) = happyShift action_152
action_145 (53) = happyShift action_63
action_145 (54) = happyShift action_64
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (35) = happyShift action_53
action_146 (36) = happyShift action_54
action_146 (37) = happyShift action_55
action_146 (38) = happyShift action_56
action_146 _ = happyReduce_63

action_147 _ = happyReduce_64

action_148 (68) = happyShift action_151
action_148 _ = happyReduce_57

action_149 _ = happyReduce_30

action_150 _ = happyReduce_26

action_151 (43) = happyShift action_143
action_151 (18) = happyGoto action_158
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (56) = happyShift action_114
action_152 (57) = happyShift action_19
action_152 (58) = happyShift action_20
action_152 (59) = happyShift action_21
action_152 (16) = happyGoto action_112
action_152 (26) = happyGoto action_157
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (35) = happyShift action_53
action_153 (36) = happyShift action_54
action_153 (37) = happyShift action_55
action_153 (38) = happyShift action_56
action_153 _ = happyReduce_65

action_154 _ = happyReduce_66

action_155 (44) = happyShift action_156
action_155 (56) = happyShift action_37
action_155 (61) = happyShift action_38
action_155 (62) = happyShift action_39
action_155 (64) = happyShift action_40
action_155 (65) = happyShift action_41
action_155 (66) = happyShift action_42
action_155 (67) = happyShift action_43
action_155 (20) = happyGoto action_95
action_155 (21) = happyGoto action_28
action_155 (22) = happyGoto action_29
action_155 (23) = happyGoto action_30
action_155 (24) = happyGoto action_31
action_155 (25) = happyGoto action_32
action_155 (27) = happyGoto action_33
action_155 (28) = happyGoto action_34
action_155 (29) = happyGoto action_35
action_155 (30) = happyGoto action_36
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_43

action_157 (40) = happyShift action_159
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_58

action_159 (43) = happyShift action_143
action_159 (18) = happyGoto action_160
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_60

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (And happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Or happy_var_1 happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Not happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Rel happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Req happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rdif happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rgt happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rlt happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rge happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rle happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Add happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  6 happyReduction_15
happyReduction_15 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Div happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Neg happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  6 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  6 happyReduction_18
happyReduction_18 (HappyTerminal (CINT happy_var_1))
	 =  HappyAbsSyn6
		 (Const (CInt happy_var_1)
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  6 happyReduction_19
happyReduction_19 (HappyTerminal (CDOUBLE happy_var_1))
	 =  HappyAbsSyn6
		 (Const (CDouble happy_var_1)
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  6 happyReduction_20
happyReduction_20 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  6 happyReduction_21
happyReduction_21 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn6
		 (IdVar happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  7 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (case happy_var_2 of
                                         BlocoPrinc v c -> Prog (map (funcaoDeFundef) happy_var_1) (map (defDeFundef) happy_var_1) v c
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  7 happyReduction_23
happyReduction_23 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn7
		 (case happy_var_1 of
                           BlocoPrinc v c -> Prog [] [] v c
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  8 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 6 9 happyReduction_26
happyReduction_26 ((HappyAbsSyn13  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FunDef (happy_var_2 :->: (happy_var_4, happy_var_1)) happy_var_6
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 5 9 happyReduction_27
happyReduction_27 ((HappyAbsSyn13  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FunDef (happy_var_2 :->: ([], happy_var_1)) happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_1  10 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  10 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn10
		 (TVoid
	)

happyReduce_30 = happySpecReduce_3  11 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  11 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  12 happyReduction_32
happyReduction_32 (HappyTerminal (ID happy_var_2))
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_2:#:(happy_var_1,0)
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 13 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (BlocoPrinc happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_3  13 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (BlocoPrinc [] happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  14 happyReduction_35
happyReduction_35 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 ++ happy_var_2
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 _
	(HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (map (\s -> s:#:(happy_var_1,0)) happy_var_2
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  16 happyReduction_38
happyReduction_38 _
	 =  HappyAbsSyn16
		 (TInt
	)

happyReduce_39 = happySpecReduce_1  16 happyReduction_39
happyReduction_39 _
	 =  HappyAbsSyn16
		 (TString
	)

happyReduce_40 = happySpecReduce_1  16 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn16
		 (TDouble
	)

happyReduce_41 = happySpecReduce_3  17 happyReduction_41
happyReduction_41 (HappyTerminal (ID happy_var_3))
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  17 happyReduction_42
happyReduction_42 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  18 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  19 happyReduction_44
happyReduction_44 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  20 happyReduction_46
happyReduction_46 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  20 happyReduction_47
happyReduction_47 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  20 happyReduction_48
happyReduction_48 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  20 happyReduction_49
happyReduction_49 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  20 happyReduction_50
happyReduction_50 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  20 happyReduction_51
happyReduction_51 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  20 happyReduction_52
happyReduction_52 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  20 happyReduction_53
happyReduction_53 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  21 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (Ret (Just happy_var_2)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  21 happyReduction_55
happyReduction_55 _
	(HappyTerminal (LITERAL happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Ret (Just (Lit happy_var_2))
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  21 happyReduction_56
happyReduction_56 _
	_
	 =  HappyAbsSyn21
		 (Ret (Nothing)
	)

happyReduce_57 = happyReduce 5 22 happyReduction_57
happyReduction_57 ((HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (If happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_58 = happyReduce 7 22 happyReduction_58
happyReduction_58 ((HappyAbsSyn18  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_59 = happyReduce 5 23 happyReduction_59
happyReduction_59 ((HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_60 = happyReduce 9 24 happyReduction_60
happyReduction_60 ((HappyAbsSyn18  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (For happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_61 = happyReduce 4 25 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Atrib happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 4 25 happyReduction_62
happyReduction_62 (_ `HappyStk`
	(HappyTerminal (LITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Atrib happy_var_1 (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_63 = happySpecReduce_3  26 happyReduction_63
happyReduction_63 (HappyAbsSyn6  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn26
		 (Atrib happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  26 happyReduction_64
happyReduction_64 (HappyTerminal (LITERAL happy_var_3))
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn26
		 (Atrib happy_var_1 (Lit happy_var_3)
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happyReduce 4 26 happyReduction_65
happyReduction_65 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Atrib happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_66 = happyReduce 4 26 happyReduction_66
happyReduction_66 ((HappyTerminal (LITERAL happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Atrib happy_var_2 (Lit happy_var_4)
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 5 27 happyReduction_67
happyReduction_67 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (Imp happy_var_3
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 5 27 happyReduction_68
happyReduction_68 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (LITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (Imp (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 5 28 happyReduction_69
happyReduction_69 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Leitura happy_var_3
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_2  29 happyReduction_70
happyReduction_70 _
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn29
		 (case happy_var_1 of
                                    Chamada id args -> Proc id args
                                    _               -> error("Chamada de funcao incorreta")
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happyReduce 4 30 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn31  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Chamada happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_3  30 happyReduction_72
happyReduction_72 _
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn30
		 (Chamada happy_var_1 []
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  31 happyReduction_73
happyReduction_73 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn31
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  31 happyReduction_74
happyReduction_74 (HappyTerminal (LITERAL happy_var_3))
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn31
		 (happy_var_1 ++ [Lit happy_var_3]
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  31 happyReduction_75
happyReduction_75 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn31
		 ([happy_var_1]
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  31 happyReduction_76
happyReduction_76 (HappyTerminal (LITERAL happy_var_1))
	 =  HappyAbsSyn31
		 ([Lit happy_var_1]
	)
happyReduction_76 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 69 69 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	CINT happy_dollar_dollar -> cont 32;
	CDOUBLE happy_dollar_dollar -> cont 33;
	LITERAL happy_dollar_dollar -> cont 34;
	ADD -> cont 35;
	SUB -> cont 36;
	MUL -> cont 37;
	DIV -> cont 38;
	LPAR -> cont 39;
	RPAR -> cont 40;
	LBRACK -> cont 41;
	RBRACK -> cont 42;
	LCBRAK -> cont 43;
	RCBRAK -> cont 44;
	COMMA -> cont 45;
	SEMICOLON -> cont 46;
	MAJEQ -> cont 47;
	MINEQ -> cont 48;
	MINOR -> cont 49;
	MAJOR -> cont 50;
	EQUAL -> cont 51;
	NEQUAL -> cont 52;
	AND -> cont 53;
	OR -> cont 54;
	NOT -> cont 55;
	ID happy_dollar_dollar -> cont 56;
	TINT -> cont 57;
	TSTRING -> cont 58;
	TDOUBLE -> cont 59;
	TVOID -> cont 60;
	TRETURN -> cont 61;
	TREAD -> cont 62;
	ATRIB -> cont 63;
	TPRINT -> cont 64;
	TWHILE -> cont 65;
	TFOR -> cont 66;
	TIF -> cont 67;
	TELSE -> cont 68;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 69 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
calc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError s = error ("Parse error:" ++ show s)

funcaoDeFundef :: FuncaoDefinicao -> Funcao
funcaoDeFundef (FunDef f c) = f

defDeFundef :: FuncaoDefinicao -> (Id, [Var], Bloco)
defDeFundef (FunDef (i:->:(v,t)) (BlocoPrinc d c)) = (i,v++d,c)

main = do putStr "Qual arquivo voce quer ler? "
          arquivo <- getLine
          s <- readFile arquivo
          print (calc (L.alexScanTokens s))
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






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
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
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
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

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
