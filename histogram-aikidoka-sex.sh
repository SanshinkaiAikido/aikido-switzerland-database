echo -e -n "male\t"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(*) from aikidoka where active = 1 and female = 0"|tail -n +5
echo -e -n "female\t"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(*) from aikidoka where active = 1 and female = 1"|tail -n +5
