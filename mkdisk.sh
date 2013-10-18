#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script prepare the disks

#####################################################
# DEFAULT                                           #
#####################################################

Init() {
  ASK=false
  DISK_DEVICE=/dev/vda
  ROOT_SIZE=5G
  HOME_SIZE=10G
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
    elif [[ $ASK ]]; then
      echo -n "$1 [${!2}] ";
    else
      break;
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
  echo -e "   root \tROOT_SIZE"
  echo -e "   home \tHOME_SIZE"
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

sgdisk -o $DISK_DEVICE > /dev/null 2>&1;                                  # Clear partition
sgdisk -n 1:0:+$ROOT_SIZE -c 1:'root' $DISK_DEVICE > /dev/null 2>&1;      # Create root partition
sgdisk -N 2 -c 2:'home' $DISK_DEVICE > /dev/null 2>&1;                    # Create home partition