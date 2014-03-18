if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select * from aikidoka where active = 1"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select * from aikidoka where active = 1 and dojo_id = "$1
fi
