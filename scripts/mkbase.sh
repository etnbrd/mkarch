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

  Ask "Arch ?" arch
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

quiet umount /mnt/{home,};

mount ${DISK_DEVICE}2 /mnt &&
mkdir -p /mnt/home &&
mount ${DISK_DEVICE}3 /mnt/home;
Error $? "$ER Failed to mount partitions" "$IF Partitions mounted";

# TODO fix this, can't find target base base-devel when using $BASE
pacstrap /mnt base base-devel;
Error $? "$ER ${BWhi}pacstrap${Rst} failed" "$IF pacstrap successful";

genfstab -U -p /mnt >> /mnt/etc/fstab;

echo $HOSTNAME > /mnt/etc/hostname
Error $? "$ER Failed to setup hostname" "$IF hostname \t${BIYel}`cat /mnt/etc/hostname`${Rst}"

chrootsh passwd < <(echo -e "$ROOT_PWD\n$ROOT_PWD")
Error $? "$ER Failed to set root passwd" "$IF root passwd"

chrootsh rm -f /etc/localtime
chrootsh ln -s /usr/share/zoneinfo/$LOCALZONE /etc/localtime
Error $? "$ER Failed to setup localtime" "$IF localtime \t${BIYel}$LOCALZONE${Rst}"

#TODO fix this, error bsdtar: Failed to set default locale
wget ${SOURCE}/hosts/$HOSTNAME/locale.gen -qO - > /mnt/etc/locale.gen
Error $? "$ER Failed to setup locales" "$IF locales \t${BIYel}`cat /mnt/etc/locale.gen`${Rst}"

chrootsh locale-gen
Error $? "$ER Failed to generate locales" "$IF locales generated"

wget ${SOURCE}/hosts/$HOSTNAME/vconsole.conf -qO - > /mnt/etc/vconsole.conf
Error $? "$ER Failed to setup vconsole" "$IF vconsole\n${BIYel}`cat /mnt/etc/vconsole.conf | sed s_^_\\\t_`${Rst}"

chrootsh mkinitcpio -p linux
Error $? "$ER Failed to make initramfs" "$IF intiramfs created"

chrootsh pacman -Sy --noconfirm grub &&
chrootsh grub-install --target=i386-pc --recheck $DISK_DEVICE &&
chrootsh grub-mkconfig -o /boot/grub/grub.cfg
Error $? "$ER Failed to setup grub" "$IF grub installed"

chrootsh systemctl enable dhcpcd;
Error $? "$ER Failed to enable dhcpcd" "$IF dhcpcd enabled"

chrootsh pacman -Sy --noconfirm openssh &&
chrootsh systemctl enable sshd;
Error $? "$ER Failed to enable sshd" "$IF sshd enabled"

# TODO make mkpost launch at reboot