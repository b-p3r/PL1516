BEGIN {FS= "\""; conta=0}

/[hH][rR][eE][fF]/ { conta++; print $2}

 END { print conta}


