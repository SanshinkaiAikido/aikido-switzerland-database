if [ $# -ne 1 ]
then
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT dojo.name, dojo.dojocho, dojo.email, dojo.address, dojo.zip, dojo.city, country.name FROM dojo,country WHERE dojo.country_id = country.id ORDER BY dojo.name"
else
	mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "SELECT dojo.name, dojo.dojocho, dojo.email, dojo.address, dojo.zip, dojo.city, country.name FROM country,dojo WHERE dojo.country_id = country.id AND dojo.group_id = "$1" ORDER BY dojo.name"
fi
