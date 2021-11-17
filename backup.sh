#!/bin/bash

/root/backup/kvm-lvm-backup_centos7.sh > /dev/null 2>&1 && /root/backup/backup2.sh | mailx -s "Backup KVM" bezhav@gmail.com