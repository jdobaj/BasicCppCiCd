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

3. Manage docker as non-root user. Attention, this is a security risk and should only be done during development.

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
sudo echo 10000 > /sys/fs/cgroup/cpu,cpuacct/hipasetouchpanel/cpu.cfs_quota_us
```

6. Install **ctop** on your host in order to inspect the cgroups on your host. Run **ctop** and press **F5** to switch from the *list view mode* to the *tree view mode*.

```shell
sudo apt-get install -y ctop
ctop
```

## Building and running images

The **docker-*.sh** scripts can be used to create container images and to run those images. The following images can be created:

1. The **docker-multistage-build.sh** script performs a multi-stage build to create the final Alpine Linux operations image that runs the **elasticnodes-example**.
    * This image can be startet be executing the **docker-multistage-run.sh** script.
```shell
./docker-multistage-build.sh
./docker-multistage-run.sh
```

2. The **docker-dev-env-build.sh** script creates an Ubuntu development environment with qt5 and qtcreator pre-installed.
    * This image can be startet be executing the **docker-dev-env-run.sh** script.
    * In the container **qtcreator** can be started for app-development.
```shell
./docker-dev-env-build.sh
./docker-dev-env-run.sh
```

3. The **docker-ops-env-build.sh** script creates an Alpine Linux operations environment with the qt5 libraries pre-installed.
    * This image can be startet be executing the **docker-ops-env-run.sh** script.
```shell
./docker-ops-env-build.sh
./docker-ops-env-run.sh
```