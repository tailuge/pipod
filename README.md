# pipod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/tailuge/pipod)

This project contains a gitpod Docker file that installs arm cross assembler and emulator

```
cd digisys/lab1-asm/
make q-add.elf
qemu-arm q-add.elf 5 7
apt-cache show qemu-system-arm
lsb_release -a

```
ref:

http://spivey.oriel.ox.ac.uk/corner/Lab_one_(Digital_Systems)


```
git clone git://github.com/RIOT-OS/RIOT.git
cd RIOT/examples/hello-world
BOARD=microbit make emulate
```

ref:

https://riot-os.org/api/group__boards__microbit.html
