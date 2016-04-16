SHELL := /bin/bash

CC = gcc 

CFLAGS = -O2 
LATEX=pdflatex
LATEXOPT=--shell-escape
LATEXMK=latexmk
LATEXMKOPT=-pdf
LATEXMKBIBTEX=-bibtex
#all: doc compress clean



all: exe2_1 relatorio.pdf clean 

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

############################# - Documentação - #########################################

relatorio.pdf:  report/rel.tex 
	$(LATEXMK) $(LATEXMKBIBTEX) $(LATEXMKOPT) \
		$(LATEXMKBIBTEX) $(CONTINUOUS) \
		            -pdflatex="$(LATEX) $(LATEXOPT) %O %S" \
			    report/rel.tex 
	mv rel.pdf relatorio.pdf 
	rm -fr rel.* 
	rm -fr report/chapters/*.aux 
	rm -fr _minted-rel


#compress: identificacao  ./code ./doc
#	@echo "Preparar ficheiro Bzip para entrega...."
#	tar jcf PLg039-et2.tar.bz2 identificacao code doc


############################### - Exercício 2.3 ###########################################
exe2_3: ./Exercicio2/exe2_3.l
	flex -o ./Exercicio2/lex.yy.c ./Exercicio2/exe2_3.l 
	$(CC) $(CFLAGS) -c ./Exercicio2/structures/simple_hashtable.c -o trie.o
	$(CC) $(CFLAGS) -c ./Exercicio2/lex.yy.c -o filter.o
	$(CC) $(CFLAGS) -g filter.o trie.o -o filter_exe2_3




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
	$(CC) $(CFLAGS) -o filter_exe2_1 ./Exercicio2/lex.yy.c


