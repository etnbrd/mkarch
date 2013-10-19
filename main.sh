#!/bin/zsh
#
# mkbase.sh by etnbrd
# This is the main script

# The one-liner :)
# zsh <(wget https://raw.github.com/gravitezero/mkarch/master/main.sh -qO -);

#####################################################
# MAIN                                              #
#####################################################

MKDISK=true;
MKPART=true;
MKBASE=true;

# TODO echo big fat fancy arch logo

source <(wget https://raw.github.com/gravitezero/mkarch/master/utils.sh -qO -);

wget -q --spider https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh &&
wget -q --spider https://raw.github.com/gravitezero/mkarch/master/mkpart.sh &&
wget -q --spider https://raw.github.com/gravitezero/mkarch/master/mkbase.sh;
Error $? "$ER ressource not available" "$IF ressources available";

Ask "Host ?" HOSTNAME
Ask "Make disk ?" MKDISK
Ask "Make part ?" MKPART
Ask "Make base ?" MKBASE

wget -q --spider https://raw.github.com/gravitezero/mkarch/master/hosts/$HOSTNAME/init.sh;
Error $? "$ER hosts/${HOSTNAME}/init.sh doesn't exist";

source <(wget https://raw.github.com/gravitezero/mkarch/master/hosts/$HOSTNAME/init.sh -qO -);
Init;

if [[ $MKDISK = true ]]; then
  echo -e "\n>$IF Making disk"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkdisk.sh -qO -);
fi
if [[ $MKPART = true ]]; then
  echo -e "\n>$IF Making part"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkpart.sh -qO -);
fi
if [[ $MKBASE = true ]]; then
  echo -e "\n>$IF Making base"
  source <(wget https://raw.github.com/gravitezero/mkarch/master/mkbase.sh -qO -);
fi