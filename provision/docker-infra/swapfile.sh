#! /bin/bash

# create swap
#https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

SWAPFILE=/swapfile-4G

cat << EOF > /etc/systemd/system/swap.service
[Unit]
Description=Create a swap space

[Service]
Type=oneshot
ExecStartPre=-/usr/bin/fallocate -l 4G ${SWAPFILE}
ExecStartPre=-/usr/bin/chmod 600 ${SWAPFILE}
ExecStartPre=-/usr/sbin/mkswap ${SWAPFILE}
ExecStart=/usr/sbin/swapon ${SWAPFILE}

[Install]
WantedBy=swap.target
EOF

systemctl enable swap.service && systemctl start swap.service
