build:
	alex src/Compiler/Syntax/Lexer.x && happy src/Compiler/Syntax/Parser.y
