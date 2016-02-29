# Alpine Gitolite

[![Image Layers](https://badge.imagelayers.io/ekapusta/alpine-gitolite:latest.svg)](https://imagelayers.io/?images=ekapusta/alpine-gitolite:latest) [![Docker Stars](https://img.shields.io/docker/stars/ekapusta/alpine-gitolite.svg?style=flat-square)](https://hub.docker.com/r/ekapusta/alpine-gitolite/) [![Docker Pulls](https://img.shields.io/docker/pulls/ekapusta/alpine-gitolite.svg?style=flat-square)](https://hub.docker.com/r/ekapusta/alpine-gitolite/)

Uses latest stable gitolite of 3.x

## Build

    docker build --tag=ekapusta/alpine-gitolite .

## Go into

    docker ps --filter=name=gitolite && docker stop gitolite && docker rm gitolite
    docker run --detach --name=gitolite ekapusta/alpine-gitolite
    docker exec --interactive=true --tty=true gitolite sh

## Debug

    docker run --rm ekapusta/alpine-gitolite
