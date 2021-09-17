#!/bin/bash
RHOST='127.0.0.1'
RPORT='4444'
LHOST='127.0.0.1'
LPORT='6900'
while getopts ":h:o:r:rp:lh:lp:" opts
do
	case "${opts}" in
	h) helper=${OPTARG};;
	o) option=${OPTARG};;
	r) RHOST=${OPTARG};;
	rp) RPORT=${OPTARG};;
	lh) LHOST=${OPTARG};;
	lp) LPORT=${OPTARG};;
esac
done
#-----------------------------------------------------------------------------
# man page
man_help() {
	echo "#--------------------------------------------------------------------------------"
	echo -e "# Get Help\n\n./manual_recon.sh\nOR\n./manual_recon.sh -h\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# Basic Use Of Manual Recon\n\n./manual_recon.sh -o <option> <flags>\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# Cheat Sheet Options\n"
	echo -e "-o <cheat_sheet_value> | Value Of Which Cheat Sheet To Show 0R All Of Them"
	echo -e "-o e | Exploit Frameworks Cheat Sheet"
	echo -e "-o r | Remote Scanning Cheat Sheet"
	echo -e "-o m | Windows Cheat Sheet"
	echo -e "-o l | Linux Cheat Sheet"
	echo -e "-o s | Stego Cheat Sheet"
	echo -e "-o p | Password/Hash Cracking Cheat Sheet"
	echo -e "-o S | Shells/RevShells Cheat Sheet"
	echo -e "-o w | Web Server Cheat Sheet"
	echo -e "-o d | Database Cheat Sheet"
	echo -e "-o a | Dump All Current Cheat Sheets\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# RHORT, RPOST, LHOST, and LPORT User Arguments\n"
	echo -e "-rh <RHOST-IP> | RHOST/Target IP-Address\n-rp <RPORT-NUM> | RPORT or Port Number Of Target"
	echo -e "-lp <LHOST-IP> | LHOST/Listen IP-Address\n-lp <LPORT-NUM> | LPORT or Port Number Of Listener\n"
	echo -e "{!} NOTE: Required User Arguments May Change Based The Option Used {!}\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# Manual Recon Examples Commands\n"
	echo -e "./manual_recon.sh -o w -rh 10.10.10.1\n"
}
#----------------------------------
# all manual recon print functions
windows_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Kerberos"

echo -e "# Ways To Authenticate To Windows Machine"

echo -e "# Exploit Group Permissions"

echo -e "# Bypass Windows Security"
echo "--------------------------------------------------------------------------------------"
}
#---------------------------------
linux_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Kernel Exploits Checks"

echo -e "# SUID"

echo -e "# File Ownship Checks"

echo -e "# File Caps"

echo -e "# Writable Files"

echo -e "# Crontab Checks"

echo -e "# sudo -l checks"
echo "--------------------------------------------------------------------------------------"
}
#---------------------------------
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
#---------------------------------
website_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Web Technology Fuzzing"
echo -e

echo -e "# Directory Brute Forcing"
echo -e "## Feroxbuster\n"
echo -e "### Default Feroxbuster Directory Scan\n"
echo -e "feroxbuster -u <url.thm>"

echo -e "### Feroxbuster Directory Scan With Another Wordlist"
echo -e "feroxbuster -u <url> -w </path/to/wordslist.txt\>n-u | <rhost-ip_OR_domain>\n-w | <wordlist.txt>"

echo -e "\n### Feroxbuster Directory Scan With Extentions"
echo -e "feroxbuster -u <url> -w </path/to/wordlist.txt> -e txt,php,html,bak"

echo -e "\n## Dirb "
echo -e "dirb http://$RHOST\ndirb http://$RHOST -X .txt,.php,.html,.bak -o dirb.out\nOR\n"
echo -e "dirb http://$RHOST /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -X .txt"

echo -e "\n## Wfuzz"
echo -e "wfuzz -c -u http://$RHOST/FUZZ -w </path/to/wordlist.txt>"

echo -e "\n## Ffuf"
echo -e "ffuf "

echo -e "\n## Gobuster"
echo -e "gobuster dir -u http://$RHOST -w /path/to/wordlist.txt -x txt,php,html,bak -o gobust.out"

echo -e "# Virtual Host Routing / Sub Domain Fuzzing"
echo -e "## Vhost Fuzzing With Wfuzz"

echo -e "## Vhost Fuzzing Wtih Ffuf"

echo -e "## Vhost Fuzzing With gobuster"

echo -e "#"
echo "--------------------------------------------------------------------------------------"
}
#---------------------------------------------
database_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Remote DataBase Clients"

echo -e "# Simple SQL Injections"
echo "--------------------------------------------------------------------------------------"
}
#---------------------------------------------
remote_help(){
echo "--------------------------------------------------------------------------------------"
echo -e "# Port Scanning"
echo -e "nmap -v -p- -Pn $RHOST -oN nmap.out"
echo -e "nmap -Pn -p1-1000 -v -sC -sV $RHOSTS -oN script_nmap.out\n"
echo -e "
}
exploit_frameworks(){
echo -e "# Metasploit"
echo -e "sudo systemctl start postgresql && msfconsole"
echo -e "msfdb run"

echo -e "# PowerShell-Empire"
echo -e "#

echo -e "# Covenant"
}
pw_cracking_help(){
echo -e "# Ways To ID Identify The Hash Type"

echo -e "# Password/Hash Cracking With Hashcat"

echo -e "# Password/Hash Cracking With John The Ripper"
echo "--------------------------------------------------------------------------------------"
}
#===================================
print_all_manual_recon(){
	windows_help
	linux_help
	stego_help
	website_help
	database_help
	remote_help
	exploit_frameworks
	pw_cracking_help
}
#====================================
if [[ $helper == "-h" ]]; then
	man_help
elif [[ $option == "m" ]]; then
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
elif [[ $option == "p" ]]; then
	pw_cracking_help
elif [[ $option == "e" ]]; then
	exploit_frameworks
elif [[ $option == "a" ]]; then
	print_all_manual_recon
else
	man_help
fi
