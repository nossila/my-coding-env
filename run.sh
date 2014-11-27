#!/bin/sh
docker run -v /var/run/docker.sock:/container/var/run/docker.sock -v /home/alisson/work:/home/alisson/work -v /home/alisson/.gitconfig:/home/alisson/.gitconfig -v /home/alisson/.ssh:/home/alisson/.ssh -i -t my-coding-env
