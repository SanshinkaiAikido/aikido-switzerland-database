echo -e -n "active\t" >histogram-aikidoka-active.tsv
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(id) from aikidoka where active = 1"|tail -n +5 >>histogram-aikidoka-active.tsv
echo -e -n "inactive\t" >>histogram-aikidoka-active.tsv
mysql --silent -h `cat connection-hostname` -u `cat connection-username` -p`cat connection-password` -D `cat connection-database` -v -e "select count(id) from aikidoka where active = 0"|tail -n +5 >>histogram-aikidoka-active.tsv
