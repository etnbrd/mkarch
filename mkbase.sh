#!/bin/bash
#
# mkbase.sh by etnbrd
# This script install the base system

MNT="/mnt"
BOOTLOADER="grub"
BASE="base"
HOSTNAME="arch-srv"
LOCALZONE="Europe/Paris"
PWD="password"

# TODO make a utils.sh, and a makefile (or grunt) to concat these files together
Ask() {
  if [ -z ${!2} ]; then
    echo $1;
  else 
    echo $1 [${!2}];
  fi
  read tmp;
  if [[ -e $tmp || -e ${!2} ]]; then
    eval "$2=$tmp";
  fi
}

Ask "Mount point ?" MNT
Ask "Bootloader ?" BOOTLOADER
Ask "Packages to install ?" BASE
Ask "Hostname ?" HOSTNAME
Ask "Time zone ?" LOCALZONE
Ask "Root passwd ?" PWD

pacstrap $MNT "$BASE" $BOOTLOADER
genfstab -U -p $MNT >> $MNT/etc/fstab

arch-chroot $MNT << EOF
echo $HOSTNAME >> /etc/hostname
# TODO make an etc/vconsole.conf and echo it
# echo  >> /etc/vconsole.conf
ln -s /usr/share/zoneinfo/$LOCALZONE /etc/localtime
locale-gen
mkinitcpio -p linux
# TODO do the bootloader
# TODO do the root password

exit;