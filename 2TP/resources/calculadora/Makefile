all: calculadora clean

calculadora: calculadora.fl calculadora.y
	 	flex calculadora.fl
	 	yacc calculadora.y
		gcc -o calculadora y.tab.c

clean: 
	rm -f y.tab.c lex.yy.c
clean_exec: 
	rm -f calculadora
