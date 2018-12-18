# Containerized QT build and operation environment

## Setup your Linux host system

1. [Install Docker-CE](https://docs.docker.com/install), but run the **docker hello-world** example only after step 2.

2. Change the default storage location of your docker installation and set the cgroup-parent for your docker containers. All docker containers will be started as a child process of this cgroup. More information about cgroups can be found [here](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/ch01). If it is necessary to do a more fine grained management of containers, it is also possible to manage all the cgroups manually, as shown in [this post](https://medium.com/@asishrs/docker-limit-resource-utilization-using-cgroup-parent-72a646651f9d).

```shell
sudo nano /etc/docker/daemon.json
{
        "data-root": "/opt/docker",
        "cgroup-parent": "/hipasetouchpanel"
}
```

3. Manage docker as non-root user

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
docker run hello-world
```

4. Add your host's XServer to the cgroup created in step 2. Retrieve the pid of your XServer using the **pgreg** command. Add the process to the cgroup using the **cgclassify** command. More details can be found [here](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/resource_management_guide/sec-moving_a_process_to_a_control_group). A description of a persistent cgroup configuration can be found [here](https://wiki.archlinux.org/index.php/cgroups#Persistent_group_configuration).

```shell
sudo apt-get install -y cgroup-tools
sudo cgclassify -g cpu:hipasetouchpanel "$(pgrep Xorg)"
```

5. Limit CPU resource usage of the cgroup to e.g. 10 percent. Again, see the [persistent cgroup configuration](https://wiki.archlinux.org/index.php/cgroups#Persistent_group_configuration) in order to set persistent limits (e.g. CPU, memory, I/O, network). 

```shell
sudo echo 10000 > /sys/fs/cgroup/cpu,cpuacct/hipasetouchpanel/cgroup
```

6. Install **ctop** on your host in order to inspect the cgroups on your host. Run **ctop** and press **F5** to switch from the *list view mode* to the *tree view mode*.

```shell
sudo apt-get install -y ctop
ctop
```

## Create the build image

The **Dockerfile** could use [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/). The **target** specifies the stage where the build stops. In the given example, no build output is generated, which makes multi-stage builds obsolete in this case.

```shell
docker build --target build-env --file Dockerfile.build --tag jdobaj/qt-build-env:v1.0 .
```

## Run the build environment

* On Linux run:
  * The -v option allows to share folders between the container and the host machine.
  * The build sources and the build output can both be shared using the specified shared folder.

```shell
xhost +
docker run -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/`id -nu`:/home/`id -nu` -e DISPLAY=unix$DISPLAY --name qt-build-env jdobaj/qt-build-env:v1.0
```

* On Windows:
  1. Start a XServer on your host, like [VcXsrv](https://sourceforge.net/projects/vcxsrv/)
  2. Run the following commands:

```shell
set YOUR_IP_ADDRESS="10.x.x.x"
docker  run -it --privileged -e DISPLAY=%YOUR_IP_ADDRESS%:0.0 --name qt-build-env jdobaj/qt-build-env:v1.0
```

## Build and run the operation container

1. If you can not use multi-stage builds, then it is necessary to first create your operation container image:

```shell
docker build --file Dockerfile.op --tag jdobaj/qt-op:v1.0 .
```

2. Running the operation container and sharing folders with the host system is done like in the previous steps. 

```shell
xhost +
docker run -it --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/`id -nu`:/home/`id -nu` -e DISPLAY=unix$DISPLAY --name qt-op jdobaj/qt-op:v1.0
```