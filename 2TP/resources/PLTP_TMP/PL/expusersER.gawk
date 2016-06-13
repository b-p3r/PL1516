BEGIN {conta=0}


/^linha/ {conta++}     


END {print conta}
