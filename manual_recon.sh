#!/bin/bash
RHOST='127.0.0.1'
RPORT='4444'
LHOST='127.0.0.1'
LPORT='6900'
USER='UserName'
PW='P@ssw0rd'
DB='Database_Name'
Domain='domain.local'
while [ "$#" -gt 0 ]
do
case "$1" in
	-o) option=$2;;
	-c) config=$2
	RHOST=$(cat $config|grep RHOST|grep -o -P "(?<=').*(?=')")
	RPORT=$(cat $config|grep RPORT|grep -o -P "(?<=').*(?=')")
	LHOST=$(cat $config|grep LHOST|grep -o -P "(?<=').*(?=')")
	DB=$(cat $config|grep DB|grep -o -P "(?<=').*(?=')")
	Domain=$(cat $config|grep Domain|grep -o -P "(?<=').*(?=')")
	USER=$(cat $config|grep USER|grep -o -P "(?<=').*(?=')")
	PW=$(cat $config|grep PW|grep -o -P "(?<=').*(?=')");;
	-rh) RHOST=$2;;
	-rp) RPORT=$2;;
	-lh) LHOST=$2;;
	-lp) LPORT=$2;;
	-db) DB=$2;;
	-d) Domain=$2;;
	-u) USER=$2;;
	-p) PW=$2;;
esac
shift
done
man_help() {
        echo "#--------------------------------------------------------------------------------"
        echo -e "# Get Help\n\n./manual_recon.sh\n"
        echo "#--------------------------------------------------------------------------------"
        echo -e "# Basic Use Of Manual Recon\n\n./manual_recon.sh -o <option> <flags>\n"
        echo "#--------------------------------------------------------------------------------"
        echo -e "# Cheat Sheet Options\n"
        echo -e "-o <cheat_sheet_value> | Value Of Which Cheat Sheet To Show 0R All Of Them\n"
        echo -e "-o e | Exploit Frameworks Cheat Sheet"
        echo -e "-o r | Remote Scanning Cheat Sheet"
        echo -e "-o m | Windows Cheat Sheet"
        echo -e "-o l | Linux Cheat Sheet"
        echo -e "-o s | Stego Cheat Sheet"
        echo -e "-o p | Password/Hash Cracking Cheat Sheet"
        echo -e "-o S | Shells/RevShells Cheat Sheet"
        echo -e "-o w | Web Server Cheat Sheet"
        echo -e "-o d | Database Cheat Sheet\n-o n | Network Pivoting Cheat Sheet\n"
        echo -e "-o a | Dump All Current Cheat Sheets\n"
        echo "#--------------------------------------------------------------------------------"
        echo -e "# RHORT, RPOST, LHOST, and LPORT User Arguments\n"
        echo -e "-rh <RHOST-IP> | RHOST/Target IP-Address\n-rp <RPORT-NUM> | RPORT or Port Number Of Target"
        echo -e "-lp <LHOST-IP> | LHOST/Listen IP-Address\n-lp <LPORT-NUM> | LPORT or Port Number Of Listener\n"
        echo -e "# Domain Nane and Database Name\n\n-db <DB_Name> | Database Name To Use or Select"
        echo -e "-d <Domain_Name> | Domain or Netbios Name Of Remote RHOST\n"
        echo -e "# Custom Username and Password\n\n-u <username> | Username Of A Discovered User\n-p <password> | Password To Test or Has Been Discovered\n"
        echo -e "{!} NOTE: Required User Arguments May Change Based The Option Used {!}\n"
        echo "#--------------------------------------------------------------------------------"
        echo -e "# Manual Recon Examples Commands\n"
        echo -e "./manual_recon.sh -o w -rh 10.10.10.1\n./manual_recon.sh -c user.config -u superadmin\n"
        echo "#--------------------------------------------------------------------------------------"
}
windows_help(){
echo "#--------------------------------------------------------------------------------------"
echo -e "\n--------------------------------------------------------------------------------------\n# Enum Valid Users\n"

echo -e "# Kerberos"

echo -e "# Ways To Authenticate To Windows Machine"

echo -e "# Exploit Group Permissions"

echo -e "# Bypass Windows Security"
echo "#--------------------------------------------------------------------------------------"
}
linux_help(){
echo "--------------------------------------------------------------------------------------"

echo -e "--------------------------------------------------------------------------------------\n# Post Shell Privilege EXEC\n"

echo -e "## Kernel Exploits Checks"

echo -e "## SUID"

echo -e "## File Ownship Checks"

echo -e "## File Caps"

echo -e "## Writable Files"

echo -e "## Crontab Checks"

echo -e "## sudo -l checks"
echo "--------------------------------------------------------------------------------------"
}
stego_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Image Stego"

echo -e "# Document Stego"

echo -e "Audio Stego"
echo "--------------------------------------------------------------------------------------"
}
shell_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Payload Generation With msfvenom"

