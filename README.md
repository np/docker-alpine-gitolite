# Alpine Gitolite

[![Image Layers](https://badge.imagelayers.io/ekapusta/alpine-gitolite:latest.svg)](https://imagelayers.io/?images=ekapusta/alpine-gitolite:latest) [![Docker Stars](https://img.shields.io/docker/stars/ekapusta/alpine-gitolite.svg?style=flat-square)](https://hub.docker.com/r/ekapusta/alpine-gitolite/) [![Docker Pulls](https://img.shields.io/docker/pulls/ekapusta/alpine-gitolite.svg?style=flat-square)](https://hub.docker.com/r/ekapusta/alpine-gitolite/)

Uses latest stable gitolite of 3.x

## Build

    docker build --tag=ekapusta/alpine-gitolite .

### Override through ENV

 * GITOLITE_ADMIN_KEY
 * GITOLITE_ADMIN_NAME admin
 * GITOLITE_REMOTE


## Run on 2222 port with public-key passed

    docker run --name=gitolite --detach --publish=2222:22 \
           --env=GITOLITE_ADMIN_KEY="$(cat ~/.ssh/id_rsa.pub)" \
           --volume=$(pwd)/vol/home/gitolite/repositories:/home/gitolite/repositories \
           ekapusta/alpine-gitolite

## Go into

    docker rm --force gitolite && \
    docker run --detach --name=gitolite ekapusta/alpine-gitolite && \
    docker exec --interactive=true --tty=true gitolite sh

## Debug

    ssh git@localhost -p 2222
    docker run --rm ekapusta/alpine-gitolite
