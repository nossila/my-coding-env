FROM ubuntu:14.04
MAINTAINER Alisson Patricio <eu@alisson.net>

# Update Base System
RUN apt-get update && apt-get -y upgrade \ 
      && apt-get install -y language-pack-en \
      && locale-gen en_US.UTF-8 \
      && dpkg-reconfigure locales

# Install Basic Packages
RUN apt-get update \
      && apt-get install --yes build-essential software-properties-common wget curl git mercurial subversion bzr man tmux zsh vim

# Install Golang
RUN curl https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz | tar -xz \
      && ./godeb install 1.3.3
ENV GOPATH /home/alisson/work/go

# Install Docker
RUN apt-get install apt-transport-https \
      && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
      && sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list" \
      && apt-get update \
      && apt-get install --yes lxc-docker

# Create personal User and remove password need to use sudo
RUN useradd --groups sudo --create-home --shell /bin/zsh alisson
RUN echo "alisson:alisson" | chpasswd
RUN sed --in-place --expression="s/\%sudo\t\ALL=(ALL:ALL) ALL/\%sudo\tALL=(ALL) NOPASSWD:ALL/" /etc/sudoers
USER alisson

# Install Zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# Install spf13-vim
RUN curl http://j.mp/spf13-vim3 -L -o - | sh

# Install vim-go and remove PIV
ADD .vimrc.local /home/alisson/.vimrc.local
RUN vim "+set nomore" \
      "+BundleInstall!" \
      "+BundleClean" \
      "+GoInstallBinaries" \
      "+qall"

# Setup docker alias to connect to the host instead of running docker inside docker
# all containers run on the host 
RUN echo "alias docker='sudo docker --host=unix:///container/var/run/docker.sock'" >> ~/.zshrc

WORKDIR /home/alisson
CMD ["zsh"]
