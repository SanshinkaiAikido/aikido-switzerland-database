if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select aikidoka.id, aikidoka.name, substring(aikidoka.dateofbirth, 1, 4) as born, aikidoka.email, dojo.name as dojo from aikidoka,dojo where aikidoka.active = 1 and (aikidoka.email = '' or aikidoka.email like '% %' or aikidoka.email like '%<%' or aikidoka.email like '%>%' or aikidoka.email not like '%@%') and aikidoka.dojo_id = dojo.id order by aikidoka.dojo_id"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select aikidoka.id, aikidoka.name, substring(aikidoka.dateofbirth, 1, 4) as born, aikidoka.email, dojo.name as dojo from aikidoka,dojo where aikidoka.active = 1 and (aikidoka.email = '' or aikidoka.email like '% %' or aikidoka.email like '%<%' or aikidoka.email like '%>%' or aikidoka.email not like '%@%') and aikidoka.dojo_id = dojo.id and dojo_id = "$1" order by dojo_id"
fi
