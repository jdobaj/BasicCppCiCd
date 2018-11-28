# Containerized QT development environment

## Quick starter guide

**Linux**: Open a shell and start developing Qt on your *Linux machine*.

1. [Install Docker](https://docs.docker.com/install/)
2. Run the following commands

```shell
host> xhost + && sudo docker run -it -v /home/`id -nu`:/home/`id -nu` -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --name qt-dev jdobaj/qt-dev:qtcreator
docker-container> qtcreator
```

**Windows**: Open a command line and start developing Qt on your *Windows machine*.

1. Install Docker
2. Install and start a Windows X Server (e.g. [VcXsrv](https://sourceforge.net/projects/vcxsrv/))
3. Retrieve your IP-Address with *ipconfig*
4. Choose step 4(a) or step 4(b)
* 4(a) Run the following commands within the *Command Prompt*

```shell
host> ipconfig
host> SET MY_IP_ADDRESS=<REPLACE_WITH_YOUR_IP_ADDRESS>
host> docker run -it -e DISPLAY=%MY_IP_ADDRESS%:0.0 --name qt-dev jdobaj/qt-dev:qtcreator
docker-container> qtcreator
```

* 4(b) Run the following commands within *PowerShell*

```shell
host-PS> ipconfig
host-PS> set-variable -name MY_IP_ADDRESS -value "<REPLACE_WITH_YOUR_IP_ADDRESS>"
host-PS> docker run -it -e DISPLAY=${MY_IP_ADDRESS}:0.0 --name qt-dev jdobaj/qt-dev:qtcreator
docker-container> qtcreator
```

## Overview

This project creates a QT development environment within a Docker container.
The installation process uses the graphical Qt offline installer.
This makes the installation process significantly faster and easier, when compared to the *from source* compilation and installation process.
However, due to utilizing of the graphical installer, the image is not created in a fully automated fashion and on Windows system it is required to install a X Server.

The related GitHub projects provided in the following listing, setup a Docker development environment in a fully automated fashion. However, this requires more time and might also result in some build issues with newer Linux and QT versions.

* [Installation form source using the Qt-GitHub-Repo](https://github.com/erstrom/docker-qt)
* [Installation from source based on downloading submodules](https://github.com/hadim/docker-qt)

## Installation

### Docker

For installing docker see the [official docker documentation](https://docs.docker.com/install/).

### Windows

On Windows platforms a Windows X Server is required to display the graphical setup program - see e.g. [VcXsrv](https://sourceforge.net/projects/vcxsrv/)

## Build Docker image and install QT

The installation process is slightly different for Windows and Linux based systems. In the following the build process for Windows is described. Steps that are only necessary on Windows system are marked with **[Windows Only]**. The scripts are provided for Linux and Windows. On Linux system use the **.sh** scripts, instead of the **.bat** scripts.


1. Open the command line and navigate into the repository-directory where the **Dockerfile** and the **scripts** are located.
2. Build the Docker image by executing the *docker-build script*, which does the following:
    * Setup Ubuntu with the required build tools
    * Create a user **developer** and add the user to the root usergroup.
    * Create the */home/developer* directory
    * Download the Qt graphical installer and make it executable

```shell
host> .\docker-build.bat
```

3. **[Windows Only]** Retrieve your IP-Address. This is required to connect to the X Window server on your Windows host machine.

```shell
host> ipconfig
```

4. **[Windows Only]** Start your previously installed X Server
5. Launch the Docker image and pass your IP-Address. Replace \<YOUR-IP-ADDRESS> with the previously obtained IP-Address. On Linux system your IP-Address is not required. 

```shell
# Windows
host> .\docker-run-shell.bat <YOUR-IP-ADDRESS>
# Linux
host> .\docker-run-shell.sh
```

6. You are now in the Docker container signed in as user **developer**. Your current directory should be */home/developer*, if not change your directory. Start the graphical installer and follow the installation instructions.

```shell
docker-container> cd ${HOME_DIR}
docker-container> ls
docker-container> ./${QT_INSTALLER}
```

7. Your Qt development environment is now ready to use. However, if you stop the Docker container, your installation will be  lost. We thus must commit the changes to permanently store them in an image. Therefor open a command line on your host machine and commit the changes to create a new image.

```shell
# List your Docker images
host> docker ps
REPOSITORY            TAG       IMAGE ID        CREATED            SIZE
jdobaj/qt-dev         latest    ad65e7229ec8    29 minutes ago     3.28GB
<none>                <none>    e39a64aa7722    40 minutes ago     124MB
<none>                <none>    ae519a74a745    45 minutes ago     124MB
ubuntu                18.04     ea4c82dcd15a    2 weeks ago        85.8MB

# List the running Docker containers
host> docker ps
CONTAINER ID    IMAGE           COMMAND         CREATED         STATUS         PORTS      NAMES
e61757e4cac4    jdobaj/qt-dev   "/bin/bash"     14 minutes ago  Up 14 minutes             qt-sh

# Commit changes and create a new container jdobaj/qtcreator
host> docker commit -p -m "Installed Qt 5.11.2 via GUI-installer" e61757e4cac4 jdobaj/qtcreator

# Again, list your Docker images
host> docker images
REPOSITORY            TAG       IMAGE ID       CREATED             SIZE
jdobaj/qtcreator      latest    c5c9f281215d   55 seconds ago      7.88GB
jdobaj/qt-dev         latest    ad65e7229ec8   38 minutes ago      3.28GB
<none>                <none>    e39a64aa7722   About an hour ago   124MB
<none>                <none>    ae519a74a745   About an hour ago   124MB
ubuntu                18.04     ea4c82dcd15a   2 weeks ago         85.8MB
```

8. Now you have a local image called *jdobaj/qtcreator*. You can  run the image and/or upload it to the Docker Cloud.
    * Run the image as shown in *docker-run-shell.bat*
    * Or [push images to Docker Cloud](https://docs.docker.com/docker-cloud/builds/push-images/)

```shell
# Push local image jdobaj/qtcreator to Docker Cloud 
# as jdobaj/qt-dev:qtcreator, where <DOCKER_USER_ID>/<repository>:<tag>
# TODO: jdobaj must be replaced with your docker user id.
# The following commands can be executed in a Windows PowerShell environment.
host-PS> set-variable -name DOCKER_ID_USER -value "<REPLACE_WITH_YOUR_DOCKER_ID_USER>"
host-PS> set-variable -name DOCKER_SRC_IMG -value "qtcreator:latest"
host-PS> set-variable -name DOCKER_TARGET_IMG -value "qt-dev:qtcreator"
host-PS> docker tag ${DOCKER_ID_USER}/${DOCKER_SRC_IMG} ${DOCKER_ID_USER}/${DOCKER_TARGET_IMG}
host-PS> docker push ${DOCKER_ID_USER}/qt-dev
```

### Linux
