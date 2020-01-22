if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.email, aikidoka.street, aikidoka.zip, aikidoka.city, country.name, dojo.name FROM aikidoka,dojo,country WHERE aikidoka.active = 1 AND aikidoka.dojo_id = dojo.id AND aikidoka.country_id = country.id ORDER BY dojo.name, aikidoka.name"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT aikidoka.name, aikidoka.email, aikidoka.street, aikidoka.zip, aikidoka.city, country.name, dojo.name FROM aikidoka,country,dojo WHERE aikidoka.active = 1 AND aikidoka.country_id = country.id AND aikidoka.dojo_id = dojo.id AND dojo.group_id = "$1" ORDER BY dojo.name, aikidoka.name"
fi
