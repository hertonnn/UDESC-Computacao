module Gerar where

import AST

gerar (Const i) | i < 6     = "iconst_" ++ show i ++ "\n"
                | i < 128   = "bipush " ++ show i ++ "\n"
                | i < 32768 = "sipush " ++ show i ++ "\n"
                | otherwise = "ldc " ++ show i ++ "\n"
gerar (Add e1 e2) = gerar e1 ++ gerar e2 ++ "iadd\n"
gerar (Sub e1 e2) = gerar e1 ++ gerar e2 ++ "isub\n"
gerar (Mul e1 e2) = gerar e1 ++ gerar e2 ++ "imul\n"
gerar (Div e1 e2) = gerar e1 ++ gerar e2 ++ "idiv\n"

