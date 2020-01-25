FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo apt-get install -y \
    apt-get install gcc-arm-none-eabi gdb-arm-none-eabi libnewlib-arm-none-eabi srecord mercurial minicom qemu-user gcc-arm-linux-gnueabihf \    
 && sudo rm -rf /var/lib/apt/lists/*

# initialise
USER gitpod
USER root
