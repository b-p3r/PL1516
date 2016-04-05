SHELL := /bin/bash

CC = gcc 

CFLAGS = -O2 
LATEX=pdflatex
LATEXOPT=--shell-escape
LATEXMK=latexmk
LATEXMKOPT=-pdf
LATEXMKBIBTEX=-bibtex
#all: doc compress clean



all: exe2_1 exe2_2a exe2_2b exe2_3 test relatorio.pdf compress clean 



############################# - Documentação - #########################################

relatorio.pdf:  report/rel.tex 
	$(LATEXMK) $(LATEXMKBIBTEX) $(LATEXMKOPT) \
		$(LATEXMKBIBTEX) $(CONTINUOUS) \
		            -pdflatex="$(LATEX) $(LATEXOPT) %O %S" \
			    report/rel.tex 
	mv rel.pdf pl15TP1Gr07.pdf 
	rm -fr rel.* 
	rm -fr report/chapters/*.aux 
	rm -fr _minted-rel


compress:  ./Exercicio2 
	@echo "Preparar ficheiro Zip para entrega...."
	zip -r Tp1 ./Exercicio2/*


############################### - Exercício 2.3 ###########################################
exe2_3: ./Exercicio2/exe2_3.l 
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_3.l 
	$(CC) $(CFLAGS) -c ./Exercicio2/structures/hashtable.c -o hashtable.o
	$(CC) $(CFLAGS) -c ./Exercicio2/lex.yy.c -o filter.o
	$(CC) $(CFLAGS) -g filter.o hashtable.o -o filter_exe2_3




############################### - Exercício 2.2  ###########################################


exe2_2a: ./Exercicio2/exe2_2a.l
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_2a.l 
	$(CC) $(CFLAGS) -o filter_exe2_2a ./Exercicio2/lex.yy.c

exe2_2b: ./Exercicio2/exe2_2b.l
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_2b.l 
	$(CC) $(CFLAGS) -o filter_exe2_2b ./Exercicio2/lex.yy.c

############################### - Exercício 2.1  ###########################################


exe2_1: ./Exercicio2/exe2_1.l
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_1.l 
	$(CC) $(CFLAGS) -c ./Exercicio2/structures/simple_hashtable.c -o \
	simple_hashtable.o
	$(CC) $(CFLAGS) -c ./Exercicio2/lex.yy.c -o filter.o
	$(CC) $(CFLAGS) -g filter.o simple_hashtable.o -o filter_exe2_1


clean: clean_exec 
	@echo "A limpar diretoria...."
	rm -rf *.o
	rm -rf Exercicio2/*.o
	rm -rf Exercicio2/lex.yy.c
	#rm -rf ./doc

clean_exec:
	@echo "A eliminar executáveis...."
	rm -f filter_*
	rm -fr relatorio.pdf
    rm -fr Tp1.zip

test: 
	./filter_exe2_2a < testes/ex3.bib > testes/resNorm.bib
	./filter_exe2_2b < testes/ex3.bib > testes/res_pretty_printing.txt
     #dot -Tps testes/res_dot.dot -o testes/out.ps

