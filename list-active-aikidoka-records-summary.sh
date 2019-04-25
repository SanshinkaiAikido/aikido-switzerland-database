if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select id, name, dateofstart, dateof06kyu, dateof05kyu, dateof04kyu, dateof03kyu, dateof02kyu, dateof01kyu, dateof01dan, dateof02dan, dateof03dan, dateof04dan from aikidoka where active = 1"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select id, name, dateofstart, dateof06kyu, dateof05kyu, dateof04kyu, dateof03kyu, dateof02kyu, dateof01kyu, dateof01dan, dateof02dan, dateof03dan, dateof04dan from aikidoka where active = 1 and dojo_id = "$1
fi
