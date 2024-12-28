FROM ubuntu:20.04

RUN apt-get update && apt-get install -y sudo && DEBIAN_FRONTEND=noninteractive apt install -y gawk wget git diffstat nano unzip texinfo gcc \
    build-essential chrpath socat cpio python3 python3-pip xterm vim python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 qemu-system-x86 qemu-utils \
    python3-subunit zstd liblz4-tool file locales libacl1 git qemu qemu-kvm

RUN locale-gen en_US.UTF-8
    
ARG USERNAME=ravendexter
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && adduser $USERNAME sudo

USER $USERNAME

RUN git clone git://git.yoctoproject.org/poky /home/$USERNAME/poky
RUN sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/poky

WORKDIR /home/$USERNAME/poky

COPY ./entry.sh ./entry.sh

ENV TERM=xterm

ENTRYPOINT ["bash", "entry.sh"]