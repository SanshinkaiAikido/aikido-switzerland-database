echo "1st dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof01dan from aikidoka where dateof01dan is not NULL order by dateof01dan"|tail -n +5|grep 2017-
echo "2nd dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof02dan from aikidoka where dateof02dan is not NULL order by dateof02dan"|tail -n +5|grep 2017-
echo "3rd dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof03dan from aikidoka where dateof03dan is not NULL order by dateof03dan"|tail -n +5|grep 2017-
echo "4th dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof04dan from aikidoka where dateof04dan is not NULL order by dateof04dan"|tail -n +5|grep 2017-
echo "5th dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof05dan from aikidoka where dateof05dan is not NULL order by dateof05dan"|tail -n +5|grep 2017-
echo "6th dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof06dan from aikidoka where dateof06dan is not NULL order by dateof06dan"|tail -n +5|grep 2017-
echo "7th dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof07dan from aikidoka where dateof07dan is not NULL order by dateof07dan"|tail -n +5|grep 2017-
echo "8th dan"
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select dateof08dan from aikidoka where dateof08dan is not NULL order by dateof08dan"|tail -n +5|grep 2017-

