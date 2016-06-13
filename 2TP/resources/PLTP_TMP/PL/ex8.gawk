BEGIN {FS ="::"}
       {split ($2,data,"-"); print "<LI>" $3 "</LI>" >data[1]".html";} 
       


END {print NR;}

