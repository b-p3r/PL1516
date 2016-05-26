SHELL := /bin/bash

CC = gcc 

CFLAGS = -O2 
LATEX=pdflatex
LATEXOPT=--shell-escape
LATEXMK=latexmk
LATEXMKOPT=-pdf
LATEXMKBIBTEX=-bibtex
#all: doc compress clean



all: gerador relatorio.pdf clean compress  



############################# - Documentação - #########################################

relatorio.pdf:  report/rel.tex 
	$(LATEXMK) $(LATEXMKBIBTEX) $(LATEXMKOPT) \
		$(LATEXMKBIBTEX) $(CONTINUOUS) \
		            -pdflatex="$(LATEX) $(LATEXOPT) %O %S" \
			    report/rel.tex 
	mv rel.pdf pl15TP2Gr07.pdf 
	rm -fr rel.* 
	rm -fr report/chapters/*.aux 
	rm -fr _minted-rel


compress:  ./src 
	@echo "Preparar ficheiro Zip para entrega...."
	zip -r Tp2.zip ./src/*


############################### - Exercício 2.1  ###########################################


gerador: ./src/gerador.l ./src/gerador.y
	flex ./src/gerador.l
	bison -v -t -d ./src/gerador.y
	$(CC) $(CFLAGS) -c ./src/structures/simple_hashtable.c -o \
	simple_hashtable.o
	$(CC) $(CFLAGS) -g simple_hashtable.o gerador.tab.c -o gerador


clean:  
	@echo "A limpar diretoria...."
	rm -rf *.o
	rm -rf gerador.*
	rm -rf *.o
	rm -rf lex.yy.c
	rm -rf src/*.o
	rm -rf src/lex.yy.c
	rm -rf src/y.tab.c
	#rm -rf ./doc

clean_exec:
	@echo "A eliminar executáveis...."
	rm -rf gerador
	rm -fr pl15TP2Gr07.pdf
	rm -fr Tp2.zip


#test: 
#	./filter_exe2_2a < testes/ex3.bib > testes/resNorm.bib
#	./filter_exe2_2b < testes/ex3.bib > testes/res_pretty_printing.txt
#	./filter_exe2_3 "Tim Teitelbaum" < testes/ex4.bib > testes/res_dot.dot
#	dot -Tpng testes/res_dot.dot -o testes/out.png



