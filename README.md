#facs_documents

Documents and database schema for the [resource management
project](https://github.com/qbicsoftware/resource-management).

#Quick Setup
<code>git clone https://github.com/qbicsoftware/resource-management-data.git</code>

##Initialize the database
Install mysql or mariadb.
Open a console:
connect to mysql, e.g. <code> mysql -u user_name -h host_name -p</code>
where *user_name* is your database user name and *host_name* is the name of your
host, e.g. localhost.

create a database. <code>CREATE DATABASE database_name;</code>
where *database_name* is the name of your database. e.g. facs_facility.
logout with ctrl-D
fill tables: <code>mysql facs_facility -u facs -p < create_schema.sql</code>

##Templates
Documents like tex files, which are prepared to be filled with [apache
velocity](https://velocity.apache.org/). E.g. bills that can be created
automatically from user statistics.





