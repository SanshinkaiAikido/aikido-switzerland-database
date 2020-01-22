stamp=`date +%Y%m%d`
if [ $# -ne 1 ]
then
	echo -e 'Name\tID\tDojo\tBirth\tStart\t10 kyu\t9 kyu\t8 kyu\t7 kyu\t6 kyu\t5 kyu\t4 kyu\t3 kyu\t2 kyu\t1 kyu\tshodan\t2 dan\t3 dan\t4 dan\t5 dan\t6 dan\t7 dan\t8 dan' >$stamp-active-aikidoka-grades.tsv
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.id, dojo.name, aikidoka.dateofbirth, aikidoka.dateofstart, aikidoka.dateof10kyu, aikidoka.dateof09kyu, aikidoka.dateof08kyu, aikidoka.dateof07kyu, aikidoka.dateof06kyu, aikidoka.dateof05kyu, aikidoka.dateof04kyu, aikidoka.dateof03kyu, aikidoka.dateof02kyu, aikidoka.dateof01kyu, aikidoka.dateof01dan, aikidoka.dateof02dan, aikidoka.dateof03dan, aikidoka.dateof04dan, aikidoka.dateof05dan, aikidoka.dateof06dan, aikidoka.dateof07dan, aikidoka.dateof08dan FROM aikidoka,dojo WHERE aikidoka.active = 1 AND aikidoka.dojo_id = dojo.id ORDER BY dojo.name, aikidoka.name"|tail -n +5 >>$stampctive-aikidoka-grades.tsv
else
	echo -e 'Name\tID\tDojo\tBirth\tStart\t10 kyu\t9 kyu\t8 kyu\t7 kyu\t6 kyu\t5 kyu\t4 kyu\t3 kyu\t2 kyu\t1 kyu\tshodan\t2 dan\t3 dan\t4 dan\t5 dan\t6 dan\t7 dan\t8 dan' >$stamp-active-aikidoka-grades-group-$1.tsv
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.id, dojo.name, aikidoka.dateofbirth, aikidoka.dateofstart, aikidoka.dateof10kyu, aikidoka.dateof09kyu, aikidoka.dateof08kyu, aikidoka.dateof07kyu, aikidoka.dateof06kyu, aikidoka.dateof05kyu, aikidoka.dateof04kyu, aikidoka.dateof03kyu, aikidoka.dateof02kyu, aikidoka.dateof01kyu, aikidoka.dateof01dan, aikidoka.dateof02dan, aikidoka.dateof03dan, aikidoka.dateof04dan, aikidoka.dateof05dan, aikidoka.dateof06dan, aikidoka.dateof07dan, aikidoka.dateof08dan FROM aikidoka,dojo WHERE aikidoka.active = 1 AND aikidoka.dojo_id = dojo.id AND dojo.group_id = "$1" ORDER BY dojo.name, aikidoka.name"|tail -n +5 >>$stamp-active-aikidoka-grades-group-$1.tsv
fi