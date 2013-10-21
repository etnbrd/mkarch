#!/bin/zsh
#
# mkdisk.sh by etnbrd
# This script prepare the disks

#####################################################
# PROMPT                                            #
#####################################################

# Init

while true
do

  if [[ $ASK = true ]]; then
    echo -ne "${IBla}";
    lsblk;
    echo -e "${Rst}";
  fi

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

  if [[ $ASK = true ]]; then
    echo -ne "${IBla}";
    sgdisk -p $DISK_DEVICE;
    echo -e "${Rst}";
  fi

  Ask "Root Partition Size ?" ROOT_SIZE;
  Ask "Home Partition Size ?" HOME_SIZE;

  echo -e "${BIWhi}"
  echo -e "$IF $DISK_DEVICE"
  echo -e "${BIWhi}   root \t${BIYel}$ROOT_SIZE"
  echo -e "${BIWhi}   home \t${BIYel}$HOME_SIZE"
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

quiet umount /mnt/{home,};

quiet sgdisk -o $DISK_DEVICE;                                  # Clear partition
Error $? "$ER Couldn't Clear Partition" "$IF Disk erased successfully";

quiet sgdisk -n 1:0:1007K -t 1:0xEF02 -c 1:'boot' $DISK_DEVICE;
Error $? "$ER Couldn't create boot partition" "$IF Boot partition created"

quiet sgdisk -n 2:1007K:+$ROOT_SIZE -c 2:'root' $DISK_DEVICE;      # Create root partition
Error $? "$ER Couldn't create root partition" "$IF Root partition created"

quiet sgdisk -N 3 -c 3:'home' $DISK_DEVICE;                    # Create home partition$?
Error $? "$ER Couldn't create home partition" "$IF Home partition created"