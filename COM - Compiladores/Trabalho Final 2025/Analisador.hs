{-# OPTIONS_GHC -w #-}
module Analisador where

import Tokens
import SintaxeAbstrata
import qualified Lexico as L
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34
	= HappyTerminal (Tokens)
	| HappyErrorToken Prelude.Int
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
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,479) ([0,0,0,1,496,0,0,0,0,7936,0,0,0,256,0,0,0,0,0,0,31,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,44928,62,0,0,0,2048,0,0,0,0,32768,16032,0,0,0,0,240,0,0,0,32,0,0,0,0,0,2048,1002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,256,32256,256,0,0,0,0,0,0,0,3008,129,16512,0,0,0,16,0,0,0,0,256,0,0,0,0,4096,0,0,0,0,0,16,0,0,0,0,16,0,0,0,0,256,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,15,0,0,4284,4096,1032,0,0,0,0,128,0,0,0,0,0,64,0,0,0,32768,16032,0,0,4284,4096,1032,0,0,3008,1,16512,0,0,0,0,2048,0,0,0,33020,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3008,1,16512,0,0,48128,16,2048,4,0,0,0,0,0,0,0,4096,0,0,0,0,0,1,0,0,0,48128,48,2048,4,0,0,32768,0,0,0,0,0,8,0,0,0,3008,1,16512,0,0,48128,16,2048,4,0,49152,267,32768,64,0,0,4284,0,1032,0,0,3008,1,16512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,32768,0,0,0,0,0,4,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,4032,8,0,0,0,64512,128,0,0,0,49152,2063,0,0,0,0,33020,0,0,0,0,4032,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16636,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,48128,16,2048,4,0,0,764,0,0,0,0,0,0,0,0,0,3008,1,16512,0,0,48128,16,2048,4,0,49152,267,32768,64,0,0,4284,0,1032,0,0,3008,1,16512,0,0,48128,16,2048,4,0,0,0,0,0,0,0,8192,0,0,0,0,64512,2,0,0,0,0,32,12,0,0,0,0,0,0,0,0,4032,1008,0,0,0,3008,1,16513,0,0,48128,16,2064,4,0,0,8192,0,0,0,0,4096,0,0,0,0,0,128,0,0,0,0,0,96,16,0,0,512,192,0,0,0,0,0,8,0,0,0,2,0,0,0,0,1024,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,3840,0,0,0,256,0,0,0,0,0,0,0,0,0,0,1,0,0,0,3008,1,16513,0,0,48128,16,2064,4,0,0,0,0,0,0,0,0,0,0,0,0,3008,1,16512,0,0,48128,16,2064,4,0,49152,267,33024,64,0,0,0,0,0,0,0,0,0,0,0,0,0,32,12,0,0,0,764,63,0,0,0,4284,0,1032,0,0,3008,1,16512,0,0,48128,16,2048,4,0,49152,267,32768,64,0,0,4284,0,1032,0,0,3008,1,16512,0,0,0,256,0,0,0,0,32768,0,0,0,0,0,8,0,0,0,8192,0,0,0,0,0,2,0,0,0,0,32,0,0,0,0,512,0,0,0,0,61440,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,12224,0,0,0,0,0,0,0,0,0,48128,16,2048,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,15,0,0,0,0,252,0,0,0,0,4032,0,0,0,0,64512,0,0,0,0,49152,15,0,0,0,0,252,0,0,0,0,0,0,0,0,0,0,49154,0,0,0,0,2048,12,0,0,0,252,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,2048,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","Program","ListaFuncoes","FuncaoDefinicao","TipoRetorno","Tipo","DeclParametros","Parametro","BlocoPrincipal","Bloco","Declaracoes","Declaracao","ListaId","ListaCmd","Comando","CmdSe","CmdEnquanto","CmdDoWhile","CmdFor","CmdSimpleFor","CmdAtrib","CmdIncr","CmdDecr","CmdEscrita","CmdLeitura","ChamadaProc","Retorno","ExprL","ExprR","Expr","ChamadaF","ListaParametros","CInt","CDouble","literal","CFloat","'+'","'-'","'*'","'**'","'/'","'%'","'('","')'","'['","']'","'{'","'}'","','","';'","'>='","'<='","'<'","'>'","'=='","'!='","'&&'","'||'","'!'","'++'","'--'","'+='","'-='","'*='","'/='","id","int","float","string","double","void","return","sqr","read","'='","print","while","do","for","if","else","%eof"]
        bit_start = st Prelude.* 84
        bit_end = (st Prelude.+ 1) Prelude.* 84
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..83]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (49) = happyShift action_13
action_0 (69) = happyShift action_6
action_0 (70) = happyShift action_7
action_0 (71) = happyShift action_8
action_0 (72) = happyShift action_9
action_0 (73) = happyShift action_10
action_0 (4) = happyGoto action_11
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (11) = happyGoto action_12
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (69) = happyShift action_6
action_1 (70) = happyShift action_7
action_1 (71) = happyShift action_8
action_1 (72) = happyShift action_9
action_1 (73) = happyShift action_10
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (49) = happyShift action_13
action_2 (11) = happyGoto action_42
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (69) = happyShift action_6
action_3 (70) = happyShift action_7
action_3 (71) = happyShift action_8
action_3 (72) = happyShift action_9
action_3 (73) = happyShift action_10
action_3 (5) = happyGoto action_41
action_3 (6) = happyGoto action_3
action_3 (7) = happyGoto action_4
action_3 (8) = happyGoto action_5
action_3 _ = happyReduce_4

action_4 (68) = happyShift action_40
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_7

action_6 _ = happyReduce_10

action_7 (68) = happyReduce_11
action_7 _ = happyReduce_11

action_8 _ = happyReduce_12

action_9 _ = happyReduce_13

action_10 _ = happyReduce_8

action_11 (84) = happyAccept
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_2

action_13 (68) = happyShift action_31
action_13 (69) = happyShift action_6
action_13 (70) = happyShift action_32
action_13 (71) = happyShift action_8
action_13 (72) = happyShift action_9
action_13 (74) = happyShift action_33
action_13 (76) = happyShift action_34
action_13 (78) = happyShift action_35
action_13 (79) = happyShift action_36
action_13 (80) = happyShift action_37
action_13 (81) = happyShift action_38
action_13 (82) = happyShift action_39
action_13 (8) = happyGoto action_14
action_13 (13) = happyGoto action_15
action_13 (14) = happyGoto action_16
action_13 (16) = happyGoto action_17
action_13 (17) = happyGoto action_18
action_13 (18) = happyGoto action_19
action_13 (19) = happyGoto action_20
action_13 (20) = happyGoto action_21
action_13 (21) = happyGoto action_22
action_13 (23) = happyGoto action_23
action_13 (24) = happyGoto action_24
action_13 (25) = happyGoto action_25
action_13 (26) = happyGoto action_26
action_13 (27) = happyGoto action_27
action_13 (28) = happyGoto action_28
action_13 (29) = happyGoto action_29
action_13 (33) = happyGoto action_30
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (68) = happyShift action_76
action_14 (15) = happyGoto action_75
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (68) = happyShift action_31
action_15 (74) = happyShift action_33
action_15 (76) = happyShift action_34
action_15 (78) = happyShift action_35
action_15 (79) = happyShift action_36
action_15 (80) = happyShift action_37
action_15 (81) = happyShift action_38
action_15 (82) = happyShift action_39
action_15 (16) = happyGoto action_74
action_15 (17) = happyGoto action_18
action_15 (18) = happyGoto action_19
action_15 (19) = happyGoto action_20
action_15 (20) = happyGoto action_21
action_15 (21) = happyGoto action_22
action_15 (23) = happyGoto action_23
action_15 (24) = happyGoto action_24
action_15 (25) = happyGoto action_25
action_15 (26) = happyGoto action_26
action_15 (27) = happyGoto action_27
action_15 (28) = happyGoto action_28
action_15 (29) = happyGoto action_29
action_15 (33) = happyGoto action_30
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (69) = happyShift action_6
action_16 (70) = happyShift action_32
action_16 (71) = happyShift action_8
action_16 (72) = happyShift action_9
action_16 (8) = happyGoto action_14
action_16 (13) = happyGoto action_73
action_16 (14) = happyGoto action_16
action_16 _ = happyReduce_21

action_17 (50) = happyShift action_72
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (68) = happyShift action_31
action_18 (74) = happyShift action_33
action_18 (76) = happyShift action_34
action_18 (78) = happyShift action_35
action_18 (79) = happyShift action_36
action_18 (80) = happyShift action_37
action_18 (81) = happyShift action_38
action_18 (82) = happyShift action_39
action_18 (16) = happyGoto action_71
action_18 (17) = happyGoto action_18
action_18 (18) = happyGoto action_19
action_18 (19) = happyGoto action_20
action_18 (20) = happyGoto action_21
action_18 (21) = happyGoto action_22
action_18 (23) = happyGoto action_23
action_18 (24) = happyGoto action_24
action_18 (25) = happyGoto action_25
action_18 (26) = happyGoto action_26
action_18 (27) = happyGoto action_27
action_18 (28) = happyGoto action_28
action_18 (29) = happyGoto action_29
action_18 (33) = happyGoto action_30
action_18 _ = happyReduce_26

action_19 _ = happyReduce_27

action_20 _ = happyReduce_28

action_21 _ = happyReduce_29

action_22 _ = happyReduce_30

action_23 _ = happyReduce_31

action_24 _ = happyReduce_32

action_25 _ = happyReduce_33

action_26 _ = happyReduce_34

action_27 _ = happyReduce_35

action_28 _ = happyReduce_36

action_29 _ = happyReduce_37

action_30 (52) = happyShift action_70
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (45) = happyShift action_62
action_31 (62) = happyShift action_63
action_31 (63) = happyShift action_64
action_31 (64) = happyShift action_65
action_31 (65) = happyShift action_66
action_31 (66) = happyShift action_67
action_31 (67) = happyShift action_68
action_31 (77) = happyShift action_69
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_11

action_33 (35) = happyShift action_53
action_33 (36) = happyShift action_54
action_33 (37) = happyShift action_55
action_33 (38) = happyShift action_56
action_33 (40) = happyShift action_57
action_33 (45) = happyShift action_58
action_33 (52) = happyShift action_59
action_33 (68) = happyShift action_60
action_33 (75) = happyShift action_61
action_33 (32) = happyGoto action_51
action_33 (33) = happyGoto action_52
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (45) = happyShift action_50
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (45) = happyShift action_49
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (45) = happyShift action_48
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (49) = happyShift action_47
action_37 (12) = happyGoto action_46
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (45) = happyShift action_45
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (45) = happyShift action_44
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (45) = happyShift action_43
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_3

action_42 _ = happyReduce_1

action_43 (46) = happyShift action_115
action_43 (69) = happyShift action_6
action_43 (70) = happyShift action_32
action_43 (71) = happyShift action_8
action_43 (72) = happyShift action_9
action_43 (8) = happyGoto action_112
action_43 (9) = happyGoto action_113
action_43 (10) = happyGoto action_114
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (35) = happyShift action_53
action_44 (36) = happyShift action_54
action_44 (37) = happyShift action_55
action_44 (38) = happyShift action_56
action_44 (40) = happyShift action_57
action_44 (45) = happyShift action_105
action_44 (61) = happyShift action_106
action_44 (68) = happyShift action_60
action_44 (75) = happyShift action_61
action_44 (30) = happyGoto action_111
action_44 (31) = happyGoto action_103
action_44 (32) = happyGoto action_104
action_44 (33) = happyGoto action_52
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (68) = happyShift action_110
action_45 (22) = happyGoto action_109
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (79) = happyShift action_108
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (68) = happyShift action_31
action_47 (74) = happyShift action_33
action_47 (76) = happyShift action_34
action_47 (78) = happyShift action_35
action_47 (79) = happyShift action_36
action_47 (80) = happyShift action_37
action_47 (81) = happyShift action_38
action_47 (82) = happyShift action_39
action_47 (16) = happyGoto action_107
action_47 (17) = happyGoto action_18
action_47 (18) = happyGoto action_19
action_47 (19) = happyGoto action_20
action_47 (20) = happyGoto action_21
action_47 (21) = happyGoto action_22
action_47 (23) = happyGoto action_23
action_47 (24) = happyGoto action_24
action_47 (25) = happyGoto action_25
action_47 (26) = happyGoto action_26
action_47 (27) = happyGoto action_27
action_47 (28) = happyGoto action_28
action_47 (29) = happyGoto action_29
action_47 (33) = happyGoto action_30
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (35) = happyShift action_53
action_48 (36) = happyShift action_54
action_48 (37) = happyShift action_55
action_48 (38) = happyShift action_56
action_48 (40) = happyShift action_57
action_48 (45) = happyShift action_105
action_48 (61) = happyShift action_106
action_48 (68) = happyShift action_60
action_48 (75) = happyShift action_61
action_48 (30) = happyGoto action_102
action_48 (31) = happyGoto action_103
action_48 (32) = happyGoto action_104
action_48 (33) = happyGoto action_52
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (35) = happyShift action_53
action_49 (36) = happyShift action_54
action_49 (37) = happyShift action_55
action_49 (38) = happyShift action_56
action_49 (40) = happyShift action_57
action_49 (45) = happyShift action_58
action_49 (68) = happyShift action_60
action_49 (75) = happyShift action_61
action_49 (32) = happyGoto action_101
action_49 (33) = happyGoto action_52
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (68) = happyShift action_100
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (39) = happyShift action_93
action_51 (40) = happyShift action_94
action_51 (41) = happyShift action_95
action_51 (42) = happyShift action_96
action_51 (43) = happyShift action_97
action_51 (44) = happyShift action_98
action_51 (52) = happyShift action_99
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_82

action_53 _ = happyReduce_78

action_54 _ = happyReduce_79

action_55 _ = happyReduce_81

action_56 _ = happyReduce_80

action_57 (35) = happyShift action_53
action_57 (36) = happyShift action_54
action_57 (37) = happyShift action_55
action_57 (38) = happyShift action_56
action_57 (40) = happyShift action_57
action_57 (45) = happyShift action_58
action_57 (68) = happyShift action_60
action_57 (75) = happyShift action_61
action_57 (32) = happyGoto action_92
action_57 (33) = happyGoto action_52
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (35) = happyShift action_53
action_58 (36) = happyShift action_54
action_58 (37) = happyShift action_55
action_58 (38) = happyShift action_56
action_58 (40) = happyShift action_57
action_58 (45) = happyShift action_58
action_58 (68) = happyShift action_60
action_58 (75) = happyShift action_61
action_58 (32) = happyGoto action_91
action_58 (33) = happyGoto action_52
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_57

action_60 (45) = happyShift action_62
action_60 _ = happyReduce_83

action_61 (45) = happyShift action_90
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (35) = happyShift action_53
action_62 (36) = happyShift action_54
action_62 (37) = happyShift action_55
action_62 (38) = happyShift action_56
action_62 (40) = happyShift action_57
action_62 (45) = happyShift action_58
action_62 (46) = happyShift action_89
action_62 (68) = happyShift action_60
action_62 (75) = happyShift action_61
action_62 (32) = happyGoto action_87
action_62 (33) = happyGoto action_52
action_62 (34) = happyGoto action_88
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (52) = happyShift action_86
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (52) = happyShift action_85
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (35) = happyShift action_53
action_65 (36) = happyShift action_54
action_65 (37) = happyShift action_55
action_65 (38) = happyShift action_56
action_65 (40) = happyShift action_57
action_65 (45) = happyShift action_58
action_65 (68) = happyShift action_60
action_65 (75) = happyShift action_61
action_65 (32) = happyGoto action_84
action_65 (33) = happyGoto action_52
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (35) = happyShift action_53
action_66 (36) = happyShift action_54
action_66 (37) = happyShift action_55
action_66 (38) = happyShift action_56
action_66 (40) = happyShift action_57
action_66 (45) = happyShift action_58
action_66 (68) = happyShift action_60
action_66 (75) = happyShift action_61
action_66 (32) = happyGoto action_83
action_66 (33) = happyGoto action_52
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (35) = happyShift action_53
action_67 (36) = happyShift action_54
action_67 (37) = happyShift action_55
action_67 (38) = happyShift action_56
action_67 (40) = happyShift action_57
action_67 (45) = happyShift action_58
action_67 (68) = happyShift action_60
action_67 (75) = happyShift action_61
action_67 (32) = happyGoto action_82
action_67 (33) = happyGoto action_52
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (35) = happyShift action_53
action_68 (36) = happyShift action_54
action_68 (37) = happyShift action_55
action_68 (38) = happyShift action_56
action_68 (40) = happyShift action_57
action_68 (45) = happyShift action_58
action_68 (68) = happyShift action_60
action_68 (75) = happyShift action_61
action_68 (32) = happyGoto action_81
action_68 (33) = happyGoto action_52
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (35) = happyShift action_53
action_69 (36) = happyShift action_54
action_69 (37) = happyShift action_55
action_69 (38) = happyShift action_56
action_69 (40) = happyShift action_57
action_69 (45) = happyShift action_58
action_69 (68) = happyShift action_60
action_69 (75) = happyShift action_61
action_69 (32) = happyGoto action_80
action_69 (33) = happyGoto action_52
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_55

action_71 _ = happyReduce_25

action_72 _ = happyReduce_18

action_73 _ = happyReduce_20

action_74 (50) = happyShift action_79
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (52) = happyShift action_78
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (51) = happyShift action_77
action_76 _ = happyReduce_24

action_77 (68) = happyShift action_76
action_77 (15) = happyGoto action_156
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_22

action_79 _ = happyReduce_17

action_80 (39) = happyShift action_93
action_80 (40) = happyShift action_94
action_80 (41) = happyShift action_95
action_80 (42) = happyShift action_96
action_80 (43) = happyShift action_97
action_80 (44) = happyShift action_98
action_80 (52) = happyShift action_155
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (39) = happyShift action_93
action_81 (40) = happyShift action_94
action_81 (41) = happyShift action_95
action_81 (42) = happyShift action_96
action_81 (43) = happyShift action_97
action_81 (44) = happyShift action_98
action_81 (52) = happyShift action_154
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (39) = happyShift action_93
action_82 (40) = happyShift action_94
action_82 (41) = happyShift action_95
action_82 (42) = happyShift action_96
action_82 (43) = happyShift action_97
action_82 (44) = happyShift action_98
action_82 (52) = happyShift action_153
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (39) = happyShift action_93
action_83 (40) = happyShift action_94
action_83 (41) = happyShift action_95
action_83 (42) = happyShift action_96
action_83 (43) = happyShift action_97
action_83 (44) = happyShift action_98
action_83 (52) = happyShift action_152
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (39) = happyShift action_93
action_84 (40) = happyShift action_94
action_84 (41) = happyShift action_95
action_84 (42) = happyShift action_96
action_84 (43) = happyShift action_97
action_84 (44) = happyShift action_98
action_84 (52) = happyShift action_151
action_84 _ = happyFail (happyExpListPerState 84)

action_85 _ = happyReduce_52

action_86 _ = happyReduce_51

action_87 (39) = happyShift action_93
action_87 (40) = happyShift action_94
action_87 (41) = happyShift action_95
action_87 (42) = happyShift action_96
action_87 (43) = happyShift action_97
action_87 (44) = happyShift action_98
action_87 (51) = happyShift action_150
action_87 _ = happyReduce_87

action_88 (46) = happyShift action_149
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_85

action_90 (35) = happyShift action_53
action_90 (36) = happyShift action_54
action_90 (37) = happyShift action_55
action_90 (38) = happyShift action_56
action_90 (40) = happyShift action_57
action_90 (45) = happyShift action_58
action_90 (68) = happyShift action_60
action_90 (75) = happyShift action_61
action_90 (32) = happyGoto action_148
action_90 (33) = happyGoto action_52
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (39) = happyShift action_93
action_91 (40) = happyShift action_94
action_91 (41) = happyShift action_95
action_91 (42) = happyShift action_96
action_91 (43) = happyShift action_97
action_91 (44) = happyShift action_98
action_91 (46) = happyShift action_147
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_76

action_93 (35) = happyShift action_53
action_93 (36) = happyShift action_54
action_93 (37) = happyShift action_55
action_93 (38) = happyShift action_56
action_93 (40) = happyShift action_57
action_93 (45) = happyShift action_58
action_93 (68) = happyShift action_60
action_93 (75) = happyShift action_61
action_93 (32) = happyGoto action_146
action_93 (33) = happyGoto action_52
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (35) = happyShift action_53
action_94 (36) = happyShift action_54
action_94 (37) = happyShift action_55
action_94 (38) = happyShift action_56
action_94 (40) = happyShift action_57
action_94 (45) = happyShift action_58
action_94 (68) = happyShift action_60
action_94 (75) = happyShift action_61
action_94 (32) = happyGoto action_145
action_94 (33) = happyGoto action_52
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (35) = happyShift action_53
action_95 (36) = happyShift action_54
action_95 (37) = happyShift action_55
action_95 (38) = happyShift action_56
action_95 (40) = happyShift action_57
action_95 (45) = happyShift action_58
action_95 (68) = happyShift action_60
action_95 (75) = happyShift action_61
action_95 (32) = happyGoto action_144
action_95 (33) = happyGoto action_52
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (35) = happyShift action_53
action_96 (36) = happyShift action_54
action_96 (37) = happyShift action_55
action_96 (38) = happyShift action_56
action_96 (40) = happyShift action_57
action_96 (45) = happyShift action_58
action_96 (68) = happyShift action_60
action_96 (75) = happyShift action_61
action_96 (32) = happyGoto action_143
action_96 (33) = happyGoto action_52
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (35) = happyShift action_53
action_97 (36) = happyShift action_54
action_97 (37) = happyShift action_55
action_97 (38) = happyShift action_56
action_97 (40) = happyShift action_57
action_97 (45) = happyShift action_58
action_97 (68) = happyShift action_60
action_97 (75) = happyShift action_61
action_97 (32) = happyGoto action_142
action_97 (33) = happyGoto action_52
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (35) = happyShift action_53
action_98 (36) = happyShift action_54
action_98 (37) = happyShift action_55
action_98 (38) = happyShift action_56
action_98 (40) = happyShift action_57
action_98 (45) = happyShift action_58
action_98 (68) = happyShift action_60
action_98 (75) = happyShift action_61
action_98 (32) = happyGoto action_141
action_98 (33) = happyGoto action_52
action_98 _ = happyFail (happyExpListPerState 98)

action_99 _ = happyReduce_56

action_100 (46) = happyShift action_140
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (39) = happyShift action_93
action_101 (40) = happyShift action_94
action_101 (41) = happyShift action_95
action_101 (42) = happyShift action_96
action_101 (43) = happyShift action_97
action_101 (44) = happyShift action_98
action_101 (46) = happyShift action_139
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (46) = happyShift action_138
action_102 (59) = happyShift action_121
action_102 (60) = happyShift action_122
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_62

action_104 (39) = happyShift action_93
action_104 (40) = happyShift action_94
action_104 (41) = happyShift action_95
action_104 (42) = happyShift action_96
action_104 (43) = happyShift action_97
action_104 (44) = happyShift action_98
action_104 (53) = happyShift action_132
action_104 (54) = happyShift action_133
action_104 (55) = happyShift action_134
action_104 (56) = happyShift action_135
action_104 (57) = happyShift action_136
action_104 (58) = happyShift action_137
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (35) = happyShift action_53
action_105 (36) = happyShift action_54
action_105 (37) = happyShift action_55
action_105 (38) = happyShift action_56
action_105 (40) = happyShift action_57
action_105 (45) = happyShift action_105
action_105 (61) = happyShift action_106
action_105 (68) = happyShift action_60
action_105 (75) = happyShift action_61
action_105 (30) = happyGoto action_130
action_105 (31) = happyGoto action_103
action_105 (32) = happyGoto action_131
action_105 (33) = happyGoto action_52
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (35) = happyShift action_53
action_106 (36) = happyShift action_54
action_106 (37) = happyShift action_55
action_106 (38) = happyShift action_56
action_106 (40) = happyShift action_57
action_106 (45) = happyShift action_105
action_106 (61) = happyShift action_106
action_106 (68) = happyShift action_60
action_106 (75) = happyShift action_61
action_106 (30) = happyGoto action_129
action_106 (31) = happyGoto action_103
action_106 (32) = happyGoto action_104
action_106 (33) = happyGoto action_52
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (50) = happyShift action_128
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (45) = happyShift action_127
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (52) = happyShift action_126
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (62) = happyShift action_123
action_110 (63) = happyShift action_124
action_110 (77) = happyShift action_125
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (46) = happyShift action_120
action_111 (59) = happyShift action_121
action_111 (60) = happyShift action_122
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (68) = happyShift action_119
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (46) = happyShift action_118
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (51) = happyShift action_117
action_114 _ = happyReduce_15

action_115 (49) = happyShift action_13
action_115 (11) = happyGoto action_116
action_115 _ = happyFail (happyExpListPerState 115)

action_116 _ = happyReduce_6

action_117 (69) = happyShift action_6
action_117 (70) = happyShift action_32
action_117 (71) = happyShift action_8
action_117 (72) = happyShift action_9
action_117 (8) = happyGoto action_112
action_117 (9) = happyGoto action_176
action_117 (10) = happyGoto action_114
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (49) = happyShift action_13
action_118 (11) = happyGoto action_175
action_118 _ = happyFail (happyExpListPerState 118)

action_119 _ = happyReduce_16

action_120 (49) = happyShift action_47
action_120 (12) = happyGoto action_174
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (35) = happyShift action_53
action_121 (36) = happyShift action_54
action_121 (37) = happyShift action_55
action_121 (38) = happyShift action_56
action_121 (40) = happyShift action_57
action_121 (45) = happyShift action_105
action_121 (61) = happyShift action_106
action_121 (68) = happyShift action_60
action_121 (75) = happyShift action_61
action_121 (30) = happyGoto action_173
action_121 (31) = happyGoto action_103
action_121 (32) = happyGoto action_104
action_121 (33) = happyGoto action_52
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (35) = happyShift action_53
action_122 (36) = happyShift action_54
action_122 (37) = happyShift action_55
action_122 (38) = happyShift action_56
action_122 (40) = happyShift action_57
action_122 (45) = happyShift action_105
action_122 (61) = happyShift action_106
action_122 (68) = happyShift action_60
action_122 (75) = happyShift action_61
action_122 (30) = happyGoto action_172
action_122 (31) = happyGoto action_103
action_122 (32) = happyGoto action_104
action_122 (33) = happyGoto action_52
action_122 _ = happyFail (happyExpListPerState 122)

action_123 _ = happyReduce_44

action_124 _ = happyReduce_45

action_125 (35) = happyShift action_53
action_125 (36) = happyShift action_54
action_125 (37) = happyShift action_55
action_125 (38) = happyShift action_56
action_125 (40) = happyShift action_57
action_125 (45) = happyShift action_58
action_125 (68) = happyShift action_60
action_125 (75) = happyShift action_61
action_125 (32) = happyGoto action_171
action_125 (33) = happyGoto action_52
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (35) = happyShift action_53
action_126 (36) = happyShift action_54
action_126 (37) = happyShift action_55
action_126 (38) = happyShift action_56
action_126 (40) = happyShift action_57
action_126 (45) = happyShift action_105
action_126 (61) = happyShift action_106
action_126 (68) = happyShift action_60
action_126 (75) = happyShift action_61
action_126 (30) = happyGoto action_170
action_126 (31) = happyGoto action_103
action_126 (32) = happyGoto action_104
action_126 (33) = happyGoto action_52
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (35) = happyShift action_53
action_127 (36) = happyShift action_54
action_127 (37) = happyShift action_55
action_127 (38) = happyShift action_56
action_127 (40) = happyShift action_57
action_127 (45) = happyShift action_105
action_127 (61) = happyShift action_106
action_127 (68) = happyShift action_60
action_127 (75) = happyShift action_61
action_127 (30) = happyGoto action_169
action_127 (31) = happyGoto action_103
action_127 (32) = happyGoto action_104
action_127 (33) = happyGoto action_52
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_19

action_129 _ = happyReduce_60

action_130 (46) = happyShift action_168
action_130 (59) = happyShift action_121
action_130 (60) = happyShift action_122
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (39) = happyShift action_93
action_131 (40) = happyShift action_94
action_131 (41) = happyShift action_95
action_131 (42) = happyShift action_96
action_131 (43) = happyShift action_97
action_131 (44) = happyShift action_98
action_131 (46) = happyShift action_147
action_131 (53) = happyShift action_132
action_131 (54) = happyShift action_133
action_131 (55) = happyShift action_134
action_131 (56) = happyShift action_135
action_131 (57) = happyShift action_136
action_131 (58) = happyShift action_137
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (35) = happyShift action_53
action_132 (36) = happyShift action_54
action_132 (37) = happyShift action_55
action_132 (38) = happyShift action_56
action_132 (40) = happyShift action_57
action_132 (45) = happyShift action_58
action_132 (68) = happyShift action_60
action_132 (75) = happyShift action_61
action_132 (32) = happyGoto action_167
action_132 (33) = happyGoto action_52
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (35) = happyShift action_53
action_133 (36) = happyShift action_54
action_133 (37) = happyShift action_55
action_133 (38) = happyShift action_56
action_133 (40) = happyShift action_57
action_133 (45) = happyShift action_58
action_133 (68) = happyShift action_60
action_133 (75) = happyShift action_61
action_133 (32) = happyGoto action_166
action_133 (33) = happyGoto action_52
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (35) = happyShift action_53
action_134 (36) = happyShift action_54
action_134 (37) = happyShift action_55
action_134 (38) = happyShift action_56
action_134 (40) = happyShift action_57
action_134 (45) = happyShift action_58
action_134 (68) = happyShift action_60
action_134 (75) = happyShift action_61
action_134 (32) = happyGoto action_165
action_134 (33) = happyGoto action_52
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (35) = happyShift action_53
action_135 (36) = happyShift action_54
action_135 (37) = happyShift action_55
action_135 (38) = happyShift action_56
action_135 (40) = happyShift action_57
action_135 (45) = happyShift action_58
action_135 (68) = happyShift action_60
action_135 (75) = happyShift action_61
action_135 (32) = happyGoto action_164
action_135 (33) = happyGoto action_52
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (35) = happyShift action_53
action_136 (36) = happyShift action_54
action_136 (37) = happyShift action_55
action_136 (38) = happyShift action_56
action_136 (40) = happyShift action_57
action_136 (45) = happyShift action_58
action_136 (68) = happyShift action_60
action_136 (75) = happyShift action_61
action_136 (32) = happyGoto action_163
action_136 (33) = happyGoto action_52
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (35) = happyShift action_53
action_137 (36) = happyShift action_54
action_137 (37) = happyShift action_55
action_137 (38) = happyShift action_56
action_137 (40) = happyShift action_57
action_137 (45) = happyShift action_58
action_137 (68) = happyShift action_60
action_137 (75) = happyShift action_61
action_137 (32) = happyGoto action_162
action_137 (33) = happyGoto action_52
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (49) = happyShift action_47
action_138 (12) = happyGoto action_161
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (52) = happyShift action_160
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (52) = happyShift action_159
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (42) = happyShift action_96
action_141 _ = happyReduce_74

action_142 (42) = happyShift action_96
action_142 _ = happyReduce_72

action_143 (42) = happyShift action_96
action_143 _ = happyReduce_73

action_144 (42) = happyShift action_96
action_144 _ = happyReduce_71

action_145 (41) = happyShift action_95
action_145 (42) = happyShift action_96
action_145 (43) = happyShift action_97
action_145 (44) = happyShift action_98
action_145 _ = happyReduce_70

action_146 (41) = happyShift action_95
action_146 (42) = happyShift action_96
action_146 (43) = happyShift action_97
action_146 (44) = happyShift action_98
action_146 _ = happyReduce_69

action_147 _ = happyReduce_77

action_148 (39) = happyShift action_93
action_148 (40) = happyShift action_94
action_148 (41) = happyShift action_95
action_148 (42) = happyShift action_96
action_148 (43) = happyShift action_97
action_148 (44) = happyShift action_98
action_148 (46) = happyShift action_158
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_84

action_150 (35) = happyShift action_53
action_150 (36) = happyShift action_54
action_150 (37) = happyShift action_55
action_150 (38) = happyShift action_56
action_150 (40) = happyShift action_57
action_150 (45) = happyShift action_58
action_150 (68) = happyShift action_60
action_150 (75) = happyShift action_61
action_150 (32) = happyGoto action_87
action_150 (33) = happyGoto action_52
action_150 (34) = happyGoto action_157
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_47

action_152 _ = happyReduce_48

action_153 _ = happyReduce_49

action_154 _ = happyReduce_50

action_155 _ = happyReduce_46

action_156 _ = happyReduce_23

action_157 _ = happyReduce_86

action_158 _ = happyReduce_75

action_159 _ = happyReduce_54

action_160 _ = happyReduce_53

action_161 _ = happyReduce_40

action_162 (39) = happyShift action_93
action_162 (40) = happyShift action_94
action_162 (41) = happyShift action_95
action_162 (42) = happyShift action_96
action_162 (43) = happyShift action_97
action_162 (44) = happyShift action_98
action_162 _ = happyReduce_64

action_163 (39) = happyShift action_93
action_163 (40) = happyShift action_94
action_163 (41) = happyShift action_95
action_163 (42) = happyShift action_96
action_163 (43) = happyShift action_97
action_163 (44) = happyShift action_98
action_163 _ = happyReduce_63

action_164 (39) = happyShift action_93
action_164 (40) = happyShift action_94
action_164 (41) = happyShift action_95
action_164 (42) = happyShift action_96
action_164 (43) = happyShift action_97
action_164 (44) = happyShift action_98
action_164 _ = happyReduce_65

action_165 (39) = happyShift action_93
action_165 (40) = happyShift action_94
action_165 (41) = happyShift action_95
action_165 (42) = happyShift action_96
action_165 (43) = happyShift action_97
action_165 (44) = happyShift action_98
action_165 _ = happyReduce_66

action_166 (39) = happyShift action_93
action_166 (40) = happyShift action_94
action_166 (41) = happyShift action_95
action_166 (42) = happyShift action_96
action_166 (43) = happyShift action_97
action_166 (44) = happyShift action_98
action_166 _ = happyReduce_68

action_167 (39) = happyShift action_93
action_167 (40) = happyShift action_94
action_167 (41) = happyShift action_95
action_167 (42) = happyShift action_96
action_167 (43) = happyShift action_97
action_167 (44) = happyShift action_98
action_167 _ = happyReduce_67

action_168 _ = happyReduce_61

action_169 (46) = happyShift action_179
action_169 (59) = happyShift action_121
action_169 (60) = happyShift action_122
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (52) = happyShift action_178
action_170 (59) = happyShift action_121
action_170 (60) = happyShift action_122
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (39) = happyShift action_93
action_171 (40) = happyShift action_94
action_171 (41) = happyShift action_95
action_171 (42) = happyShift action_96
action_171 (43) = happyShift action_97
action_171 (44) = happyShift action_98
action_171 _ = happyReduce_43

action_172 _ = happyReduce_59

action_173 _ = happyReduce_58

action_174 (83) = happyShift action_177
action_174 _ = happyReduce_39

action_175 _ = happyReduce_5

action_176 _ = happyReduce_14

action_177 (49) = happyShift action_47
action_177 (12) = happyGoto action_182
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (68) = happyShift action_110
action_178 (22) = happyGoto action_181
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (52) = happyShift action_180
action_179 _ = happyFail (happyExpListPerState 179)

action_180 _ = happyReduce_41

action_181 (46) = happyShift action_183
action_181 _ = happyFail (happyExpListPerState 181)

action_182 _ = happyReduce_38

action_183 (49) = happyShift action_47
action_183 (12) = happyGoto action_184
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_42

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (construirPrograma happy_var_1 happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn4
		 (construirPrograma [] happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 ((HappyAbsSyn11  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (FuncaoDefinicao (happy_var_2 :->: (happy_var_4, happy_var_1)) happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 6 happyReduction_6
happyReduction_6 ((HappyAbsSyn11  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (FuncaoDefinicao (happy_var_2 :->: ([], happy_var_1)) happy_var_5
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_1  7 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn7
		 (TVoid
	)

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn7
		 (TFloat
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn8
		 (TInt
	)

happyReduce_11 = happySpecReduce_1  8 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn8
		 (TFloat
	)

happyReduce_12 = happySpecReduce_1  8 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn8
		 (TString
	)

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 _
	 =  HappyAbsSyn8
		 (TDouble
	)

happyReduce_14 = happySpecReduce_3  9 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ([happy_var_1]
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  10 happyReduction_16
happyReduction_16 (HappyTerminal (ID happy_var_2))
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_2 :#: (happy_var_1, 0)
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 4 11 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (BlocoP happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_3  11 happyReduction_18
happyReduction_18 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (BlocoP [] happy_var_2
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  12 happyReduction_19
happyReduction_19 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  13 happyReduction_20
happyReduction_20 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 ++ happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  14 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn14
		 (map (\s -> s :#: (happy_var_1, 0)) happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1 : happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  15 happyReduction_24
happyReduction_24 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn15
		 ([happy_var_1]
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  16 happyReduction_25
happyReduction_25 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1 : happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  16 happyReduction_26
happyReduction_26 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  17 happyReduction_28
happyReduction_28 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  17 happyReduction_30
happyReduction_30 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  17 happyReduction_31
happyReduction_31 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  17 happyReduction_33
happyReduction_33 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  17 happyReduction_34
happyReduction_34 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  17 happyReduction_35
happyReduction_35 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  17 happyReduction_36
happyReduction_36 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  17 happyReduction_37
happyReduction_37 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happyReduce 7 18 happyReduction_38
happyReduction_38 ((HappyAbsSyn12  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 5 18 happyReduction_39
happyReduction_39 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (If happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 5 19 happyReduction_40
happyReduction_40 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 7 20 happyReduction_41
happyReduction_41 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (DoWhile happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 9 21 happyReduction_42
happyReduction_42 ((HappyAbsSyn12  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (For happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_3  22 happyReduction_43
happyReduction_43 (HappyAbsSyn32  happy_var_3)
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn22
		 (Atrib happy_var_1 happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  22 happyReduction_44
happyReduction_44 _
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn22
		 (Incr happy_var_1
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  22 happyReduction_45
happyReduction_45 _
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn22
		 (Decr happy_var_1
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 4 23 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Atrib happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 4 23 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Atrib happy_var_1 (Add (IdVar happy_var_1) happy_var_3)
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 4 23 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Atrib happy_var_1 (Sub (IdVar happy_var_1) happy_var_3)
	) `HappyStk` happyRest

happyReduce_49 = happyReduce 4 23 happyReduction_49
happyReduction_49 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Atrib happy_var_1 (Mul (IdVar happy_var_1) happy_var_3)
	) `HappyStk` happyRest

happyReduce_50 = happyReduce 4 23 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Atrib happy_var_1 (Div (IdVar happy_var_1) happy_var_3)
	) `HappyStk` happyRest

happyReduce_51 = happySpecReduce_3  24 happyReduction_51
happyReduction_51 _
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn24
		 (Incr happy_var_1
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  25 happyReduction_52
happyReduction_52 _
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn25
		 (Decr happy_var_1
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happyReduce 5 26 happyReduction_53
happyReduction_53 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Imp happy_var_3
	) `HappyStk` happyRest

happyReduce_54 = happyReduce 5 27 happyReduction_54
happyReduction_54 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (Leitura happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_2  28 happyReduction_55
happyReduction_55 _
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn28
		 (converterChamadaParaProc happy_var_1
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  29 happyReduction_56
happyReduction_56 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (Ret (Just happy_var_2)
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_2  29 happyReduction_57
happyReduction_57 _
	_
	 =  HappyAbsSyn29
		 (Ret Nothing
	)

happyReduce_58 = happySpecReduce_3  30 happyReduction_58
happyReduction_58 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (And happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  30 happyReduction_59
happyReduction_59 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Or happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  30 happyReduction_60
happyReduction_60 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (Not happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  30 happyReduction_61
happyReduction_61 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (happy_var_2
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  30 happyReduction_62
happyReduction_62 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn30
		 (Rel happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  31 happyReduction_63
happyReduction_63 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Req happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  31 happyReduction_64
happyReduction_64 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rdif happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  31 happyReduction_65
happyReduction_65 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rgt happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  31 happyReduction_66
happyReduction_66 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rlt happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  31 happyReduction_67
happyReduction_67 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rge happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  31 happyReduction_68
happyReduction_68 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn31
		 (Rle happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  32 happyReduction_69
happyReduction_69 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Add happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  32 happyReduction_70
happyReduction_70 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  32 happyReduction_71
happyReduction_71 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  32 happyReduction_72
happyReduction_72 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Div happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  32 happyReduction_73
happyReduction_73 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  32 happyReduction_74
happyReduction_74 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happyReduce 4 32 happyReduction_75
happyReduction_75 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn32
		 (Sqr happy_var_3
	) `HappyStk` happyRest

happyReduce_76 = happySpecReduce_2  32 happyReduction_76
happyReduction_76 (HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn32
		 (Neg happy_var_2
	)
happyReduction_76 _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  32 happyReduction_77
happyReduction_77 _
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn32
		 (happy_var_2
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  32 happyReduction_78
happyReduction_78 (HappyTerminal (CINT happy_var_1))
	 =  HappyAbsSyn32
		 (Const (CInt happy_var_1)
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  32 happyReduction_79
happyReduction_79 (HappyTerminal (CDOUBLE happy_var_1))
	 =  HappyAbsSyn32
		 (Const (CDouble happy_var_1)
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  32 happyReduction_80
happyReduction_80 (HappyTerminal (CFLOAT happy_var_1))
	 =  HappyAbsSyn32
		 (Const (CFloat happy_var_1)
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  32 happyReduction_81
happyReduction_81 (HappyTerminal (LITERAL happy_var_1))
	 =  HappyAbsSyn32
		 (Lit happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  32 happyReduction_82
happyReduction_82 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  32 happyReduction_83
happyReduction_83 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn32
		 (IdVar happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happyReduce 4 33 happyReduction_84
happyReduction_84 (_ `HappyStk`
	(HappyAbsSyn34  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn33
		 (Chamada happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_85 = happySpecReduce_3  33 happyReduction_85
happyReduction_85 _
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn33
		 (Chamada happy_var_1 []
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  34 happyReduction_86
happyReduction_86 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn34
		 (happy_var_1 : happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  34 happyReduction_87
happyReduction_87 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn34
		 ([happy_var_1]
	)
happyReduction_87 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 84 84 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	CINT happy_dollar_dollar -> cont 35;
	CDOUBLE happy_dollar_dollar -> cont 36;
	LITERAL happy_dollar_dollar -> cont 37;
	CFLOAT happy_dollar_dollar -> cont 38;
	ADD -> cont 39;
	SUB -> cont 40;
	MUL -> cont 41;
	POW -> cont 42;
	DIV -> cont 43;
	RMOD -> cont 44;
	LPAR -> cont 45;
	RPAR -> cont 46;
	LBRACK -> cont 47;
	RBRACK -> cont 48;
	LCBRAK -> cont 49;
	RCBRAK -> cont 50;
	COMMA -> cont 51;
	SEMICOLON -> cont 52;
	MAJEQ -> cont 53;
	MINEQ -> cont 54;
	MINOR -> cont 55;
	MAJOR -> cont 56;
	EQUAL -> cont 57;
	NEQUAL -> cont 58;
	AND -> cont 59;
	OR -> cont 60;
	NOT -> cont 61;
	PLUSPLUS -> cont 62;
	MINUSMINUS -> cont 63;
	EQUALPLUS -> cont 64;
	EQUALMINUS -> cont 65;
	EQUALMUL -> cont 66;
	EQUALDIV -> cont 67;
	ID happy_dollar_dollar -> cont 68;
	TINT -> cont 69;
	TFLOAT -> cont 70;
	TSTRING -> cont 71;
	TDOUBLE -> cont 72;
	TVOID -> cont 73;
	TRETURN -> cont 74;
	SQR -> cont 75;
	TREAD -> cont 76;
	ATRIB -> cont 77;
	TPRINT -> cont 78;
	TWHILE -> cont 79;
	TDO -> cont 80;
	TFOR -> cont 81;
	TIF -> cont 82;
	TELSE -> cont 83;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 84 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Tokens)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
calc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


-- Exibe erros de sintaxe de forma mais clara
parseError :: [Tokens] -> a
parseError s = error ("Parse error:" ++ show s)

-- ============================================================================
-- Construtores da Árvore Sintática (AST)
-- ============================================================================

-- Constrói o nó raiz do Programa combinando funções e o bloco principal
construirPrograma :: [FuncaoDefinicao] -> BlocoComDeclaracoes -> Programa
construirPrograma listaFuncoes (BlocoP varsGlobais cmdsGlobais) = 
    Prog assinaturas corpos varsGlobais cmdsGlobais
  where
    assinaturas = map extrairAssinatura listaFuncoes
    corpos      = map extrairCorpoFuncao listaFuncoes

-- Extrai apenas a assinatura (Nome, Params, TipoRetorno) da definição
extrairAssinatura :: FuncaoDefinicao -> Funcao
extrairAssinatura (FuncaoDefinicao assinatura _corpo) = assinatura

-- Constrói a tupla (Nome, TodasVariaveis, Bloco) necessária para o Programa
-- Une os parâmetros da função com as variáveis locais declaradas no bloco
extrairCorpoFuncao :: FuncaoDefinicao -> (Id, [Var], Bloco)
extrairCorpoFuncao (FuncaoDefinicao (nome :->: (params, _tipoRet)) (BlocoP varsLocais cmds)) = 
    (nome, params ++ varsLocais, cmds)

-- ============================================================================
-- Auxiliares de Conversão
-- ============================================================================

-- Transforma uma expressão de Chamada de Função em um Comando de Procedimento
-- Útil quando uma função é chamada ignorando seu valor de retorno (ex: void)
converterChamadaParaProc :: Expr -> Comando
converterChamadaParaProc (Chamada id args) = Proc id args
converterChamadaParaProc _ = error "Erro Interno: Tentativa de converter uma expressão inválida em procedimento."

-- Função principal do Parser
parser = do 
        putStr "Nome do arquivo: "
        arquivo <- getLine
        s <- readFile arquivo
        -- Chama o lexer (Lex.alexScanTokens) e depois o parser (calc)
        print (calc (L.alexScanTokens s))
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































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
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
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
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
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





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

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
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
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
