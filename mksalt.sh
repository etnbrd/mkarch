#!/bin/zsh
#
# mksalt.sh by etnbrd
# This script install the salted system

#####################################################
# COMMANDS                                          #
#####################################################

# # TODO get the complete pacman.conf
# wget ${SOURCE}/hosts/$HOSTNAME/archlinuxfr.repo -qO - >> /mnt/etc/pacman.conf
# # chrootsh echo -e '[archlinuxfr]\\\\n\\\\tSigLevel = Never\\\\n\\\\tServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

# chrootsh pacman -Sy --noconfirm yaourt &&
# chrootsh yaourt -Sy --noconfirm salt
# Error $? "$ER Failed to install yaourt and salt" "$IF yaourt and salt installed"

# echo "${BIGre}>>${BIWhi} Basecamp established, starting campfire :)${Rst}"

# TODO states should be stored in home
# TODO find another way to get states
rm -rf /mnt/srv/salt
wget -q https://github.com/gravitezero/mkarch/archive/master.tar.gz;
quiet tar xzvf master.tar.gz;
mv mkarch-master/hosts/$HOSTNAME/salt /mnt/srv;

chrootsh salt-call --local state.highstate