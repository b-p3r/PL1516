SHELL := /bin/bash

CC = gcc 

CFLAGS = -g 
LATEX=pdflatex
LATEXOPT=--shell-escape
LATEXMK=latexmk
LATEXMKOPT=-pdf
LATEXMKBIBTEX=-bibtex
#all: doc compress clean



all: gerador test relatorio.pdf clean compress  


compiler: clean_exec gerador clean 



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




gerador: program_status.o hash_table.o entry.o ./src/gerador.l ./src/gerador.y 
	flex ./src/gerador.l
	bison -v -t -d ./src/gerador.y
	$(CC) $(CFLAGS)  program_status.o hash_table.o entry.o gerador.tab.c -o gerador

hash_table.o: ./src/hash_table.h ./src/hash_table.c
	 $(CC) $(CFLAGS) -c ./src/hash_table.c -o \
		         hash_table.o


program_status.o: ./src/program_status.h ./src/program_status.c
	 $(CC) $(CFLAGS) -c ./src/program_status.c -o program_status.o

entry.o: ./src/entry.h ./src/entry.c
	$(CC) $(CFLAGS) -c ./src/entry.c -o \
		         entry.o

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


test: 
	./gerador < testes/testesPedidos/01codLpis.txt > testes/testesPedidos/01ass.txt
	./gerador < testes/testesPedidos/02codLpis.txt > testes/testesPedidos/02ass.txt
	./gerador < testes/testesPedidos/03codLpis.txt > testes/testesPedidos/03ass.txt
	./gerador < testes/testesPedidos/04codLpis.txt > testes/testesPedidos/04ass.txt
	./gerador < testes/testesPedidos/05codLpis.txt > testes/testesPedidos/05ass.txt


