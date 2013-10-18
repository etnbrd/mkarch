#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script prepare the disks

#####################################################
# DEFAULT                                           #
#####################################################

Init() {
  ASK=true
  DISK_DEVICE=/dev/vda
  ROOT_SIZE=5G
  HOME_SIZE=10G
}

# TODO prompt a config file with the different variables, like arch-srv.sh and arch-dev.sh

#####################################################
# UTILS                                             #
#####################################################

TC='\e['
 
CLR_LINE_START="${TC}1K"
CLR_LINE_END="${TC}K"
CLR_LINE="${TC}2K"
 
Bold="${TC}1m" # Bold text only, keep colors
Undr="${TC}4m" # Underline text only, keep colors
Inv="${TC}7m" # Inverse: swap background and foreground colors
Reg="${TC}22;24m" # Regular text only, keep colors
RegF="${TC}39m" # Regular foreground coloring
RegB="${TC}49m" # Regular background coloring
Rst="${TC}0m" # Reset all coloring and style
 
# Basic                     High Intensity              Background                    High Intensity Background
Black="${TC}30m";           IBlack="${TC}90m";          OnBlack="${TC}40m";           OnIBlack="${TC}100m";
Red="${TC}31m";             IRed="${TC}91m";            OnRed="${TC}41m";             OnIRed="${TC}101m";
Green="${TC}32m";           IGreen="${TC}92m";          OnGreen="${TC}42m";           OnIGreen="${TC}102m";
Yellow="${TC}33m";          IYellow="${TC}93m";         OnYellow="${TC}43m";          OnIYellow="${TC}103m";
Blue="${TC}34m";            IBlue="${TC}94m";           OnBlue="${TC}44m";            OnIBlue="${TC}104m";
Purple="${TC}35m";          IPurple="${TC}95m";         OnPurple="${TC}45m";          OnIPurple="${TC}105m";
Cyan="${TC}36m";            ICyan="${TC}96m";           OnCyan="${TC}46m";            OnICyan="${TC}106m";
White="${TC}37m";           IWhite="${TC}97m";          OnWhite="${TC}47m";           OnIWhite="${TC}107m";

PROMPT="${Cyan}>${Purple}>${Rst}";

Ask() {
  while true
  do
    if [[ -z ${!2} ]]; then
      echo -n "$PROMPT $1 ";
    elif [[ $ASK = true ]]; then
      echo -n "$PROMPT $1 [${!2}] ";
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
  echo -e "   root \t$ROOT_SIZE"
  echo -e "   home \t$HOME_SIZE"
  echo ""

  while [[ $ASK = true ]]; do
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