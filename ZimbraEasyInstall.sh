#!/usr/bin/env bash
## Author: Michael Ramsey
## Objective Install Zimbra and optional extras in an easy and automated universal fashion.
## https://github.com/whattheserver/zimbra-automated-installation
## How to use.
# ./ZimbraEasyInstall.sh domain
#./ZimbraEasyInstall.sh zimbra.io --ip 192.168.211.40 --password Zimbra2017
#
## link='https://raw.githubusercontent.com/whattheserver/zimbra-automated-installation/master/ZimbraEasyInstall.sh'; bash <(curl -s ${link} || wget -qO - ${link}) zimbra.io --ip 192.168.211.40 --password Zimbra2017
##
## To update options just add new argbash options and rerun `argbash -o ZimbraEasyInstall.sh ZimbraEasyInstall.sh` to update the script in place with new arguments.

# Created by argbash-init v2.10.0
# ARG_POSITIONAL_SINGLE([domain],[Domain to install Zimbra for],[])
# ARG_OPTIONAL_SINGLE([ip],[i],[Specify the public IPv4 address])
# ARG_OPTIONAL_SINGLE([password],[p],[Admin password to use])
# ARG_OPTIONAL_SINGLE([resolver],[r],[DNS Resolver to setup (optional)],[dnsmasq])
# ARG_OPTIONAL_SINGLE([edition],[e],[Zimbra edition to install 'network' or 'ose' Open Source Edition (optional)],[ose])
# ARG_OPTIONAL_SINGLE([timezone],[t],[Timezone to set the server to user (optional)],[UTC])
# ARG_OPTIONAL_SINGLE([keystrokes],[],[Custom Keystrokes file to use for Zimbra Installer (optional)])
# ARG_OPTIONAL_SINGLE([zimbrascript],[],[Custom installZimbraScript file to use for Zimbra Installer (optional)])
# ARG_OPTIONAL_BOOLEAN([upgrade],[u],[Upgrade Zimbra (and implicit default: off)])
# ARG_OPTIONAL_BOOLEAN([zextras],[z],[Install Zextras (and implicit default: off)])
# ARG_OPTIONAL_BOOLEAN([certbot-zimbra],[],[Install certbot-zimbra (and implicit default: off)])
# ARG_OPTIONAL_BOOLEAN([interactive],[],[Interactive mode walk through just the installations settings part interactively (and implicit default: off)])
# ARG_OPTIONAL_BOOLEAN([csf],[],[Install CSF Firewall (and implicit default: off)])
# ARG_OPTIONAL_BOOLEAN([debug],[],[Run Installer with bash debugging enabled (and implicit default: off)])
# ARG_DEFAULTS_POS([])
# ARG_HELP([This Script installs and configures latest Zimbra with the domain and optionally provided ip,password,resolvers that are provided])
# ARG_VERSION([echo $0 v0.2])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='ipretuzhv'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_domain=
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_ip=
_arg_password=
_arg_resolver="dnsmasq"
_arg_edition="ose"
_arg_timezone="UTC"
_arg_keystrokes=
_arg_zimbrascript=
_arg_upgrade="off"
_arg_zextras="off"
_arg_certbot_zimbra="off"
_arg_interactive="off"
_arg_csf="off"
_arg_debug="off"


