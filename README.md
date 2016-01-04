Bootstrap OpenElec
==================

## Step 1 - Install OpenElec

Download OpenElec from [get-openelec][]

    curl -L -o ./tmp/open_elec.img.gz http://releases.openelec.tv/OpenELEC-RPi.arm-6.0.0.img.gz # rpi1
    curl -L -o ./tmp/open_elec.img.gz http://releases.openelec.tv/OpenELEC-RPi2.arm-6.0.0.img.gz # rpi2

Unzip

    gunzip -d ./tmp/open_elec.img.gz

Find device of SD card

    sudo parted -l

Unmount if mounted

    sudo  umount /dev/sdXX

Burn to SD card

    sudo dd if=./tmp/open_elec.img of=/dev/sdX bs=4M && sudo sync

Boot OpenElec


## Step 2 - Configure OpenElec

- Create autossh.sh in files/ from autossh.sh.template, replace: $STATIC_SSH_SERVER, $STATIC_SSH_SERVER_LOOPBACK_PORT, $STATIC_SSH_SERVER_PORT
- Create ~/.ssh/rpi_rsa that will be the private key accepted by your $STATIC_SSH_SERVER
- Create sync.conf in files/ from sync.conf.template, replace: $DEVICE_NAME

Ensure sshpass installed

    sudo apt-get -y install sshpass

SSH into OpenElec to accept keys, etc...

    sshpass -popenelec ssh root@PI_IP

Install btsync

    sshpass -popenelec ssh -t root@PI_IP "mkdir -p  /storage/.btsync && curl --silent https://download-cdn.getsync.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz  | tar -zxv -C /storage/.btsync"

Upload sync.conf

    sshpass -popenelec scp files/sync.conf root@PI_IP:/storage/.btsync/

Upload autossh stuff

    sshpass -popenelec scp files/autossh.sh ~/.ssh/rpi_rsa root@PI_IP:/storage/.ssh/

Upload autostart.sh

    sshpass -popenelec scp files/autostart.sh root@PI_IP:/storage/.config/

Reboot OpenElec.

## Step 3 - Configure Kodi

This step is custom to your conditions.

Plugins:

- Services: Watchdog
- Subtitles: OpenSubtitles

Configure:

- Timezone
- Enable web-server & EventServer for remote control
- Subtitles languages
- Subtitles location

[get-openelec]: http://openelec.tv/get-openelec
