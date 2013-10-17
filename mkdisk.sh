#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script prepare the disks

#####################################################
# DEFAULT                                           #
#####################################################

Init() {
  DISK_DEVICE=/dev/vda
  ROOT_SIZE=5
  HOME_SIZE=10
}

# TODO prompt a config file with the different variables, like arch-srv.sh and arch-dev.sh

#####################################################
# UTILS                                             #
#####################################################

Ask() {
  while true
  do
    if [[ -z ${!2} ]]; then
      echo -n "$1 ";
    else 
      echo -n "$1 [${!2}] ";
    fi
    read tmp;
    if [[ -n $tmp ]]; then
      eval "$2=$tmp";
    fi
    if [[ -n ${!2} ]]; then
      break;
    fi
  done
}

#####################################################
# PROMPT                                            #
#####################################################

Init

while true
do
  lsblk
  echo "";
  Ask "Disk device ?" DISK_DEVICE;

  if [[ -n $DISK_DEVICE && -w $DISK_DEVICE ]]
    then break;
  else
    echo "$DISK_DEVICE doesn't exist, or you don't have the permissions to write."
    DISK_DEVICE=;
    continue
  fi
done

while true
do
  parted -s $DISK_DEVICE print;
  echo "";

  Ask "Root Partition Size (GB)?" ROOT_SIZE;
  Ask "Home Partition Size (GB)?" HOME_SIZE;

  echo ""
  echo "Summary"
  echo "-------"
  echo ""
  echo -e "$DISK_DEVICE"
  echo -e "   root \t${ROOT_SIZE}G"
  echo -e "   home \t${HOME_SIZE}G"
  echo ""

  while true; do
      echo "Good ? [yes/no]"
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
parted -s $DISK_DEVICE mktable gpt;
parted -s $DISK_DEVICE unit GB mkpart primary 0          $ROOT_SIZE name 1 root set 1 boot on;
parted -s $DISK_DEVICE unti GB mkpart primary $ROOT_SIZE $HOME_SIZE name 1 home;

# parted -s $DISK_DEVICE name 1 root;
# parted -s $DISK_DEVICE name 2 home;

# parted -s $DISK_DEVICE set 1 boot on;
# parted -s $DISK_DEVICE set 1 root on;