print_help()
{
	printf '%s\n' "This Script installs and configures latest Zimbra with the domain and optionally provided ip,password,resolvers that are provided"
	printf 'Usage: %s [-i|--ip <arg>] [-p|--password <arg>] [-r|--resolver <arg>] [-e|--edition <arg>] [-t|--timezone <arg>] [--keystrokes <arg>] [--zimbrascript <arg>] [-u|--(no-)upgrade] [-z|--(no-)zextras] [--(no-)certbot-zimbra] [--(no-)interactive] [--(no-)csf] [--(no-)debug] [-h|--help] [-v|--version] <domain>\n' "$0"
	printf '\t%s\n' "<domain>: Domain to install Zimbra for"
	printf '\t%s\n' "-i, --ip: Specify the public IPv4 address (no default)"
	printf '\t%s\n' "-p, --password: Admin password to use (no default)"
	printf '\t%s\n' "-r, --resolver: DNS Resolver to setup (optional) (default: 'dnsmasq')"
	printf '\t%s\n' "-e, --edition: Zimbra edition to install 'network' or 'ose' Open Source Edition (optional) (default: 'ose')"
	printf '\t%s\n' "-t, --timezone: Timezone to set the server to user (optional) (default: 'UTC')"
	printf '\t%s\n' "--keystrokes: Custom Keystrokes file to use for Zimbra Installer (optional) (no default)"
	printf '\t%s\n' "--zimbrascript: Custom installZimbraScript file to use for Zimbra Installer (optional) (no default)"
	printf '\t%s\n' "-u, --upgrade, --no-upgrade: Upgrade Zimbra (and implicit default: off) (off by default)"
	printf '\t%s\n' "-z, --zextras, --no-zextras: Install Zextras (and implicit default: off) (off by default)"
	printf '\t%s\n' "--certbot-zimbra, --no-certbot-zimbra: Install certbot-zimbra (and implicit default: off) (off by default)"
	printf '\t%s\n' "--interactive, --no-interactive: Interactive mode walk through just the installations settings part interactively (and implicit default: off) (off by default)"
	printf '\t%s\n' "--csf, --no-csf: Install CSF Firewall (and implicit default: off) (off by default)"
	printf '\t%s\n' "--debug, --no-debug: Run Installer with bash debugging enabled (and implicit default: off) (off by default)"
	printf '\t%s\n' "-h, --help: Prints help"
	printf '\t%s\n' "-v, --version: Prints version"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-i|--ip)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_ip="$2"
				shift
				;;
			--ip=*)
				_arg_ip="${_key##--ip=}"
				;;
			-i*)
				_arg_ip="${_key##-i}"
				;;
			-p|--password)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_password="$2"
				shift
				;;
			--password=*)
				_arg_password="${_key##--password=}"
				;;
			-p*)
				_arg_password="${_key##-p}"
				;;
			-r|--resolver)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_resolver="$2"
				shift
				;;
			--resolver=*)
				_arg_resolver="${_key##--resolver=}"
				;;
			-r*)
				_arg_resolver="${_key##-r}"
				;;
			-e|--edition)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_edition="$2"
				shift
				;;
			--edition=*)
				_arg_edition="${_key##--edition=}"
				;;
			-e*)
				_arg_edition="${_key##-e}"
				;;
			-t|--timezone)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_timezone="$2"
				shift
				;;
			--timezone=*)
				_arg_timezone="${_key##--timezone=}"
				;;
			-t*)
				_arg_timezone="${_key##-t}"
				;;
			--keystrokes)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_keystrokes="$2"
				shift
				;;
			--keystrokes=*)
				_arg_keystrokes="${_key##--keystrokes=}"
				;;
			--zimbrascript)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_zimbrascript="$2"
				shift
				;;
			--zimbrascript=*)
				_arg_zimbrascript="${_key##--zimbrascript=}"
				;;
			-u|--no-upgrade|--upgrade)
				_arg_upgrade="on"
				test "${1:0:5}" = "--no-" && _arg_upgrade="off"
				;;
			-u*)
				_arg_upgrade="on"
				_next="${_key##-u}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-u" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-z|--no-zextras|--zextras)
				_arg_zextras="on"
				test "${1:0:5}" = "--no-" && _arg_zextras="off"
				;;
			-z*)
				_arg_zextras="on"
				_next="${_key##-z}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-z" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			--no-certbot-zimbra|--certbot-zimbra)
				_arg_certbot_zimbra="on"
				test "${1:0:5}" = "--no-" && _arg_certbot_zimbra="off"
				;;
			--no-interactive|--interactive)
				_arg_interactive="on"
				test "${1:0:5}" = "--no-" && _arg_interactive="off"
				;;
			--no-csf|--csf)
				_arg_csf="on"
				test "${1:0:5}" = "--no-" && _arg_csf="off"
				;;
			--no-debug|--debug)
				_arg_debug="on"
				test "${1:0:5}" = "--no-" && _arg_debug="off"
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			-v|--version)
				echo $0 v0.2
				exit 0
				;;
			-v*)
				echo $0 v0.2
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'domain'"
	test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 1 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 1 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_domain "

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


