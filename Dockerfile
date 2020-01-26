FROM gitpod/workspace-full:latest

USER root
# Install custom tools, runtime, etc.
RUN apt-get update && apt-get install -y \
        gcc-arm-none-eabi libnewlib-arm-none-eabi srecord mercurial minicom qemu-user qemu qemu-system-arm gcc-arm-linux-gnueabihf \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

USER gitpod
# Apply user-specific settings
# Give back control
USER root
