SHELL := /bin/bash

CC = gcc 

CFLAGS = -O2 

#all: doc compress clean



all: exe2_1 clean 

clean: 
	@echo "A limpar diretoria...."
	rm -rf *.o
	rm -rf Exercicio2/*.o
	rm -rf Exercicio2/lex.yy.c
	#rm -rf ./doc

clean_exec:
	@echo "A eliminar executáveis...."
	rm -f filter_*

############################# - Documentação - #########################################

relatorio.pdf:  report/rel.tex 
	latexmk -pdf report/rel.tex 
	mv rel.pdf analise.pdf 
	rm -fr rel.* rm -fr
	report/chapters/*.aux 
	#rm -r report


#compress: identificacao  ./code ./doc
#	@echo "Preparar ficheiro Bzip para entrega...."
#	tar jcf PLg039-et2.tar.bz2 identificacao code doc



############################### - Exercício 2.1  ###########################################


exe2_1: ./Exercicio2/lex.yy.c ./Exercicio2/exe2_1.l
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_1.l 
	$(CC) $(CFLAGS) -o filter_exe2_1 ./Exercicio2/lex.yy.c


