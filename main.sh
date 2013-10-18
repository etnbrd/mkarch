#!/bin/bash
#
# mkbase.sh by etnbrd
# This is the main script

# wget https://raw.github.com/gravitezero/mkarch/master/main.sh -O - | sh;

MKDISK=true;
MKPART=true;
MKBASE=true;

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/utils.sh &&
quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh &&
quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkpart.sh &&
quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkbase.sh
Error $? "$ER ressource not available"

wuiet wget https://raw.github.com/gravitezero/mkarch/master/utils.sh -O - | source;

Ask "Host ?" HOST
Ask "Make disk ?" MKDISK
Ask "Make part ?" MKPART
Ask "Make base ?" MKBASE

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOST/init.sh
Error $? "$ER hosts/$HOST/init.sh doesn't exist"

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOST/init.sh -O - | source;

if [[ MKDISK = true ]]; then
  quiet wget https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh -O - | sh
fi
if [[ MKPART = true ]]; then
  quiet wget https://raw.github.com/gravitezero/mkarch/master/mkpart.sh -O - | sh
fi
if [[ MKBASE = true ]]; then
  quiet wget https://raw.github.com/gravitezero/mkarch/master/mkbase.sh -O - | sh
fi