# vvv  PLACE YOUR CODE HERE  vvv

if [ "${_arg_debug}" == 'on' ] || [ "${DEBUG}" == 'true' ] || [ "${DEBUG}" == 1 ]; then
      export PS4='+ ${BASH_SOURCE##*/}:${LINENO} '
  set -x
fi


##################
## Preparing all the variables like IP, Hostname, etc, all of them from the container
RANDOMHAM=$(date +%s|sha256sum|base64|head -c 10)
RANDOMSPAM=$(date +%s|sha256sum|base64|head -c 10)
RANDOMVIRUS=$(date +%s|sha256sum|base64|head -c 10)
HOSTNAME=$(hostname --fqdn)

# Bash ternary's for below are done via parameter expansion used to define main variables with defaults: https://stackoverflow.com/a/12691027/1621381
# Timezone if not provided is determined automagically...
TIMEZONE="${_arg_timezone:-$(date +%Z)}"
# IP if not provided is determined automagically...
IP="${_arg_ip:-$(wget -qO- -t1 -T2 ipv4.icanhazip.com)}"
DOMAIN="$_arg_domain"
# Password if not provided is determined automagically...
PASSWORD="${_arg_password:-$(openssl rand -base64 12)}"

# keystrokes with fallback
keystrokes="${_arg_keystrokes:-'/root/installZimbra-keystrokes'}"
# zimbrascript with fallback
zimbrascript="${_arg_zimbrascript:-'/root/installZimbraScript'}"


# Setup Downloads page based on selection
if [[ "$_arg_edition" = "network" ]] ; then
	# Network Edition
	zimbra_downloads_page='https://www.zimbra.com/downloads/zimbra-collaboration/' 
	zimbra_edition='Network'
elif [[ "$_arg_edition" = "ose" ]] ; then
	# OSE Open Source Edition
	zimbra_downloads_page='https://www.zimbra.org/download/zimbra-collaboration'
	zimbra_edition='OSE'
fi

# Change if switching repos:
repo_raw_url_base='https://raw.githubusercontent.com/whattheserver/zimbra-automated-installation/master'


SUPPORTED_OS_ARRAY=("Red Hat Enterprise Linux 6" "CentOS 6" "Oracle Linux 6" "Red Hat Enterprise Linux 7" "CentOS 7" "Oracle Linux 7" "Red Hat Enterprise Linux 8" "CentOS 8" "Oracle Linux 8" "Ubuntu 14.04 LTS" "Ubuntu 16.04 LTS" "Ubuntu 18.04 LTS")
SUPPORTED_OS=$(printf "%s, " "${SUPPORTED_OS_ARRAY[@]}")

Check_OS(){
if [[ ! -f /etc/os-release ]] ; then
  echo -e "Unable to detect the operating system...\n"
  exit
fi
}

Check_Server_OS(){
# Reference: https://unix.stackexchange.com/questions/116539/how-to-detect-the-desktop-environment-in-a-bash-script
if [ -z "$XDG_CURRENT_DESKTOP" ]; then
    echo -e "Desktop OS not detected. Proceeding\n"
else
    echo "$XDG_CURRENT_DESKTOP defined appears to be a desktop OS. Bailing as Zimbra is incompatible."
    echo -e "\nZimbra is supported on server OS types only. Such as ${SUPPORTED_OS}.\nSee : https://www.zimbra.org/download/zimbra-collaboration"
    exit
fi
}||true

