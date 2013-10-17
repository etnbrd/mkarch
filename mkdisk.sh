#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script prepare the disks

DISK_DEVICE=/dev/vda
ROOT_SIZE=5G
HOME_SIZE=10G

# TODO prompt a config file with the different variables, like arch-srv.sh and arch-dev.sh

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
    echo ${!2}
    if [[ -n ${!2} ]]; then
      break;
    fi
  done
}

while true
do
  echo lsblk
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
  echo parted -s $DISK_DEVICE print;

  Ask "Root Partition Size ?" ROOT_SIZE;
  Ask "Home Partition Size ?" HOME_SIZE;

  echo ""
  echo "Summary"
  echo "-------"
  echo ""
  echo -e "Install on : \t$DISK_DEVICE"
  echo -e "root : \t\t$ROOT_SIZE"
  echo -e "home : \t\t$HOME_SIZE"
  echo ""

  while true; do
      echo "Good ? [y/n]"
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
      DISK_DEVICE=;
      ROOT_SIZE=;
      HOME_SIZE=;
      echo "";
      continue;
  fi
done



