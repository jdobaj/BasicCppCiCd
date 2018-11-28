FROM ubuntu:18.04 as qt-dev

# Choose user
ENV USER_NAME developer
ENV HOME_DIR /home/${USER_NAME}

# Choose Qt version
ENV QT_VERSION_MAJOR 5.11
ENV QT_VERSION 5.11.2

# Install core dependencies
RUN apt-get update && apt-get -y install sudo apt-utils curl wget

RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y autoclean \
    && apt-get -y install gcc g++ gdb cmake make build-essential libfontconfig1 git libgl1-mesa-dev qtcreator \
    && apt-get -y install mesa-common-dev libglu1-mesa-dev libxcb-xinerama0-dev libfreetype6-dev libsqlite3-dev libgles2-mesa-dev libgles2-mesa bzip2 bison ruby flex \
    && apt-get -y install libfontconfig1-dev libx11-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev \
    && apt-get -y install libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev \
    && apt-get -y install flex bison gperf libicu-dev libxslt-dev ruby \
    && apt-get -y install libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libdbus-1-dev libfontconfig1-dev libcap-dev libxtst-dev libpulse-dev libudev-dev libpci-dev libnss3-dev libasound2-dev libxss-dev libegl1-mesa-dev gperf bison \
    && apt-get -y install libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    && apt-get -y install libclang-6.0-dev

# Add user in root-usergroup and create home directory
# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p ${HOME_DIR} && \
    echo "${USER_NAME}:x:${uid}:${gid}:${USER_NAME},,,:${HOME_DIR}:/bin/bash" >> /etc/passwd && \
    echo "${USER_NAME}:x:${uid}:" >> /etc/group && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME} && \
    chown ${uid}:${gid} -R ${HOME_DIR}

USER ${USER_NAME}
WORKDIR ${HOME_DIR}

# Download Qt Base
ENV QT_INSTALLER qt-opensource-linux-x64-"$QT_VERSION".run
ENV QT_BASE_SRC http://download.qt.io/official_releases/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/"$QT_INSTALLER"
RUN wget $QT_BASE_SRC -P ${HOME_DIR} && chmod u+x ${HOME_DIR}/${QT_INSTALLER}

#CMD ["bash", "/home/developer/$QT_INSTALLER"]
