#!/bin/bash
#
# mkbase.sh by etnbrd
# This is the main script

# wget https://raw.github.com/gravitezero/mkarch/master/main.sh -O - | sh;
# source <(https://raw.github.com/gravitezero/mkarch/master/main.sh -O - 2> /dev/null);

#####################################################
# MAIN                                              #
#####################################################

MKDISK=true;
MKPART=true;
MKBASE=true;

# TODO echo big fat fancy arch logo

source <(wget https://raw.github.com/gravitezero/mkarch/master/utils.sh -qO -);

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh &&
quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkpart.sh &&
quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/mkbase.sh;
Error $? "$ER ressource not available" "$IF ressources available";

Ask "Host ?" HOSTNAME
Ask "Make disk ?" MKDISK
Ask "Make part ?" MKPART
Ask "Make base ?" MKBASE

quiet wget --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOSTNAME/init.sh;
Error $? "$ER hosts/${HOSTNAME}/init.sh doesn't exist";

mkdir -p tmp;
wget https://raw.github.com/gravitezero/mkarch/master/hosts/$HOSTNAME/init.sh -O - > tmp/init.sh 2> /dev/null;
chmod +x ./tmp/init.sh;

source ./tmp/init.sh;
Init;

if [[ $MKDISK = true ]]; then
  echo -e "\n>$IF Making disk"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh -O - 2> /dev/null);
fi
if [[ $MKPART = true ]]; then
  echo -e "\n>$IF Making part"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkpart.sh -O - 2> /dev/null);
fi
if [[ $MKBASE = true ]]; then
  echo -e "\n>$IF Making base"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkbase.sh -O - 2> /dev/null);
fi