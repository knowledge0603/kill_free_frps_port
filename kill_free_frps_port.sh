#! /bin/bash
echo "start task :`date '+%Y-%m-%d %H:%M:%S'`"
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
rm -f  result_listen_sed_split.txt
rm -f  result_estab_sed_split.txt
echo $result_listen_sed | awk '{split($0,arr," ");for(i in arr) print arr[i] }' > result_listen_sed_split.txt
echo $result_estab_sed | awk '{split($0,arr," ");for(i in arr) print arr[i] }' > result_estab_sed_split.txt
echo "kill pid is :" $(sort -m <(sort result_listen_sed_split.txt| uniq) <(sort result_estab_sed_split.txt | uniq) <(sort result_estab_sed_split.txt| uniq) | uniq -u)
echo $(sort -m <(sort result_listen_sed_split.txt| uniq) <(sort result_estab_sed_split.txt | uniq) <(sort result_estab_sed_split.txt| uniq) | uniq -u) | xargs kill -9
echo "end  task :`date '+%Y-%m-%d %H:%M:%S'`"
