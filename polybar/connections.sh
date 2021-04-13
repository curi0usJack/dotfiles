#!/usr/bin/env bash

command -v nmcli >/dev/null 2>&1 || { echo >&2 "[nmcli] is required, but not installed.  Aborting."; exit 1; }

# can be wifi, vpn, etc.
KIND=$1
KIND=${KIND:-wifi}

cons=$(nmcli con | grep -i " $KIND " | grep -v -E '\-\-' | awk '{print $1}')
len=0
for con in $cons; do
  len=$((len + 1))
  echo $con
done

if [ "$len" -eq "0" ]; then
  kind=$(echo $KIND | awk '{ print toupper($0) }')
  echo "$kind disconnected"
fi
