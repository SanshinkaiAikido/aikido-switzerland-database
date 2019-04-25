# aikido-switzerland-database

Scripts to query database of Aikido Switzerland

In order to use these script, create the following four files:

* connection-hostname
* connection-database
* connection-username
* connection-password

with inside one the first line the correct hostname, database, username and password. Note that these files are **not** tracked by git and may only exist on your local machine. Once this files have been properly created the ./list-...sh and ./histrogram-...sh scripts can be used to browse through the data in the database.

In order to change data for existing aikidoka or to add new aikidoka, please follow the next instructions carefully:

* Make sure you have enough experience with SQL queries in order to follow the next steps.
* Run script `./dump-pre.sh` to create a dump of the starting point. The resulting files are called pre-...-records.tsv and are also **not** tracked by git and may only exist temporarily on your machine.
* Copy the file template-insert-records to insert-records.sh, alter the latter file and run it. Note to **only** add members which are training since first of January of this year **and** have at least sixth kyu. The file insert-records.sh is **not** tracked by git and may only exist temporarily on your machine.
* Copy the file template-update-records to update-records.sh, alter the latter file and run it. Note, records are **never** deleted. The file update-records.sh is **not** tracked by git and may only exist temporarily on your machine.
* Run script `./dump-post.sh` to create a dump of the end point. The resulting files are called post-...-records.tsv and are also **not** tracked by git and may only exist temporarily on your machine.
* Diff the pre and post dump files in order to review the changes you made with script `./diff-pre-post.sh`. Also have another person review the changes.
* If something looks wrong, make an extra copy of the pre-...-records.tsv files and ask an experienced database administrator what to do.
* If all checks out OK, and **only** then, remove the files pre-...-records.tsv, post-...-records.tsv, insert-records.sh and update-records.sh. Please notify the person requestion these changes that they have been comitted succesfuly.



# Queries

The following queries are directly available.

## 1 List groups

    ./list-group-records.sh

## 2 List dojos

    ./list-dojo-records.sh [group_id]

## 3 List aikidoka

All aikidoka ever:

    ./list-aikidoka-records.sh [dojo_id]

Only inactive aikidoka:

    ./list-inactive-aikidoka-records.sh [dojo_id]

Only active aikidoka:

    ./list-active-aikidoka-records.sh [dojo_id]

Only summary of active aikidoka:

    ./list-active-aikidoka-records-summary.sh [dojo_id]

Only short (very practical) overview of active aikidoka:

    ./list-active-aikidoka-records-short.sh [dojo_id]

## 4 List 

## List dan exam dates

    ./list-dan-exam-dates.sh

## Internal data

List all table names

    ./list-table-names.sh

List all country codes and country names

    ./list-country-records.sh

List all language codes and language names

    ./list-language-records.sh

## Invoices

    ./list-invoice-records.sh

## Titles

    ./list-title-records.sh


## Overall reports

sudo npm install -g markdown-pdf
markdown-pdf membership_...md
