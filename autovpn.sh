#!/bin/bash
#
# uboreas 2014/03
# https://github.com/uboreas/osxvpn
#

app="/opt/devel/local/app/autovpn.app"
def="/opt/devel/etc/vpn.default"
sta="/opt/devel/etc/vpn.status"

aid=`ps -ef | grep "${app}" | grep -v grep | awk {'print $2'}`

function usage() {
   echo "Usage: ${0} [start|stop] [interface]"
   echo
}

function usage_first() {
   usage
   echo "You must specify interface for the first time"
   echo
   exit
}

function vstop() {
   if [ "${aid}" != "" ]; then
      for i in ${aid}; do
         kill -9 "${i}"
      done
   fi
   echo "stop" > "${sta}"
   svc="${1}"
   if [ "${svc}" == "" ]; then
      svc=`cat "${def}"`
   fi
   if [ "${svc}" != "" ]; then
      /usr/bin/env osascript <<-EOF
      tell application "System Events"
         tell current location of network preferences
            set _vpn to service "${svc}"
            if exists _vpn then disconnect _vpn
         end tell
      end tell
      return
EOF
   fi
}

function vstart() {
   if [ "${aid}" != "" ]; then
      cst=`cat "${sta}"`
      if [ "${cst}" == "stop" ]; then
         vstop
      else
         echo "Already running with pid ${aid}"
         echo
         exit
      fi
   fi
   if [ "${1}" == "" ]; then
      if [ ! -e "${def}" ]; then
         usage_first
      fi
      svc=`cat "${def}"`
      if [ "${svc}" == "" ]; then
         usage_first
      fi
   else
      echo "${1}" > "${def}"
   fi
   echo "start" > "${sta}"
   open "${app}"
}

if [ "${1}" == "" ]; then
   usage
   exit
elif [ "${1}" == "start" ]; then
   vstart "${2}"
elif [ "${1}" == "stop" ]; then
   vstop "${2}"
else
   vstart "${1}"
fi

