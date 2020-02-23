# docker-remote-tunnel 

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/ruan.ru.bekker@gmail.com) [![](https://images.microbadger.com/badges/image/ruanbekker/docker-remote-tunnel.svg)](https://microbadger.com/images/ruanbekker/docker-remote-tunnel "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/ruanbekker/docker-remote-tunnel.svg)](https://microbadger.com/images/ruanbekker/docker-remote-tunnel "Get your own version badge on microbadger.com") ![](https://img.shields.io/docker/pulls/ruanbekker/docker-remote-tunnel.svg)


Run Remote Docker commands via a SSH Tunnel

## Docker Remote Tunnel

Run Remote Docker commands via a SSH Tunnel. [Docker Hub: ruanbekker/docker-remote-tunnel](https://hub.docker.com/r/ruanbekker/docker-remote-tunnel)

## Description

I made this wrapper to simplify ci/cd deployments with concourse to deploy applications to docker swarm.

The wrapper creates a screen session, creates a ssh tunnel and mounting a local port to the docker socket on the manager node, allowing us to run docker commands locally, interfacing with the remote docker api.

## Usage:

Run a container, and map the path to your ssh key 

```
$ docker run -v ~/.ssh/id_rsa:/tmp/key -it ruanbekker/docker-remote-tunnel sh
```

Wrapper supports creating and terminating the tunnels:

```
$ docker-tunnel --help

Usage: /usr/bin/docker-tunnel
Description: Execute remote docker commands via ssh tunnel over a docker socket

 -h, --help                    Display usage instructions
 -c, --connect [user@foo.bar]  Establishes Tunnel to Remote SSH Server. Expects username@remote-server
 -t, --terminate               Terminates Tunnel
```

Establish a SSH Tunnel to your Manager node:

```
$ docker-tunnel -c root@manager.docker.example.com

  Source the environment either with:

  1) source /root/.docker-tunnel.sh
  2) export DOCKER_HOST="localhost:2376"

```

Source the environment:

```
$ source /root/.docker-tunnel.sh
```

Validate that the DOCKER_HOST variable has been set:

```
$ env | grep DOCKER
DOCKER_HOST=localhost:2376
```

Run a docker command from the container:

```
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
9kbmvcr73ceh2afozxrwx3CzT *   swarm-manager-1     Ready               Active              Leader              18.06.3-ce
vuxEvsv09qvRekwcltk7prmkx     swarm-worker-1      Ready               Active                                  18.06.3-ce
```

Terminate the tunnel:

```
$ docker-tunnel --terminate
```

Verify that the tunnel has been terminated:

```
$ docker node ls
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

## Docker Hub Image

- [Docker Hub: ruanbekker/docker-remote-tunnel](https://hub.docker.com/r/ruanbekker/docker-remote-tunnel)

