echo -e -n "male\t" >histogram-aikidoka-sex.tsv
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(id) from aikidoka where active = 1 and female = 0"|tail -n +5 >>histogram-aikidoka-sex.tsv
echo -e -n "female\t" >>histogram-aikidoka-sex.tsv
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(id) from aikidoka where active = 1 and female = 1"|tail -n +5 >>histogram-aikidoka-sex.tsv
