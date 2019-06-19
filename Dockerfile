FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo rm -rf /var/lib/apt/lists/*
# && sudo apt-get install -y \
#    haskell-platform \

RUN curl -sSL https://get.haskellstack.org/ | sh
