./list-group-records.sh|tail -n +5 > groups.tsv
./list-dojo-records.sh|tail -n +5 > dojos.tsv
./list-active-aikidoka-records.sh|tail -n +5 > aikidokas.tsv
./graph.py