Check_Arch(){
if ! uname -m | grep -q 64 ; then
  echo -e "x64 system is required...\n"
  exit
fi
}

Detect_Distro(){
if grep -q -E "CentOS Linux 6|CentOS Linux 7|CentOS Linux 8" /etc/os-release ; then
  Server_OS="CentOS"
elif grep -q "AlmaLinux-8" /etc/os-release ; then
  Server_OS="AlmaLinux"
elif grep -q -E "Red Hat Enterprise Linux 6|Red Hat Enterprise Linux 7|Red Hat Enterprise Linux 8|Oracle Linux 6|Oracle Linux 7|Oracle Linux 8" /etc/os-release ; then
  Server_OS="RHEL"
elif grep -q -E "Ubuntu 14.04|Ubuntu 16.04|Ubuntu 18.04" /etc/os-release ; then
  Server_OS="Ubuntu"
elif grep -q -E "Rocky Linux" /etc/os-release ; then
  Server_OS="RockyLinux"
else
  echo -e "Unable to detect your system..."
  echo -e "\nZimbra is only supported on ${SUPPORTED_OS}.\nSee : https://www.zimbra.org/download/zimbra-collaboration"
  exit
fi

if [[ $Server_OS = "RHEL" ]] || [[ "$Server_OS" = "AlmaLinux" ]] || [[ "$Server_OS" = "RockyLinux" ]] ; then
  Server_OS="CentOS"
  #CloudLinux gives version id like 7.8 , 7.9 , so cut it to show first number only
  #treat CL , Rocky and Alma as CentOS
fi

Server_OS_Version=$(grep VERSION_ID /etc/os-release | awk -F[=,] '{print $2}' | tr -d \" | head -c2 | tr -d . )
#to make 20.04 display as 20

}


Check_Conflicting_Services() {
services_to_disable=$("postfix" "iptables" "httpd" "exim" "named" "apache2" "sendmail" "mysqld" "mariadb" "systemd-resolved")

for service in "${services_to_disable[@]}"
do
	if systemctl is-active --quiet "${service}"; then
		systemctl disable "${service}"
		systemctl stop "${service}"
		systemctl mask "${service}"
		echo -e "\n${service} process detected, disabling...\n"
	fi
done
}

Pre_Install_Required_Components() {

if [[ "$Server_OS" = "CentOS" ]] ; then
  yum update -y
  if [[ "$Server_OS_Version" = "7" ]] ; then
    yum install -y wget strace perl net-tools nc curl which bc telnet htop openssl-devel yum-utils zip unzip bind-utils
  elif [[ "$Server_OS_Version" = "8" ]] ; then
    dnf install -y libnsl zip wget strace net-tools curl which nc bc telnet htop tar zip unzip bind-utils
  fi
else
  apt update -y
  DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

  DEBIAN_FRONTEND=noninteracitve apt install -y dnsutils net-tools htop telnet libcurl4-gnutls-dev libgnutls28-dev libgcrypt20-dev libattr1 libattr1-dev liblzma-dev libgpgme-dev libmariadbclient-dev libcurl4-gnutls-dev libssl-dev nghttp2 libnghttp2-dev idn2 libidn2-dev libidn2-0-dev librtmp-dev libpsl-dev nettle-dev libgnutls28-dev libldap2-dev libgssapi-krb5-2 libk5crypto3 libkrb5-dev libcomerr2 libldap2-dev virtualenv git socat vim unzip zip

  DEBIAN_FRONTEND=noninteractive apt install -y locales

  locale-gen "en_US.UTF-8"
  update-locale LC_ALL="en_US.UTF-8"
fi


}

Install_LetsEncrypt(){
	echo 'Installing certbot for OS'
	if [[ "$Server_OS" = "CentOS" ]] ; then
		if [[ "$Server_OS_Version" = "7" ]] ; then
			yum install -y certbot
		elif [[ "$Server_OS_Version" = "8" ]] ; then
			dnf install -y certbot
		fi
	else
	DEBIAN_FRONTEND=noninteractive apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

	# Certbot requirements
	DEBIAN_FRONTEND=noninteractive apt install software-properties-common -y
	DEBIAN_FRONTEND=noninteractive add-apt-repository universe -y
	DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:certbot/certbot -y
	DEBIAN_FRONTEND=noninteractive apt update -y
	DEBIAN_FRONTEND=noninteractive apt install certbot -y

	fi
}

INSTALL_CERTBOT_ZIMBRA(){
	echo 'Installling certbot-zimbra to /usr/local/bin/certbot'
	wget -O /usr/local/bin/certbot_zimbra.sh https://github.com/YetOpen/certbot-zimbra/raw/master/certbot_zimbra.sh;
	chmod +x /usr/local/bin/certbot_zimbra.sh;
	echo 'Installling crontab file for automated renewals to /etc/cron.d/zimbracrontab'
	wget -O /etc/cron.d/zimbracrontab https://github.com/whattheserver/certbot-zimbra/raw/masterzimbracrontab;
	chmod +x /etc/cron.d/zimbracrontab

	echo 'Disabling automatically created Certbot cron schedules and systemd timers from renewing certificates.'
	sed -i '/certbot -q renew/s/^/#/g' /etc/cron.d/certbot
	systemctl stop certbot.timer && systemctl disable certbot.timer
	echo 'Installation complete..'
	echo 'Starting certbot-auto bootstrap:'
	certbot-auto
	echo 'Running installed certbot_zimbra initialization script. See details here: https://github.com/YetOpen/certbot-zimbra#first-run and walk through first run as advised.'
	/usr/local/bin/certbot_zimbra.sh -n -c
}

DISABLE_SYSTEMD_RESOLVER(){
	systemctl disable systemd-resolved.service;
	sed -i 's|#DNSStubListener=yes|DNSStubListener=no|g' /etc/systemd/resolved.conf;
	systemctl stop systemd-resolved;
	rm /etc/resolv.conf;
	echo 'nameserver 1.1.1.1
	nameserver 8.8.8.8' >> /etc/resolv.conf
	ping -c3 google.com
}

INSTALL_BIND(){
echo "Installing Bind DNS Server"
if [[ "$Server_OS" = "CentOS" ]] ; then
	if [[ "$Server_OS_Version" = "7" ]] ; then
		yum install -y bind bind-utils
	elif [[ "$Server_OS_Version" = "8" ]] ; then
		dnf install -y bind bind-utils
	fi
	mv /etc/named.conf /etc/named.conf.original
    cat >> /etc/named.conf <<-EOL
	options {
			listen-on port 53 { 127.0.0.1; $IP; };
			directory       "/var/named";
			dump-file       "/var/named/data/cache_dump.db";
			statistics-file "/var/named/data/named_stats.txt";
			memstatistics-file "/var/named/data/named_mem_stats.txt";
			allow-query     { localhost; $IP; };
			recursion yes;
			dnssec-enable yes;
			dnssec-validation yes;
			bindkeys-file "/etc/named.iscdlv.key";
			managed-keys-directory "/var/named/dynamic";
			pid-file "/run/named/named.pid";
			session-keyfile "/run/named/session.key";
			allow-transfer { none; }; # disable zone transfers by default

			forwarders {
				8.8.8.8;
				8.8.4.4;
			};
			auth-nxdomain no; # conform to RFC1035
	};
	logging {
			channel default_debug {
					file "data/named.run";
					severity dynamic;
			};
	};
	zone "." IN {
			type hint;
			file "named.ca";
	};
	zone "${DOMAIN}" IN {
			type master;
			file "${DOMAIN}.zone";
	};
	include "/etc/named.rfc1912.zones";
	include "/etc/named.root.key";
	EOL

	named_zone="/var/named/${DOMAIN}.zone"
	SERIAL=$(date +%Y%m%d2)
	cat >> "${named_zone}" <<-EOL
	\$TTL  604800
	@      IN      SOA    ns1.${DOMAIN}. root.localhost. (
									${SERIAL}        ; Serial
							604800        ; Refresh
							86400        ; Retry
							2419200        ; Expire
							604800 )      ; Negative Cache TTL
		;
		@     IN      NS      ns1.${DOMAIN}.
		@     IN      A      $IP
		@     IN      MX     10     $HOSTNAME.${DOMAIN}.
		$HOSTNAME     IN      A      $IP
		ns1     IN      A      $IP
		mail     IN      A      $IP
		pop3     IN      A      $IP
		imap     IN      A      $IP
		imap4     IN      A      $IP
		smtp     IN      A      $IP
	EOL
	systemctl enable named && systemctl start named
fi
}

INSTALL_DNSMASQ(){
echo "Installing dnsmasq DNS Server"
if [[ "$Server_OS" = "CentOS" ]] ; then
	if [[ "$Server_OS_Version" = "7" ]] ; then
		yum install -y dnsmasq
	elif [[ "$Server_OS_Version" = "8" ]] ; then
		dnf install -y dnsmasq
	fi
else
	DEBIAN_FRONTEND=noninteractive apt-get install -y dnsmasq
	echo "Configuring DNS Server"
    mv /etc/dnsmasq.conf /etc/dnsmasq.conf.original
	# Reference for indented heredocs: https://unix.stackexchange.com/a/11426/440352
	cat >> /etc/dnsmasq.conf <<-EOL
	server=8.8.8.8
	listen-address=127.0.0.1
	domain=${DOMAIN}
	mx-host=${DOMAIN},$HOSTNAME.${DOMAIN},0
	address=/$HOSTNAME.${DOMAIN}/${IP}
	EOL
    systemctl enable dnsmasq && systemctl start dnsmasq
fi
}

Generate_Installer_Script_INPUT(){
	local version=$1

	echo "Downloading Matching Zimbra ${version} installZimbraScript file to /root/installZimbraScript"
	if wget -O /root/installZimbraScript "${repo_raw_url_base}/installZimbraScript/installZimbraScript-${version}"; then

		# Fix placeholders
		sed -i -e "s|RANDOMHAM_PLACEHOLDER|${RANDOMHAM}|g" /root/installZimbraScript
		sed -i -e "s|RANDOMSPAM_PLACEHOLDER|${RANDOMSPAM}|g" /root/installZimbraScript
		sed -i -e "s|RANDOMVIRUS_PLACEHOLDER|${RANDOMVIRUS}|g" /root/installZimbraScript
		sed -i -e "s|HOSTNAME_PLACEHOLDER|${HOSTNAME}|g" /root/installZimbraScript
		sed -i -e "s|TIMEZONE_PLACEHOLDER|${TIMEZONE}|g" /root/installZimbraScript
		sed -i -e "s|IP_PLACEHOLDER|${IP}|g" /root/installZimbraScript
		sed -i -e "s|DOMAIN_PLACEHOLDER|${DOMAIN}|g" /root/installZimbraScript
		sed -i -e "s|PASSWORD_PLACEHOLDER|${PASSWORD}|g" /root/installZimbraScript
		
		echo "Downloading Matching Zimbra ${version} installZimbra-keystrokes file to /root/installZimbra-keystrokes"
		wget -O /root/installZimbra-keystrokes "${repo_raw_url_base}/installZimbra-keystroke/installZimbra-keystrokes-${version}"
		
	else
		echo "Was not able to download installZimbraScript matching ${version}"
		echo "Please run installer with --interactive flag to continue with the installation manually"
		return 1
	
	fi
	
	return 0

}

INSTALL_ZIMBRA(){
	latestLTSZimbra=$(curl -s https://wiki.zimbra.com/wiki/Zimbra_Releases | grep -E "LTS Release"|grep -oE "[[:digit:]]+.[[:digit:]]+.[[:digit:]]+"| head -n1);
	zimbra_url=$(curl -s ${zimbra_downloads_page} | grep -i "${Server_OS}" | grep "${Server_OS_Version}" |grep "${latestLTSZimbra}" |grep 64bitx86 | tail -n1|grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*.tgz'|uniq);
	echo "Downloading Zimbra release ${zimbra_url}....."
	wget "${zimbra_url}" ;
	filename=$(basename "$zimbra_url");
	filefolder=${filename//.tgz/};
	REMOTE_CHECKSUM=$(curl -s "${zimbra_url}.sha256"|grep -Eo '^\w+');
	if sha256sum "${filename}"|grep -Eo '^\w+'|cmp -s <(echo "$REMOTE_CHECKSUM"); then
		echo "Hash check: for ${filename} passed...";
		echo "Extracting now...";
		tar xzf "${filename}";
		if [[ "$_arg_interactive" = "on" ]] ; then
			echo "Starting Zimbra ${zimbra_edition} Collaboration Installer in interactive mode."
			cd "${filefolder}"/ && ./install.sh
		else
			echo "Installing Zimbra ${zimbra_edition} Collaboration Software Only"
			if Generate_Installer_Script_INPUT "$latestLTSZimbra"; then
				cd "${filefolder}"/ && ./install.sh -s < "${keystrokes}";
				echo "Installing Zimbra ${zimbra_edition} Collaboration and injecting the configuration"
				/opt/zimbra/libexec/zmsetup.pl -c "${zimbrascript}"
			else
				while true; do
					read -rp "Do you wish to install Zimbra interactively instead?" yn
					case $yn in
						[Yy]* ) cd "${filefolder}"/ && ./install.sh; break;;
						[Nn]* ) exit;;
						* ) echo "Please answer yes or no.";;
					esac
				done
		fi
			fi


		echo 'Restarting Zimbra Services'
		su - zimbra -c 'zmcontrol restart'
	else
		echo FAIL;

	fi;
}



ZIMBRA_INSTALL_COMPLETE(){
	# installation of Zimbra completed
	echo "Done!"
	echo
	echo "Your new Zimbra installation details are:	"
	echo
	echo "  - Webmail Login:	https://${DOMAIN}	"
	echo "  - Admin Console:	https://${IP}:7071  "
	echo "  - Admin Username: 	admin@${DOMAIN}		"
	echo "  - Admin Password: 	${PASSWORD}			"
	echo "Processing Post Install selections....."
}


Install_CSF() {
if [[ "$Server_OS" = "CentOS" ]] ; then
	if [[ "$Server_OS_Version" = "7" ]] ; then
		yum install -y bind-utils net-tools perl-libwww-perl.noarch perl-LWP-Protocol-https.noarch perl-GDGraph ipset
	elif [[ "$Server_OS_Version" = "8" ]] ; then
		dnf install -y bind-utils net-tools perl-libwww-perl.noarch perl-LWP-Protocol-https.noarch perl-GDGraph ipset
	fi
else
  DEBIAN_FRONTEND=noninteractive apt-get install -y dnsutils libwww-perl liblwp-protocol-https-perl libgd-graph-perl net-tools ipset
fi

wget -O /usr/src/csf.tgz  https://download.configserver.com/csf.tgz
cd /usr/src && tar -xzf csf.tgz && cd csf && sh install.sh ;

# https://syslint.com/blog/tutorial/how-to-configure-zimbra-csf-the-best-zimbra-firewall-configuration/
echo 'Setup CSF to ignore false positives'
cat <<- 'EOL' >> /etc/csf/csf.pignore
exe:/opt/zimbra/common/sbin/amavisdamavisd
exe:/opt/zimbra/common/bin/freshclam
exe:/opt/zimbra/common/sbin/clamd
exe:/opt/zimbra/common/sbin/saslauthd
exe:/opt/zimbra/common/bin/httpd
exe:/opt/zimbra/common/bin/rotatelogs
exe:/opt/zimbra/common/lib/jvm/java/bin/java
exe:/opt/zimbra/common/sbin/mysqld
exe:/opt/zimbra/common/sbin/opendkim
exe:/opt/zimbra/common/libexec/slapd
exe:/opt/zimbra/common/libexec/master
EOL

echo 'Opening Zimbra ports in CSF. Reference: https://wiki.zimbra.com/wiki/Ports'
sed -i 's|^TCP_IN = .*|TCP_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995,2525,3443,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281,1025"|' /etc/csf/csf.conf
sed -i 's|^TCP_OUT =.*|TCP_OUT = "20,21,22,25,53,80,110,143,443,465,587,993,995,2525,3443,4747,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281"|' /etc/csf/csf.conf
sed -i 's|^UDP_IN =.*|UDP_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995,3443,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281"|' /etc/csf/csf.conf
sed -i 's|^UDP_OUT =.*|UDP_OUT = "20,21,22,25,53,80,110,143,443,465,587,993,995,3443,5222,5223,5269,5298,5322,7071,9071"|' /etc/csf/csf.conf
sed -i 's|^TCP6_IN =.*|TCP6_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995,2525,3443,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281"|' /etc/csf/csf.conf
sed -i 's|^TCP6_OUT =.*|TCP6_OUT = "20,21,22,25,53,80,110,143,443,465,587,993,995,2525,3443,4747,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281"|' /etc/csf/csf.conf
sed -i 's|^UDP6_IN =.*|UDP6_IN = "20,21,22,25,53,80,110,143,443,465,587,993,995,3443,5222,5223,5269,5298,5322,7071,9071,5000,5347,5280,5281"|' /etc/csf/csf.conf
sed -i 's|^UDP6_OUT =.*|UDP6_OUT = "20,21,22,25,53,80,110,143,443,465,587,993,995,3443,5222,5223,5269,5298,5322,7071,9071"|' /etc/csf/csf.conf


}

Install_Zextras() {
	echo 'Starting Zextras Installation...'
	# Reference: https://docs.zextras.com/zextras-suite-documentation/latest/install-guide.html
	wget http://download.zextras.com/zextras_suite-latest.tgz
	tar xvf zextras_suite-latest.tgz
	cd zextras_suite/ && ./install.sh all
}

SET_TIMEZONE(){
	timedatectl set-timezone "${TIMEZONE}"
}

# todo
Upgrade_Zimbra() {
	#echo 'Starting Zimbra Upgrade...'
	echo 'Not yet implemented. Check back in future version.'
}

# todo
Upgrade_Zextras() {
	#echo 'Starting Zimbra Upgrade...'
	echo 'Not yet implemented. Check back in future version.'
}


if [[ "$_arg_upgrade" = "on" ]] ; then
	Upgrade_Zimbra
	exit 0
fi

Check_OS
Check_Server_OS
Check_Arch
Detect_Distro
DISABLE_SYSTEMD_RESOLVER
Check_Conflicting_Services

if [[ "$_arg_resolver" = "dnsmasq" ]] ; then
	INSTALL_DNSMASQ
elif [[ "$_arg_resolver" = "bind" ]] ; then
	INSTALL_BIND
fi

SET_TIMEZONE
Pre_Install_Required_Components

if INSTALL_ZIMBRA ; then
	ZIMBRA_INSTALL_COMPLETE
fi


if [[ "$_arg_zextras" = "on" ]] ; then
	Install_Zextras
fi

if [[ "$_arg_csf" = "on" ]] ; then
	Install_CSF
fi

if [[ "$_arg_certbot_zimbra" = "on" ]] ; then
	if Install_LetsEncrypt ; then
		INSTALL_CERTBOT_ZIMBRA
	fi
fi



# ^^^  TERMINATE YOUR CODE BEFORE THE BOTTOM ARGBASH MARKER  ^^^

# ] <-- needed because of Argbash
