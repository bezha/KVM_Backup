/bin/echo "[ Disk Space Information ]"
/bin/echo
/bin/df -h | /bin/grep backup;
/bin/echo
/bin/echo "[ LVM Space Information ]"
/sbin/pvs -a | /bin/grep lvm2;
/bin/echo
/bin/echo "[ All VPS ]"
/sbin/lvdisplay | /bin/grep Name | /bin/grep _img | grep -v img_snap | /bin/awk '{print $3}' | wc -l
/bin/echo
/bin/echo "[ Active VPS ]"
/usr/bin/virsh list | /bin/grep kvm | wc -l
/bin/echo
/bin/echo "[ Backuped VPS ]"
/bin/ls -1 /backup/`date +%Y%m%d` | wc -l
/bin/echo
/bin/echo "[ VPS Backup Information ]"
/usr/bin/du -sh /backup/*;