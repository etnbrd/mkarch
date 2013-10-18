#!/bin/bash
#
# mkdisk.sh by etnbrd
# This script make the partitions

#####################################################
# DEFAULT                                           #
#####################################################

Init() {
  ASK=true
  DISK_DEVICE=/dev/vda

  ROOT_SIZE=5G
  HOME_SIZE=10G

  ROOT_FS=ext4
  HOME_FS=ext4 # if HOME_FS = false, don't erase home.
}

# TODO prompt a config file with the different variables, like arch-srv.sh and arch-dev.sh
# then wget it, source it, and continue

#####################################################
# UTILS                                             #
#####################################################

Rst='\033[0m'    # Text Reset

# Regular             Bold                  Underline             High Intensity        BoldHigh Intens       Background            High Intensity Backgrounds
Bla='\033[0;30m';     BBla='\033[1;30m';    UBla='\033[4;30m';    IBla='\033[0;90m';    BIBla='\033[1;90m';   On_Bla='\033[40m';    On_IBla='\033[0;100m';
Red='\033[0;31m';     BRed='\033[1;31m';    URed='\033[4;31m';    IRed='\033[0;91m';    BIRed='\033[1;91m';   On_Red='\033[41m';    On_IRed='\033[0;101m';
Gre='\033[0;32m';     BGre='\033[1;32m';    UGre='\033[4;32m';    IGre='\033[0;92m';    BIGre='\033[1;92m';   On_Gre='\033[42m';    On_IGre='\033[0;102m';
Yel='\033[0;33m';     BYel='\033[1;33m';    UYel='\033[4;33m';    IYel='\033[0;93m';    BIYel='\033[1;93m';   On_Yel='\033[43m';    On_IYel='\033[0;103m';
Blu='\033[0;34m';     BBlu='\033[1;34m';    UBlu='\033[4;34m';    IBlu='\033[0;94m';    BIBlu='\033[1;94m';   On_Blu='\033[44m';    On_IBlu='\033[0;104m';
Pur='\033[0;35m';     BPur='\033[1;35m';    UPur='\033[4;35m';    IPur='\033[0;95m';    BIPur='\033[1;95m';   On_Pur='\033[45m';    On_IPur='\033[0;105m';
Cya='\033[0;36m';     BCya='\033[1;36m';    UCya='\033[4;36m';    ICya='\033[0;96m';    BICya='\033[1;96m';   On_Cya='\033[46m';    On_ICya='\033[0;106m';
Whi='\033[0;37m';     BWhi='\033[1;37m';    UWhi='\033[4;37m';    IWhi='\033[0;97m';    BIWhi='\033[1;97m';   On_Whi='\033[47m';    On_IWhi='\033[0;107m';

PR="${BIBlu}>${BICya}>${BIWhi}";
IF="${BYel}>${BIYel}>${BIWhi}";
ER="${Red}>${BIRed}>${IRed}";

Ask() {
  while true
  do
    if [[ -z ${!2} ]]; then
      echo -ne "$PR $1 ${Rst}";
    elif [[ $ASK = true ]]; then
      echo -ne "$PR $1 ${Rst}[${IBla}${!2}${Rst}] ";
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

Error() {
  if [[ $1 != 0 ]]; then
    echo -e $2;
    exit;
  else
    echo -e $3;
  fi
}

alias quiet='> /dev/null 2>&1';

quiet() {
  "$@" >/dev/null 2>&1
}

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
Error $? "$ER Error${Rst}: couldn't create root filesystem" "$IF root filesystem created"

if [[ $HOME_FS != false ]]; then
  quiet mkfs.$HOME_FS ${DISK_DEVICE}2 -L home;
  Error $? "$ER Error${Rst}: couldn't create home filesystem" "$IF home filesystem created"
fi