#!/bin/bash
RHOST='127.0.0.1'
RPORT='4444'
LHOST='127.0.0.1'
LPORT='6900'
SUBNET='127.0.0.1/24'
INSIDE_BOX='172.16.10.5'
USER='UserName'
LUSER='kali'
PW='P@ssw0rd'
DB='Database_Name'
Domain='domain.local'
GROUP='sys-admin'
while [ "$#" -gt 0 ]
do
case "$1" in
	-o) option=$2;;
	-c) config=$2
	RHOST=$(cat $config|grep RHOST|grep -o -P "(?<=').*(?=')")
	RPORT=$(cat $config|grep RPORT|grep -o -P "(?<=').*(?=')")
	LHOST=$(cat $config|grep LHOST|grep -o -P "(?<=').*(?=')")
	SUBNET=$(cat $config|grep SUBNET|grep -o -P "(?<=').*(?=')")
	DB=$(cat $config|grep DB|grep -o -P "(?<=').*(?=')")
	Domain=$(cat $config|grep Domain|grep -o -P "(?<=').*(?=')")
	USER=$(cat $config|grep USER|grep -o -P "(?<=').*(?=')")
	LUSER=$(cat $config|grep 'LUSER'|grep -o -P "(?<=').*(?=')")
	PW=$(cat $config|grep PW|grep -o -P "(?<=').*(?=')")
	INSIDE_BOX=$(cat $config|grep 'INSIDE_BOX'|grep -o -P "(?<=').*(?=')")
	GROUP=$(cat $config|grep GROUP|grep -o -P "(?<=').*(?=')");;
	-rh) RHOST=$2;;
	-rp) RPORT=$2;;
	-lh) LHOST=$2;;
	-lp) LPORT=$2;;
	-db) DB=$2;;
	-d) Domain=$2;;
	-u) USER=$2;;
	-p) PW=$2;;
	-g) GROUP=$2;;
	-lu) LUSER=$2;;
	-ib) INSIDE_BOX=$2;;
	-ih) INSIDE_BOX=$2;;
	-s) SUBNET=$2
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
	echo -e "-o m | Windows Cheat Sheet"
	echo -e "-o l | Linux Cheat Sheet"
	echo -e "-o s | Stego Cheat Sheet"
	echo -e "-o p | Password/Hash Cracking Cheat Sheet"
	echo -e "-o w | Web Server Cheat Sheet"
	echo -e "-o d | Database Cheat Sheet\n-o n | Network Pivoting Cheat Sheet"
	echo -e "-o f | How To Transfer Files Between Machines Cheat Sheet\n"
	echo -e "-o a | Dump All Current Cheat Sheets\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# RHORT, RPOST, LHOST, LPORT, and other User Arguments\n "
	echo -e "-rh <RHOST-IP> | RHOST/Target IP-Address\n-rp <RPORT-NUM> | RPORT or Port Number Of Target"
	echo -e "-lp <LHOST-IP> | LHOST/Listen IP-Address\n-lp <LPORT-NUM> | LPORT or Port Number Of Listener\n"
	echo -e "-s <SUBNET> | <SUBNET/SUBNET_MASK> To set for certain cheat sheets like network pivoting"
	echo -e "-ib 0r -ih <INTERNAL-Box/INTERAL-Host> | IP-Address 0r Hostname of Internal Machine Inside a network you need to Pivot to\n"
	echo -e "# Domain Nane and Database Name\n\n-db <DB_Name> | Database Name To Use or Select"
	echo -e "-d <Domain_Name> | Domain or Netbios Name Of Remote RHOST\n"
	echo -e "# Custom Username and Password\n\n-u <username> | Username Of A Discovered User\n-p <password> | Password To Test or Has Been Discovered\n"
	echo -e "# Additional Arguments For Some Cheat Sheats\n\n-g <group-name> | Set a custom group name for some options"
	echo -e "-lu <local-username> | Set a username for your own or local machnie used in Pivoting and cheat sheets"
	echo -e "\n{!} NOTE: Required User Arguments May Change Based The Option Used {!}\n"
	echo "#--------------------------------------------------------------------------------"
	echo -e "# Manual Recon Examples Commands\n"
	echo -e "./manual_recon.sh -o w -rh 10.10.10.1\n./manual_recon.sh -c user.config -u superadmin"
	echo -e "./manual_recon.sh -o n -rh 10.10.138.2 -s 10.10.138.0/24 -u cthulhu -lh 10.15.28.40 -ib 172.16.4.21"
	echo -e "\n#--------------------------------------------------------------------------------------"
}
print_all_manual_recon(){
	. ./recon_scripts/windows
	. ./recon_scripts/linux
	. ./recon_scripts/stego
	. ./recon_scripts/website
	. ./recon_scripts/database
	. ./recon_scripts/network_pivoting
	. ./recon_scripts/pw_cracking
	. ./recon_scripts/exploit_frameworks
	. ./recon_scripts/file_transfer
}
#--------------------------------
if [[ $option == "m" ]]; then
	. ./recon_scripts/windows
elif [[ $option == "l" ]]; then
	. ./recon_scripts/linux
elif [[ $option == "s" ]]; then
	. ./recon_scripts/stego
elif [[ $option == "w" ]]; then
	. ./recon_scripts/website
elif [[ $option == "d" ]]; then
	. ./recon_scripts/database
elif [[ $option == "n" ]]; then
	. ./recon_scripts/network_pivoting
elif [[ $option == "p" ]]; then
	. ./recon_scripts/pw_cracking
elif [[ $option == "e" ]]; then
	. ./recon_scripts/exploit_frameworks
elif [[ $option == "f" ]]; then
	. ./recon_scripts/file_transfer
elif [[ $option == "a" ]]; then
	print_all_manual_recon
else
	man_help
fi
