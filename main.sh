#!/bin/bash
#
# mkbase.sh by etnbrd
# This is the main script

# wget https://raw.github.com/gravitezero/mkarch/master/main.sh -O - | sh;

MKDISK=true;
MKPART=true;
MKBASE=true;

wget https://raw.github.com/gravitezero/mkarch/master/utils.sh -O - | source;

Ask "Host ?" HOST
Ask "Make disk ?" MKDISK
Ask "Make part ?" MKPART
Ask "Make base ?" MKBASE

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOST/init.sh
Error $? "$ER hosts/$HOST/init.sh doesn't exist"

wget --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOST/init.sh -O - | source;

if [[ MKDISK = true ]]; then
  wget https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh -O - | sh
fi
if [[ MKPART = true ]]; then
  wget https://raw.github.com/gravitezero/mkarch/master/mkpart.sh -O - | sh
fi
if [[ MKBASE = true ]]; then
  wget https://raw.github.com/gravitezero/mkarch/master/mkbase.sh -O - | sh
fi