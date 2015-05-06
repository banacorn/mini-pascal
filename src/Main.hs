module Compiler where

import Control.Monad.State

import Compiler.Syntax.Lexer
import Compiler.Syntax.Parser
import Compiler.Pipeline
-- import Compiler.CodeGen
-- import Compiler.JIT

import  Compiler.AST.Instances

main :: IO ()
main = pipeline $ do
    readSource "./test/code/test.p"
        >>= scan
        >>= parse
        >>= checkBinding
        >>= checkType
        >>= convert
        >>= printIt'

    return ()
    --
    -- printIt "\n=== ASSEMBLY ===\n"
    -- as <- toIRAssembly (genModule ast) >>= printIt'
    -- liftIO $ writeFile "./test/llvm/test.ll" as
    --     -- >>= printIt
    --     -- >>= runJIT
    --     -- >>= printIt'
    --
    -- printIt "\n=== JIT ==="
    -- runJIT (genModule ast) >>= printIt'
