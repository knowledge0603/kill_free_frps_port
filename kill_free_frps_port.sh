#! /bin/bash
#ss -atp | grep frp | grep 128| awk '{print $6}'| sed 's/^.*pid=//g'|sed 's/,.*$//g'| xargs kill -9
result=$( ss -atp | grep frps)
echo "---------------------------source string"
echo "$result"
result_listen=$(ss -apt | grep frps | grep LISTEN)
result_estab=$(ss -apt | grep frps | grep ESTAB)
result_listen_sed=$(ss -apt | grep frps | grep LISTEN |sed 's/^.*pid=//g'|sed 's/,.*$//g')
result_estab_sed=$(ss -apt | grep frps | grep ESTAB |sed 's/^.*pid=//g'|sed 's/,.*$//g')
echo "---------------------------listen string"
echo "$result_listen"
echo "---------------------------estab string"
echo "$result_estab"
echo "---------------------------listen string sed"
echo "$result_listen_sed"
echo "---------------------------estab string sed"
echo "$result_estab_sed"
echo "---------------------------diff string  [kill pid] "
#echo $(sort -m <(sort result_listen_sed.txt| uniq) <(sort result_estab_sed.txt | uniq) <(sort result_estab_sed.txt| uniq) | uniq -u)
#echo ${result_listen_sed//result_estab_sed/---}  
echo $result_listen_sed | awk '{split($0,arr," ");for(i in arr) print arr[i] }' > result_listen_sed_split.txt
echo $result_estab_sed | awk '{split($0,arr," ");for(i in arr) print arr[i] }' > result_estab_sed_split.txt
echo "kill pid is :" $(sort -m <(sort result_listen_sed_split.txt| uniq) <(sort result_estab_sed_split.txt | uniq) <(sort result_estab_sed_split.txt| uniq) | uniq -u)
echo $(sort -m <(sort result_listen_sed_split.txt| uniq) <(sort result_estab_sed_split.txt | uniq) <(sort result_estab_sed_split.txt| uniq) | uniq -u) | xargs kill -9