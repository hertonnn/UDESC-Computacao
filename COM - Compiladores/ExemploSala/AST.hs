module AST where

data Expr = Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr | Const Int
                deriving (Show, Eq)
                
                
