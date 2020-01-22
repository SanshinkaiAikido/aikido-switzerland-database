if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT DISTINCT email FROM aikidoka WHERE active = 1 AND email != '' ORDER BY email"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT DISTINCT email FROM aikidoka WHERE active = 1 AND email != '' AND dojo_id = "$1" ORDER BY email"
fi
