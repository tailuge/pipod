FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo apt-get install -y \
    haskell-platform \
 && sudo rm -rf /var/lib/apt/lists/*

# initialise
RUN stack setup

#RUN curl -sSL https://get.haskellstack.org/ | sh
