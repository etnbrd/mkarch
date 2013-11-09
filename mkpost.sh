#!/bin/sh
#
# mkpost.sh by etnbrd
# This script install the salted system

# The one-liner :)
# zsh <(curl -s https://raw.github.com/gravitezero/mkarch/master/mkpost.sh);
# sh <(curl -s https://raw.github.com/gravitezero/mkarch/master/mkpost.sh);

#####################################################
# COMMANDS                                          #
#####################################################

SOURCE="https://raw.github.com/gravitezero/mkarch/master";
HOSTNAME=`cat /etc/hostname`;

curl -sL -o master.tar.gz https://github.com/gravitezero/mkarch/archive/master.tar.gz;
tar xzf master.tar.gz;

source mkarch-master/utils.sh
# curl -s ${SOURCE}/utils.sh | source /dev/stdin;
# source <(curl -s ${SOURCE}/utils.sh);

# TODO put a structure of all the variables that need to be send to pillar in the init.sh
AskPw "User password ? " USER_PW
AskPw "MariaDb root password ? " MDB_ROOT_PW
AskPw "MariaDb thinkup password ? " MDB_USER_PW


# TODO get the complete pacman.conf
# curl -s ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo >> /etc/pacman.conf
# wget ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo -qO - >> /mnt/etc/pacman.conf

# pacman -Sy --noconfirm yaourt &&
# yaourt -Sy --noconfirm salt
# Error $? "$ER Failed to install yaourt and salt" "$IF yaourt and salt installed"

# TODO states should be stored in home
# TODO find another way to get states
rm -rf /srv/salt;
mv mkarch-master/hosts/$HOSTNAME/salt /srv;
rm -rf master.tar.gz mkarch-master;

echo $USER_PW
echo $MDB_ROOT_PW
echo $MDB_USER_PW

salt-call --local state.highstate pillar='{user_pw: "${USER_PW}", mariadb_root_pw: "${MDB_ROOT_PW}", mariadb_user_pw: "${MDB_USER_PW}"}'