echo -e "# Online Payload Generation Tools/References"
echo "--------------------------------------------------------------------------------------"
}
website_help(){
echo "#--------------------------------------------------------------------------------------"
echo -e "\n# Web Server Fuzzing\n"

echo -e "--------------------------------------------------------------------------------------\n# Directory Brute Forcing\n"
echo -e "## Feroxbuster Directory Fuzzing\n"
echo -e "feroxbuster -u $RHOST"
echo -e "feroxbuster -u $RHOST -w ./wordlist.txt"
echo -e "feroxbuster -u $RHOST -w ./wordlist.txt -e txt,php,html,bak"

echo -e "\n## Dirb Directory Fuzzing"
echo -e "dirb http://$RHOST\ndirb http://$RHOST -X .txt,.php,.html,.bak -o dirb.out\n"
echo -e "dirb http://$RHOST ./wordlist.txt -X .txt,.bak,.php"

echo -e "\n## Wfuzz Directory Fuzzing"
echo -e "wfuzz -c -u http://$RHOST/FUZZ -w ./wordlist.txt -f wfuzz.out\nwfuzz -c -u http://$RHOST/FUZZ -w ./wordlist.txt --hc=404 -f wfuzz.out"

echo -e "\n## Ffuf Directory Fuzzing\n"
echo -e "ffuf -c -w ./wordlist.txt -u http://$RHOST/FUZZ -o ffuf.out"
echo -e "ffuf -c -w ./wordlist.txt -u http://$RHOST/FUZZ -e .txt,.html,.php,bak -o ffuf.out"
echo -e "ffuf -c -w ./wordlist.txt -u http://$RHOST/FUZZ -fc 404 -e .txt,.html,.php,bak -o ffuf.out"

echo -e "\n## Gobuster Directory Fuzzing\n"
echo -e "gobuster dir -u http://$RHOST -w ./wordlist.txt -o gobust.out"
echo -e "gobuster dir -u http://$RHOST -w ./wordlist.txt -x txt,php,html,bak -o gobust.out\n"

echo -e "--------------------------------------------------------------------------------------\n# Virtual Host Routing / Sub Domain Fuzzing\n"
echo -e "## Vhost Fuzzing With Wfuzz\n\nwfuzz -c -f sub_wfuzz.out -Z -w top5000.txt -u 'http://$Domain' -H 'Host: FUZZ'"

echo -e "\n## Vhost Fuzzing Wtih Ffuf\n"
echo -e "ffuf -c -w top5000.txt -u http://$RHOST/ -o sub_ffuf.out -H 'Host: FUZZ.$Domain'\n"

echo -e "## Vhost Fuzzing With Gobuster\n"

echo -e "gobuster vhost -w top5000.txt -u http://$Domain/ -o vhost_gobust.out\n"

echo -e "--------------------------------------------------------------------------------------\n# Web Technology CMS Fuzzing\n"

echo -e "## Web TechNology Leaks In HTTP Response Headers"
echo -e "\nwhatweb $RHOST\n\ncurl http://$RHOST -v\n"

echo -e "## Wordpress\n"
echo -e "wpscan --url http://$RHOST/wordpress\n\nwpscan --url http://$RHOST/wordpress -e u\nwpscan --url http://$RHOST/wordpress -e vt, at, t\n"
echo -e "wpscan --url http://$RHOST/wordpress -P /usr/share/wordlists/fasttrack.txt -U $USER -t 35"
echo -e "wpscan --url http://$RHOST/wordpress -P /usr/share/wordlists/fasttrack.txt -U user.lst -t 35"

echo -e "wpscan -v --proxy socks5://127.0.0.1:1080 --url http://$RHOST/wordpress"

echo -e "\n## ActiveMQ\n"
echo -e "mosquitto_sub -h $RHOST -p 61616 -t secret_chat -u admin -P admin -V 31"
echo -e "mosquitto_sub -h $RHOST -p 61616 -t secret_chat -u $USER -P $PW -V 31"


echo -e "\n## Drupal\n"
echo -e "droopescan scan drupal -u http://$RHOST/ -t 32\n"

echo "#--------------------------------------------------------------------------------------"
}
database_help(){
echo "#--------------------------------------------------------------------------------------"
echo -e "\n# Remote DataBase Clients\n"

echo -e "--------------------------------------------------------------------------------------\n## MySQL Client\n"
echo -e "mysql -u root -p\nmysql -u root -p -h $RHOST\n"
echo -e "mysql -D $DB -u root -p -h $RHOST"
echo -e "mysql -D $DB -u root --password=$PW -e 'select * from users'\n"

echo -e "--------------------------------------------------------------------------------------\n## Microsoft SQL Clients\n"
echo -e "impacket-mssqlclient $USER@$RHOST -windows-auth\n"
echo -e "impacket-mssqlclient $Domain/$USER@$RHOST -windows-auth"
echo -e "impacket-mssqlclient $Domain/$USER:$PW@$RHOST\n"

echo -e "mssql -s $RHOST -u $USER -p $PW\n"

echo -e "--------------------------------------------------------------------------------------\n## No-SQL Client\n"
echo -e "### Redis Server\n\nredis-cli -h $RHOST\nredis-cli -h $RHOST ping\nredis-cli -h $RHOST info\n"

echo -e "### Apache CouchDB\n\n(FireFox) URL == http://$RHOST:5984/_utils\n"
echo -e "curl http://$RHOST:5984/_all_dbs\ncurl http://$RHOST:5984/secret/_all_docs\n"
echo -e "curl -X GET http://$RHOST:5984/Database_Name/Record-ID-Hash | jq"
echo -e "curl -X GET http://$RHOST:5984/secret/a1320dd69fb4570d0a3d26df4e000be7 | jq"

echo -e "\n--------------------------------------------------------------------------------------\n# Simple SQL Injections\n"
echo -e "## Automated SQL-Injection Checks\n\nsqlmap -u http://$RHOST/login.php\nsqlmap -r webrequest.req\n"

echo -e "## Manual SQL-Injection Checks\n"

echo "#--------------------------------------------------------------------------------------"
}
#---------------------------------------------
remote_help(){
echo "#--------------------------------------------------------------------------------------"
echo -e "# Port Scanning"
echo -e "nmap -v -p- -Pn $RHOST -oN nmap.out"
echo -e "nmap -Pn -p1-1000 -v -sC -sV $RHOSTS -oN script_nmap.out\n"
echo -e ""
echo "#--------------------------------------------------------------------------------------"
}
exploit_frameworks(){
echo "#--------------------------------------------------------------------------------------"
echo -e "\n--------------------------------------------------------------------------------------\n# Metasploit"
echo -e "sudo systemctl start postgresql && msfconsole\n\nsudo systemctl start postgresql && APRILFOOLSPONIES=true msfconsole"
echo -e "sudo systemctl start postgresql && THISISHALLOWEEN=true msfconsole\n"
echo -e "msfdb run"

echo -e "\n--------------------------------------------------------------------------------------\n# PowerShell-Empire (Needs Two Terminals For <Server & Client>)"
echo -e "\nsudo powershell-empire server\nsudo powershell-empire client\n"

echo -e "--------------------------------------------------------------------------------------\n# Covenant C2\n\ndotnet run"
echo -e "docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v </absolute/path/to/Covenant/Covenant/Data>:/app/Data covenant\n"
echo "#--------------------------------------------------------------------------------------"
}
pw_cracking_help(){
echo "#--------------------------------------------------------------------------------------"
echo -e "\n--------------------------------------------------------------------------------------\n# Ways To ID Identify The Hash Type"

echo -e "\nhashcat --example-hashes | less\n\nhashid hash.txt\nhashid <hash-string>\nhashid <hash-string> -mj\n"

echo -e "echo -n '<hash-string>' | hash-identifier\ncat hash.txt | hash-identifier\n"

echo -e "haiti <hash-string>\nhaiti -e <extended_salted_hash-string>\n"

echo -e "--------------------------------------------------------------------------------------\n# Password/Hash Cracking With Hashcat\n"
echo -e "hashcat -m <hash-mode-number> hash.txt /usr/share/wordlists/rockyou.txt"
echo -e "hashcat -m 0 md5_hash.txt /usr/share/wordlists/rockyou.txt\n"

echo -e "--------------------------------------------------------------------------------------\n# Password/Hash Cracking With John The Ripper\n"
echo -e "john hash.txt\njohn hash.txt -w=/usr/share/wordlists/rockyou.txt\n"
echo "#--------------------------------------------------------------------------------------"
}
network_pivoting(){
echo "Pivoting Not Finsihed"
}
#===================================
print_all_manual_recon(){
	windows_help
	linux_help
	stego_help
	website_help
	database_help
	remote_help
	network_pivoting
	exploit_frameworks
	pw_cracking_help
}
#--------------------------------
if [[ $option == "m" ]]; then
	windows_help
elif [[ $option == "l" ]]; then
	linux_help
elif [[ $option == "s" ]]; then
	stego_help
elif [[ $option == "S" ]]; then
	shell_help
elif [[ $option == "w" ]]; then
	website_help
elif [[ $option == "d" ]]; then
	database_help
elif [[ $option == "r" ]]; then
	remote_help
elif [[ $option == "n" ]]; then
	network_pivoting
elif [[ $option == "p" ]]; then
	pw_cracking_help
elif [[ $option == "e" ]]; then
	exploit_frameworks
elif [[ $option == "a" ]]; then
	print_all_manual_recon
else
	man_help
fi
