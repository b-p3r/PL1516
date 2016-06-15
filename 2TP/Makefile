SHELL := /bin/bash

CC = gcc 

CFLAGS = -g 
LATEX=pdflatex
LATEXOPT=--shell-escape
LATEXMK=latexmk
LATEXMKOPT=-pdf
LATEXMKBIBTEX=-bibtex
#all: doc compress clean
.IGNORE: testError
.SILENT: testError
.PHONY: testError

all: gerador test testError relatorio.pdf clean compress  


compiler: cleanExec gerador clean 



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

hashTable.o: ./src/hash_table.h ./src/hash_table.c
	 $(CC) $(CFLAGS) -c ./src/hash_table.c -o \
 hashTable.o


programStatus.o: ./src/program_status.h ./src/program_status.c
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

cleanExec:
	@echo "A eliminar executáveis...."
	rm -rf gerador
	rm -fr pl15TP2Gr07.pdf
	rm -fr Tp2.zip


test: 
	@echo "Efetuar testes funcionais"
	./gerador < testes/testesPedidos/01codLpis.txt > testes/testesPedidos/01ass.txt
	./gerador < testes/testesPedidos/02codLpis.txt > testes/testesPedidos/02ass.txt
	./gerador < testes/testesPedidos/03codLpis.txt > testes/testesPedidos/03ass.txt
	./gerador < testes/testesPedidos/04codLpis.txt > testes/testesPedidos/04ass.txt
	./gerador < testes/testesPedidos/05codLpis.txt > testes/testesPedidos/05ass.txt

testError: 
	@echo "Efetuar testes com erros"
	./gerador < testes/outrosTestes/controlo/doWhileAninhado.txt > testes/outrosTestes/controlo/resDoWhileAninhado.txt
	./gerador < testes/outrosTestes/controlo/ifsAninhados.txt > testes/outrosTestes/controlo/resIfsAninhados.txt
	./gerador < testes/outrosTestes/controlo/whileAninhado.txt > testes/outrosTestes/controlo/resWhileAninhado.txt
	./gerador < testes/outrosTestes/tipos/controloTipos/doWhileBooleano.txt > testes/outrosTestes/tipos/controloTipos/resDoWhileBooleano.txt
	./gerador < testes/outrosTestes/tipos/controloTipos/ifelseBooleano.txt > testes/outrosTestes/tipos/controloTipos/resIfelseBooleano.txt 
	./gerador < testes/outrosTestes/tipos/controloTipos/whileBooleano.txt	 > testes/outrosTestes/tipos/controloTipos/resWhileBooleano.txt
	./gerador < testes/outrosTestes/tipos/expressaoeTipos/expaddBooleano2.txt > testes/outrosTestes/tipos/expressaoeTipos/resExpaddBooleano2.txt
	./gerador < testes/outrosTestes/tipos/expressaoeTipos/expaddBooleano.txt  > testes/outrosTestes/tipos/expressaoeTipos/resExpaddBooleano.txt
	./gerador < testes/outrosTestes/tipos/expressaoeTipos/termoBooleano2.txt  > testes/outrosTestes/tipos/expressaoeTipos/resTermoBooleano2.txt
	./gerador < testes/outrosTestes/tipos/expressaoeTipos/termoBooleano.txt > testes/outrosTestes/tipos/expressaoeTipos/resTermoBooleano.txt
	./gerador < testes/outrosTestes/tipos/variaveisTipos/atribBooleano.txt  > testes/outrosTestes/tipos/variaveisTipos/resAtribBooleano.txt
	./gerador < testes/outrosTestes/variaveis/varNdeclaradas.txt > testes/outrosTestes/variaveis/resVarNdeclaradas.txt
	./gerador < testes/outrosTestes/variaveis/varRedeclaradas.txt > testes/outrosTestes/variaveis/resVarNdeclaradas.txt
	./gerador < testes/outrosTestes/variaveis/arrNdeclaradas.txt > testes/outrosTestes/variaveis/resArrNdeclaradas.txt
	./gerador < testes/outrosTestes/variaveis/arrRedeclaradas.txt > testes/outrosTestes/variaveis/resArrRedeclaradas.txt
	./gerador < testes/outrosTestes/variaveis/matNdeclaradas.txt > testes/outrosTestes/variaveis/resMatNdeclaradas.txt
	./gerador < testes/outrosTestes/variaveis/matRedeclaradas.txt > testes/outrosTestes/variaveis/resMatRedeclaradas.txt

	


