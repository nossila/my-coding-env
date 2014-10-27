FROM ubuntu:14.04
MAINTAINER Alisson Patricio <eu@alisson.net>

# Update Base System
RUN apt-get update && apt-get -y upgrade \ 
      && apt-get install -y language-pack-en \
      && locale-gen en_US.UTF-8 \
      && dpkg-reconfigure locales

# Install Basic Packages
RUN apt-get install -y build-essential software-properties-common wget curl git man tmux zsh vim

# Install Zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

WORKDIR /root
CMD ["zsh"]
