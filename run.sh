#!/bin/sh
docker run -v /var/run/docker.sock:/container/var/run/docker.sock -i -t my-coding-env
