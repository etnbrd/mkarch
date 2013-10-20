#!/bin/zsh
#
# mkbase.sh by etnbrd
# This script install the base system

#####################################################
# PROMPT                                            #
#####################################################

# Init

while true
do

  Ask "Packages to install ?" BASE
  Ask "Hostname ?" HOSTNAME
  Ask "Time zone ?" LOCALZONE

  echo -e "${BIWhi}"
  echo -e "$IF $DISK_DEVICE"
  echo -e "${BIWhi}   Base \t${BIYel}$BASE"
  echo -e "${BIWhi}   Hostname \t${BIYel}$HOSTNAME"
  echo -e "${BIWhi}   Time zone \t${BIYel}$LOCALZONE"
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

# quiet umount /mnt/{home,};

# mount ${DISK_DEVICE}1 /mnt &&
# mkdir -p /mnt/home &&
# mount ${DISK_DEVICE}2 /mnt/home;
# Error $? "$ER Failed to mount partitions" "$IF Partitions mounted";

# pacstrap /mnt $BASE;
# Error $? "$ER ${BWhi}pacstrap${Rst} failed" "$IF Basecamp established, starting campfire :)";

# genfstab -U -p /mnt >> /mnt/etc/fstab;


# echo "${BIGre}>>${BIWhi} Success${Rst}, we made it to the ARCH-CHROUT, time to unpack salt, and let it roll :)";

# arch-chroot /mnt << EOF
chrootsh echo $HOSTNAME > /etc/hostname;
Error $? "$ER Failed to setup hostname" "$IF hostname \t${BIYel}`cat /mnt/etc/hostname`${Rst}"

chrootsh rm /etc/localtime
chrootsh ln -s /usr/share/zoneinfo/$LOCALZONE /etc/localtime
Error $? "$ER Failed to setup localtime" "$IF localtime \t${BIYel}$LOCALZONE${Rst}"

chrootsh wget ${SOURCE}/hosts/$HOSTNAME/locale.gen -qO - > /etc/locale.gen
Error $? "$ER Failed to setup locales" "$IF locales \t{BIYel}`cat /mnt/etc/locale.gen`${Rst}"

chrootsh locale-gen
Error $? "$ER Failed to generate locales" "$IF locales generated"

chrootsh wget ${SOURCE}/hosts/$HOSTNAME/vconsole.conf -qO - > /etc/vconsole.conf
Error $? "$ER Failed to setup vconsole" "$IF locales: \t{BIYel}`cat /mnt/etc/vconsole.conf`${Rst}"

chrootsh mkinitcpio -p linux
Error $? "$ER Failed to make initramfs" "$IF intiramfs created"

chrootsh echo "[archlinuxfr]
              SigLevel = Never
              Server = http://repo.archlinux.fr/$arch" >> /etc/pacman.conf;

chrootsh pacman -Sy yaourt;

# TODO do the bootloader
# TODO do the root password