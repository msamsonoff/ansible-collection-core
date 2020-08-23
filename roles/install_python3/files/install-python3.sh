#! /bin/sh

set -x
set -e

check_python () {
	/usr/bin/env python3 -c 'import sys ; sys.exit(0)'
}

readonly uname="$(uname)"
case "${uname}"
in

	Darwin)
		# Python is installed by default.
		;;

	Linux)
		# The tests for 'centos-release' or 'fedora-release' must come
		# before the test for 'redhat-release'.
		if [ -e /etc/os-release ]; then
			. /etc/os-release
			readonly linux_id="${ID}"
		elif lsb_release > /dev/null 2>&1; then
			readonly linux_id="$(lsb_release -is)"
		elif [ -e /etc/centos-release ]; then
			readonly linux_id='centos'
		elif [ -e /etc/fedora-release ]; then
			readonly linux_id='fedora'
		elif [ -e /etc/redhat-release ]; then
			readonly linux_id='rhel'
		else
			>&2 echo 'unable to determine Linux distribution'
			exit 1
		fi
		case "$(echo -n ${linux_id} | tr A-Z a-z)"
		in
			debian|raspbian|ubuntu)
				apt-get update
				apt-get install -y --no-install-recommends python python-apt
				;;
			centos|fedora|rhel)
				if dnf --version > /dev/null 2>&1; then
					dnf install -y python python3-dnf python3-libselinux
				else
					yum install -y python libselinux-python3
				fi
				;;
			*)
				>&2 echo "unsupported Linux distribution: ${linux_id}"
				exit 1
				;;
		esac
		;;

	OpenBSD)
		check_python || pkg_add -I "${PYTHON3_OPENBSD_PKG_NAME}"
		;;

	*)
		>&2 echo "unsupported operating system: ${uname}"
		exit 1
		;;

esac
