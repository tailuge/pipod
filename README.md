# pipod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/tailuge/pipod)

This project contains a gitpod Docker file that installs arm cross assembler and emulator

The following work using qemu v4.0 from `sudo add-apt-repository ppa:jacob/virtualisation` (See Dockerfile)

```
cd digisys/lab1-asm/
make add.elf
qemu-system-arm -M microbit -device loader,file=add.elf -serial stdio -monitor telnet::45454,server,nowait -nographic

```
ref:

http://spivey.oriel.ox.ac.uk/corner/Lab_one_(Digital_Systems)


```
git clone git://github.com/RIOT-OS/RIOT.git
cd RIOT/examples/hello-world
BOARD=microbit make clean all -j4
BOARD=microbit make emulate

```

ref:

https://riot-os.org/api/group__boards__microbit.html

useful

```
apt-cache show qemu-system-arm
lsb_release -a
```
