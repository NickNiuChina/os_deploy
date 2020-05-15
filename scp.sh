#!/usr/bin/expect -f
set timeout 3
set file [lindex $argv 0];
set dest [lindex $argv 1];
spawn scp -o "StrictHostKeyChecking no" $file  root@10.10.10.1:$dest
# /tftpboot/nbi_img/pxelinux.cfg/
expect "assword:"
send "rootroot\r"
interact
