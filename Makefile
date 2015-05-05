build:
	alex src/Compiler/Syntax/Lexer.x && happy src/Compiler/Syntax/Parser.y

go:
	llvm-as ./test/llvm/test.ll && lli ./test/llvm/test.bc
