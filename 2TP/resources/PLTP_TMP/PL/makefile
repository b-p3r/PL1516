all: alex asin

alex: alex_listas.yy.c
	gcc -o alex alex_listas.yy.c

alex_listas.yy.c: alex_listas.fl
	flex -o alex_listas.yy.c alex_listas.fl

asin: asin_listas.yy.c
	gcc -o asin asin_listas.yy.c

asin_listas.yy.c: asin_listas.fl
	flex -o asin_listas.yy.c asin_listas.fl

clean:
	rm -f *.yy.c
