
# Nmap Cheat Sheet

## Basic Scans

### Ping Scan

Only discovers up hosts; doesn't scan ports.

`nmap -sn 192.168.1.0/24` 

### Basic Port Scan

Scans the 1,000 most common ports.

`nmap 192.168.1.1` 

### Scan Specific Ports

Scan specified ports.

`nmap -p 22,80,443 192.168.1.1` 

### Scan All Ports

Scans all 65,535 ports.

`nmap -p- 192.168.1.1` 

----------

## Scan Techniques

### TCP SYN Scan

Default scan type; root privileges required. If you use sudo then this is default scan if you don't use sudo and TCP scan will be used.

`nmap -sS 192.168.1.1` 

### TCP Connect Scan

Full TCP connection; doesn't require root.

`nmap -sT 192.168.1.1` 

### UDP Scan

Scans UDP ports; root privileges required.

`nmap -sU 192.168.1.1` 

----------

## Host Discovery

### No Ping

Perform a scan without pinging the host. This is useful to scan host which have firewall and don't allow ICMP protocol

`nmap -Pn 192.168.1.1` 

### ARP Discovery

For local networks; root privileges required.

`nmap -PR 192.168.1.0/24` 

----------

## Service and OS Detection

### Service Version Detection

Detects the version of the running services.

`nmap -sV 192.168.1.1` 

### OS Detection

Detects the operating system.

`nmap -O 192.168.1.1` 

----------

## Output Formats

### Standard Output

Outputs the results to the terminal.

`nmap 192.168.1.1` 

### Output to Text File

Saves the results in a text file.

`nmap -oN output.txt 192.168.1.1` 

### Output to XML

Saves the results in an XML file.

`nmap -oX output.xml 192.168.1.1` 

----------

## Scripting and Timing

### Use Nmap Scripting Engine (NSE)

Run specific NSE scripts.

`nmap --script=http-title 192.168.1.1` 

### Adjust Timing

Change the timing template (0-5).

`nmap -T4 192.168.1.1` 

### Find specific script

`grep <key-work> /usr/share/nmap/scripts/script.db`

# Nmap Stealth and Firewall Evasion Cheat Sheet

## Stealth Scans

### SYN Stealth Scan

Often referred to as "half-open scanning," it doesn't complete the TCP handshake, making it less likely to be logged.

bashCopy code

`nmap -sS 192.168.1.1` 

### FIN, NULL, and Xmas Scans

These scan types can bypass certain firewalls and intrusion detection systems because they use non-standard TCP flags.

-   FIN Scan:
    
    `nmap -sF 192.168.1.1` 
    
-   NULL Scan:
    
    `nmap -sN 192.168.1.1` 
    
-   Xmas Scan:
    
    `nmap -sX 192.168.1.1` 
    

----------

## Firewall and IDS Evasion

### Fragmentation

Breaks up the packets to avoid detection by IDS/IPS.

`nmap -f 192.168.1.1` 

### Specify MTU Size

Fragment packets on a specified MTU size.

`nmap --mtu 24 192.168.1.1` 

### Decoy Scan

Makes your scanning activity blend in with noise by using decoy IP addresses.

`nmap -D RND:10 192.168.1.1` 

Or specify decoys:

`nmap -D decoy1,decoy2,decoy3 192.168.1.1` 

### Use a Specific Source Port

Certain firewalls allow traffic from specific trusted ports.

`nmap --source-port 53 192.168.1.1` 

### Slow Down the Scan

By scanning more slowly, you can reduce the chance of detection.

`nmap -T2 192.168.1.1` 

----------

## Misc

### Send Packets with a Specific MAC Address

This can be useful in bypassing MAC address filters.

`nmap --spoof-mac 00:11:22:33:44:55 192.168.1.1` 

### Avoid DNS Resolution

Skips the domain name resolution.

`nmap -n 192.168.1.1` 

----------

