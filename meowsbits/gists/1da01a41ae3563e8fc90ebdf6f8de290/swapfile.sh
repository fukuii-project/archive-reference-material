# Is swap memory already in use?
root@my-computer:~$ free
              total        used        free      shared  buff/cache   available
Mem:        4039400     2454264      105892        1152     1479244     1346484
Swap:             0           0           0

root@my-computer:~$ touch /var/swap.img
root@my-computer:~$ chmod 600 /var/swap.img

root@my-computer:~$ swap_megabytes=1000
root@my-computer:~$ dd if=/dev/zero of=/var/swap.img bs=1024k count=$swap_megabytes
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 1.84515 s, 568 MB/s

root@my-computer:~$ mkswap /var/swap.img
Setting up swapspace version 1, size = 1000 MiB (1048571904 bytes)
no label, UUID=7e970940-4c1f-4a43-9ce1-5d8f5979da38

root@my-computer:~$ swapon /var/swap.img

# Enable swap file during boot (and after a reboot)
root@my-computer:~$ echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab

# Decided the first swap file was so nice, I want a bigger one now.
root@my-computer:~$ swapoff /var/swap.img
root@my-computer:~$ dd if=/dev/zero of=/var/swap.img bs=1024k count=4000                                                                                                                                                                                                          
4000+0 records in
4000+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 7.05057 s, 595 MB/s

root@my-computer:~$ mkswap /var/swap.img                                                                                                                                                                                                                                          
Setting up swapspace version 1, size = 3.9 GiB (4194299904 bytes)
no label, UUID=919c826c-da34-442c-b4c7-6b8b456a723a
root@my-computer:~$ swapon /var/swap.img                                                                                                                                                                                                                                          

# https://www.digitalocean.com/community/tutorials/how-to-configure-virtual-memory-swap-file-on-a-vps
