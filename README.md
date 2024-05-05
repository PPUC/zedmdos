## zedmdos
image with dmdserver and dmd-play on a standalone rpi4.

## compile
make bcm2711

## burn
- format a fat32 sdcard
- unzip zedmdos.zip on it
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

## how to shutdown ?
- just power off. the sd card is turned read only. it can be cut off safely.
