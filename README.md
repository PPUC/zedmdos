## zedmdos
image with dmdserver and dmd-play on a standalone rpi.

## compile

### for rpi2, rpi3, rpi cm3, rpi zero 2
make bcm2836-build

### for rpi4
make bcm2711-build

### for rpi5
make bcm2711-build

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

## how to display image, text or video ?
- from an other pc, download dmd-play : https://github.com/batocera-linux/dmd-simulator/blob/master/dmd-play.py
  this is a small program that can communicate with dmdserver to display image (jpg, png, animated gif), text, moving text, videos, clock, countdown, ...

  for example : dmd-play.py --host 192.168.0.43 --countdown "2024-07-26 20:00:00" --countdown-header "PARIS 2024"

- you can create a file named configs/boot.sh including this line (make boot_play empty in zedmdos.ini):

  dmd-play --countdown "2024-07-26 20:00:00" --countdown-header "PARIS 2024" -r 0 -b 255

## how to shutdown ?
- just power off. the sd card is turned read only. it can be cut off safely.

## issues
There is a know issue when you plug a zedmd and no pixelcade : the zedmd doesn't work.

Workaround : in dmdserver.ini, put disable the pixelcade.
