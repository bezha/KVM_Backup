Backup KVM VPS

- [x] In file kvm-lvm-backup_centos7.sh change KVMLVM to proper VG name (pvs -a)
- [x] In file backup.sh change KVM name
- [x] Set up Cron job: 15 00 * * * /root/backup/backup.sh

For disk partition please use parted: 

Manual https://www.jeffgeerling.com/blog/2021/htgwa-partition-format-and-mount-large-disk-linux-parted

- parted /dev/sda
- (parted) mklabel gpt             # to create a partition table
- (parted) print                   # to verify parition info
- (parted) mkpart primary 0% 100%  # create primary partition filling entire disk
- (parted) quit
