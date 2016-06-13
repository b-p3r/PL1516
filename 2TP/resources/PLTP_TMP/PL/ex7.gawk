BEGIN {FS="::"}

{split ($2,data,"-"); conta[data[1]]++}

END {for(ano in conta) {print ano "->" conta[ano]}}
