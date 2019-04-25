if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select email from aikidoka where active = 1 and email != ''"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select email from aikidoka where active = 1 and email != '' and dojo_id = "$1
fi
