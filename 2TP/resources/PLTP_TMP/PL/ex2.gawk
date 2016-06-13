BEGIN {conta=0}

/<[^>]*>/ {conta ++;print $0}


END {print conta}
