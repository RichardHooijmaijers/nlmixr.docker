# nlmixr.docker

This repository includes the docker file for nlmixr.

## Building the Image

### Locally

To build a file on your local system, you may run the following commands:

```
git clone https://github.com/RichardHooijmaijers/nlmixr.docker.git
cd nlmixr.docker
docker build . -t nlmixr-dev
```

### From GitHub

To build directly from GitHub, you may run the following command:

```
docker build \
  https://github.com/RichardHooijmaijers/nlmixr.docker.git \
  -t nlmixr-dev
```

