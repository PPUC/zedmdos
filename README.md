## zedmdos
image with dmdserver and dmd-play on a standalone rpi.

## compile

git clone https://github.com/PPUC/zedmdos.git && cd zedmdos && git submodule init && git submodule update && make build-docker-image && make bcm2711-build

### for rpi1, rpi zero w/wh
make bcm2835-build

### for rpi2, rpi3, rpi cm3, rpi zero 2
make bcm2836-build

### for rpi4
make bcm2711-build

### for rpi5
make bcm2711-build

## compilation from wsl
sudo apt install make gcc g++ unzip bc bzip2 zip

git clone https://github.com/PPUC/zedmdos.git && cd zedmdos && git submodule init && git submodule update && PATH=/usr/sbin:/usr/bin:/sbin make bcm2711-build

### by default, docker is used to compile zedmdos. The following command creates the docker image used to compile
make build-docker-image

### the following command can be used to build a single package
make bcm2711-pkg PKG=connman

## burn
- format a fat32 sdcard
- unzip zedmdos-x.zip on it
- configure via files in configs directory

## what to do next ?
- configure the system : rename the file configs/zedmdos.ini.sample to zedmdos.ini
  - configure the wifi (ssid, key)
  - configure the system timezone (ie Europe/Paris)
  - configure what to display at boot (the network ip, the clock or nothing)
- configure dmdserver : rename the file configs/dmdserver.ini.sample to dmdserver.ini
  - if you do so, set Addr = 0.0.0.0 to remain open to the rest of the network
  - you can disable ZeDMD or Pixelcade if you've none of them
- connect via http on the dmd to discover the display things and discover the api and dmd-play
- enable ssh and develop more things :-P

## how to display image, text or video ?
- from an other pc, download dmd-play : https://github.com/batocera-linux/dmd-simulator/blob/master/dmd-play.py
  this is a small program that can communicate with dmdserver to display image (jpg, png, animated gif), text, moving text, videos, clock, countdown, ...

  for example : dmd-play.py --host 192.168.0.43 --countdown "2024-07-26 20:00:00" --countdown-header "PARIS 2024"

- you can create a file named configs/boot.sh including this line (make boot_play empty in zedmdos.ini):

  dmd-play --countdown "2024-07-26 20:00:00" --countdown-header "PARIS 2024" -r 0 -b 255

## how to shutdown ?
- just power off. the sd card is turned read only. it can be cut off safely.

## how to configure (edit /boot) without removing the sd card
- mount -o remount,rw /boot

## how to edit the system (except /boot)
- you can edit files (thanks to fsoverlay and tmpfs), but after a reboot, files will remain as there were : the os is a read only image. You need to recompile.

## issues
There is a know issue when you plug a zedmd and no pixelcade : the zedmd doesn't work.
There is a know issue when you plug a pixelcade and no zedmd : the pixelcade doesn't work.

Workaround : in dmdserver.ini, disable the pixelcade/zedmd.
