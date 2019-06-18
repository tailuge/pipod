FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo apt-get install -y \
    haskell-platform \
 && sudo rm -rf /var/lib/apt/lists/*