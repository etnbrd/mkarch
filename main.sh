#!/bin/zsh
#
# mkbase.sh by etnbrd
# This is the main script

# The one-liner :)
# zsh <(wget https://raw.github.com/gravitezero/mkarch/master/main.sh -qO -);

#####################################################
# MAIN                                              #
#####################################################

ASK=false;
HOSTNAME=arch-srv;
MKDISK=false;
MKPART=false;
MKBASE=true;

SOURCE="https://raw.github.com/gravitezero/mkarch/master";

# TODO echo big fat fancy arch logo

source <(wget ${SOURCE}/utils.sh -qO -);

wget -q --spider ${SOURCE}/mkdisk.sh &&
wget -q --spider ${SOURCE}/mkpart.sh &&
wget -q --spider ${SOURCE}/mkbase.sh;
Error $? "$ER ressource not available" "$IF ressources available";

Ask "Host ?" HOSTNAME
AskPw "Root passwd ?" ROOT_PWD
Ask "Make disk ?" MKDISK
Ask "Make part ?" MKPART
Ask "Make base ?" MKBASE

wget -q --spider ${SOURCE}/hosts/$HOSTNAME/init.sh;
Error $? "$ER hosts/${HOSTNAME}/init.sh doesn't exist";

source <(wget ${SOURCE}/hosts/$HOSTNAME/init.sh -qO -);
Init;

if [[ $MKDISK = true ]]; then
  echo -e "\n>$IF Making disk"
  source <(wget ${SOURCE}/mkdisk.sh -qO -);
fi
if [[ $MKPART = true ]]; then
  echo -e "\n>$IF Making part"
  source <(wget ${SOURCE}/mkpart.sh -qO -);
fi
if [[ $MKBASE = true ]]; then
  echo -e "\n>$IF Making base"
  source <(wget ${SOURCE}/mkbase.sh -qO -);
fi