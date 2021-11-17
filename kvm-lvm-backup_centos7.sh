#!/bin/bash

/usr/bin/rm -rf /root/backup/kvm-lvm-backup.cfg;
/usr/sbin/lvdisplay | /usr/bin/grep Name | /usr/bin/grep _img | grep -v snap | /usr/bin/awk '{print $3}' > /root/backup/kvm-lvm-backup.cfg;

[ ! -f /root/backup/kvm-lvm-backup.cfg ] && { echo -e "\nConfig file not found, creating it\nPlease add your LVMs to the config file becore continuing\n"  && exit 1; };
[ ! -s /root/backup/kvm-lvm-backup.cfg ] && { echo -e "\nkvm-lvm-backup.cfg is empty, please fill in your LVM details" && exit 1; };

/usr/bin/mkdir -p /backup/`date "+%Y%m%d"`;
rm -rf /backup/`date +%Y%m%d -d "2 day ago"`;

/usr/bin/echo "$(date)"
/usr/bin/cat /root/backup/kvm-lvm-backup.cfg | while read iName; do
if [ -z "${iName}" ]; then /usr/bin/echo -e "\nNo LVM Name or Volume Group Specified...Skipping\n"; continue; fi;
lv_path=$(/usr/sbin/lvscan | /usr/bin/grep "`/usr/bin/echo KVMLVM\/${iName}`" | /usr/bin/awk '{print $2}' | /usr/bin/tr -d "'");
if [ -z "${lv_path}" ]; then /usr/bin/echo -e "\nNo such LVM exists: ${lv_path}\nCorrect path name in config file\n"; continue; fi;
size=$(/usr/sbin/lvs ${lv_path} -o LV_SIZE --noheadings --units g --nosuffix | /usr/bin/tr -d ' ');
/usr/sbin/lvcreate -s --size=${size}G -n ${iName}_snap ${lv_path} && /bin/dd if=${lv_path}_snap bs=16MB | /bin/gzip -c | /bin/dd of=/backup/`date "+%Y%m%d"`/KVMLVM-${iName}.`date +%Y-%m-%d-%H.%M.`.gz;
/usr/sbin/lvremove -f ${lv_path}_snap;
/usr/bin/echo "$(date)"
done;