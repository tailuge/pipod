# hpod

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/tailuge/hpod)

This project contains a gitpod Docker file that installs the haskell platform

```
RUN curl -sSL https://get.haskellstack.org/ | sh
```

Use Haskell on the command line

```
stack new helloworld new-template
cd helloworld/
stack build
stack exec helloworld-exe
```
