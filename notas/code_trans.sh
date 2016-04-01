for f in *.tex
do
	touch tmp.tex
	cat $f | iconv -f UTF-8 -t ASCII//TRANSLIT  > tmp.tex && mv tmp.tex $f	
	touch tmp.tex
	cat $f | sed 's/\r$//' > tmp.tex && mv tmp.tex $f
	
	
	echo "Done with - $f"
done

