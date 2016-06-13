
BEGIN {FS="<|>";conta=0}
/[Hh][Rr][Ee][Ff]/ {conta++; print $3}

END {print conta}

