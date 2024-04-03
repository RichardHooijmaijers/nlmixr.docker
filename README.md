# nlmixr.docker

This repository includes the docker file(s) for `nlmixr2`. Currently there is a only a docker images for the production version.
This version will install the latest CRAN versions of all packages (if available).

## Getting started

Before working with the docker file, the docker software should be installed. An installer is available for all major operating systems:

- windows: <https://docs.docker.com/docker-for-windows/install/>
- mac: <https://docs.docker.com/docker-for-mac/install/>
- ubuntu: <https://docs.docker.com/install/linux/docker-ce/ubuntu/>

Make sure you read the prequisites, **especially on windows this is not always straightforward**. On other systems it is sufficient to download and run the installer.
Take into account that there might be some other differences when working with windows, these are specified in the last section.

## Running the Image

To run a docker image, a terminal window (or command prompt in windows) should be used. There are different ways of running the nlmixr docker, which are explained in the upcoming sections.

### From dockerhub

The docker files are available on [dockerhub](https://hub.docker.com/). it is possible to directly run the image from here.
Take into account that the first time doing this, it will donwload all applicable files from the repository. This can take some time depending on your internet speed. After the first time, the container will be saved locally and it the machine will start almost immediately.
To directly run from dockerhub, the following command can be issued to run the container:

```bash
docker run -v /Users/richard/Documents/:/home/rstudio/docs -d -p 8787:8787 -e PASSWORD=nlmixr nlmixr/nlmixr2prod:V0.5
```

Some explanation for the command:

- The `-v` option is used to mount a volume to the docker container. Although it is not not mandatory, it is highly recommended to easily run and save nlmixr models. In this example the the folder "Users/richard/Document" will be mounted to the docs folder in the home directory. Multiple folders can be mounted, as long as they are accessible on the host computer
- the `-d` option will run the container in detached mode
- the `-p` option will publish a container's port (or a range of ports) to the host
- the `-e` option will set environment variables. For the Rstudio docker which is being used on the background a password should be given.
- the last part identifies the docker file that should be started

Once the docker container is running, you can go to a browser and go to the following url:

`localhost:8787`

This will fire up an Rstudio server version. If everything went correctly you will see a login screen for Rstudio. You can login with username **rstudio** and password **nlmixr**. If a local folder was mounted you should be able to find this directly in the files pane in Rstudio.

### From Github

To build a file on your local system, the following method was proposed by Bill Denney:

```bash
git clone https://github.com/RichardHooijmaijers/nlmixr.docker.git
cd nlmixr.docker/prod.nlmixr2
docker build . -t nlmixr2prod
```
It is also possible to build directly from GitHub, using:

```bash
docker build \
  https://github.com/RichardHooijmaijers/nlmixr.docker.git \
  -t nlmixr2prod
```

Once the docker is build, it can be started as indicated in the previous section.

## Test the installation

Using the latest version of `nlmixr2` it is no longer necessary to test the installation. The main reason is that there are no more dependencies of python and the package installs like any other R package.

## Stop the container

Once you are done, or you would want to start another instance of the container, you can close the browser window and from the terminal the following can be done to stop all containers:

`docker kill $(docker ps -q)`

Each time you stop the container or restart/log-off, the container should be started again using the `docker run` command as stated above.
In case you want to stop a specific container, you can list the running containers with `docker container ls` and close the specific container ID (e.g. `docker container stop 1fa4ab2cf395`)

## Known issues

- In certain cases `localhost` is not recognized and the url should be `127.0.0.1:8787`
- In general most modern browsers will work with rstudio server. However there might be some problems when running shiny apps. Both chrome and safari were tested and should work fine. It could be that pop-ups should be enabled as shiny apps are opened in a separate browser tab.

## Windows specifics

On windows it can take some more effort to mount local drives. The following method was proposed by Nick Holford ([link](https://github.com/nlmixrdevelopment/nlmixr/issues/71#issuecomment-414675224)):

- Go to Docker settings shared drives and enter a local drive letter e.g. C. . This then requires providing login credentials for your local device to validate the choice of drive. That requirement could mean setting up a local account on Windows instead of the Microsoft account.
- Enter the drive letter and a colon e.g. C: before the path to the local directories. The trailing path separator is optional. It works with or without the "/".
- Including the /home/rstudio/docs path is essential in order to have access to the local directories (in /home/rstudio/docs).

`docker run -v C:/Users/nholf/Documents:/home/rstudio/docs -d -p 8787:8787 -e PASSWORD=nlmixr nlmixr/nlmixr2prod:V0.4`

You now have access to other directories in /home/rstudio in addition to examples and kitematic (i.e. analysis, data, models, scripts, ShinyMixR).

If you are using Docker Toolbox on Windows 7, the Docker Machine IP instead of localhost should be used. For example, http://192.168.99.100:8787/. To find the IP address, the `ipconfig` command can be used. In windows it might be necessary to stop the container using powershell, otherwise the container can be stopped using task manager.

## Customization

The Dockerfile setup is easy to customize with your own Docker image
requirements.  To add or remove packages or other parts of the setup, add
additional bash scripts in the `prod.nlmixr2` directory ending with `.sh`.  All
files ending in `.sh` in that directory are run in alphabetical order, so start
the filename with a number to insert it in the correct order.

The reason that the files are setup in this way is so that the installation of
required packages for the operating system (with `apt-get`) can be linked to the
installation of the R packages.
