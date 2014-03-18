if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select * from dojo"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select * from dojo where group_id = "$1
fi
