exit
#TODO
if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.id, dojo.name, aikidoka.dateofbirth, aikidoka.dateofstart, aikidoka.dateof10kyu, aikidoka.dateof09kyu, aikidoka.dateof08kyu, aikidoka.dateof07kyu, aikidoka.dateof06kyu, aikidoka.dateof05kyu, aikidoka.dateof04kyu, aikidoka.dateof03kyu, aikidoka.dateof02kyu, aikidoka.dateof01kyu, aikidoka.dateof01dan, aikidoka.dateof02dan, aikidoka.dateof03dan, aikidoka.dateof04dan, aikidoka.dateof05dan, aikidoka.dateof06dan, aikidoka.dateof07dan, aikidoka.dateof08dan, title.titel, title.year FROM aikidoka,dojo,title WHERE aikidoka.active = 1 AND aikidoka.dojo_id = dojo.id AND aikidoka.id = title.aikidoka_id ORDER BY dojo.name, aikidoka.name"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.email, aikidoka.street, aikidoka.zip, aikidoka.city, country.name, dojo.name FROM aikidoka,country,dojo WHERE aikidoka.active = 1 AND aikidoka.country_id = country.id AND aikidoka.dojo_id = dojo.id AND dojo.group_id = "$1" ORDER BY dojo.name, aikidoka.name"
fi
