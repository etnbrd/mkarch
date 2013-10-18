#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script make the partitions

#####################################################
# PROMPT                                            #
#####################################################

Init

while true
do

  Ask "Root fs ?" ROOT_FS;
  Ask "Home fs ?" HOME_FS;

  echo -e "${BIWhi}"
  echo -e "$IF $DISK_DEVICE"
  echo -e "${BIWhi}   root \t$ROOT_SIZE \t${BIYel}$ROOT_FS"
  echo -e "${BIWhi}   home \t$HOME_SIZE \t${BIYel}$HOME_FS"
  echo -e "${Rst}"

  yn=yes;
  while [[ $ASK = true ]]; do
      echo -ne "$PR Continue ? ${Rst}[${IBla}yes/no${Rst}] "
      read yn
      case $yn in
          [Yy]* ) yn=yes; break;;
          [Nn]* ) yn=no; break;;
          * ) echo "Please answer yes or no.";;
      esac
  done

  if [ $yn = yes ]
    then break;
  elif [ $yn = no ]
    then 
      Init
      echo;
      continue;
  fi
done

#####################################################
# COMMANDS                                          #
#####################################################

quiet mkfs.$ROOT_FS ${DISK_DEVICE}1 -L root;
Error $? "$ER couldn't create root filesystem" "$IF root filesystem created"

if [[ $HOME_FS != false ]]; then
  quiet mkfs.$HOME_FS ${DISK_DEVICE}2 -L home;
  Error $? "$ER couldn't create home filesystem" "$IF home filesystem created"
fi