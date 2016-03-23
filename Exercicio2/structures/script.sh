loop="$1"


for i in `seq 1 $loop `;
do
	STR=$(cat /dev/urandom | tr -dc 'A-Za-z0-9`^~_\\ "' | fold -w 32 | head -n 1)
	
	echo $STR 
done    
