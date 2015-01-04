{
module Compiler.Parser where
import Compiler.Type
import Compiler.Lexer
import Control.Monad.Except
}

%name parse
%tokentype { Token }
%monad { Pipeline } { >>= } { return }
%error { parseError }

%token
    progtok         { Token TokProgram _ }

%%


program : progtok {% do
    liftIO $ print $1
    return $ Program "abc" [] [] [] (CompoundStmt []) }


{
parseError :: [Token] -> Pipeline a
parseError tok = throwError $ ParseError $ show tok
}
