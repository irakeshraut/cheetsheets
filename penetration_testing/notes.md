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


