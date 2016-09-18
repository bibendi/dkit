# Docker

## Install

### Ubuntu

TODO

### Mac OS X

```
sudo brew install docker
sudo brew switch docker 1.12.1
```

#### dlite

скачать https://github.com/nlf/dlite/releases/download/1.1.5/dlite

`sudo dlite install -c 2 -m 4 -d 20 -S $HOME`

##### Simple

- `dlite stop`
- скачать `bzImage` и `rootfs.cpio.xz` https://github.com/bibendi/dhyve-os/releases/tag/2.3.1
- положить в `~/.dlite/`
- `dlite start`

##### or Advanced (for other docker version)

```
git clone https://github.com/nlf/dhyve-os.git
cd dhyve-os
git checkout legacy
vi Dockerfile`
# найти DOCKER_VERSION и заменить на нужную версию
make
dlite stop
cp output/{bzImage,rootfs.cpio.xz} ~/.dlite/
dlite start
```

# dkit

Набор docker-compose конфигов вспомогательного назначения для запуска проектов.

## ssh-agent

Необходим для установки приватных гемов.

```
./bin/ssh-add
```

## DNS

Поддержка dns зоны `.docker`

```
./bin/dnsdock up -d
```

### Installation

#### Ubuntu

TODO

#### Mac OS X

по мотивам триллера https://github.com/nlf/dlite/pull/110/files

```
ssh docker@docker.local
vi /etc/default/docker
# add to DOCKER_ARGS: `--bip=172.17.0.1/24 --dns=172.17.0.1`
exit
dlite stop && dlite start

sudo route -n add 172.17.0.0/8 local.docker
DOCKER_INTERFACE=$(route get local.docker | grep interface: | cut -f 2 -d: | tr -d ' ')
DOCKER_INTERFACE_MEMBERSHIP=$(ifconfig ${DOCKER_INTERFACE} | grep member: | cut -f 2 -d: | cut -c 2-4)
sudo ifconfig "${DOCKER_INTERFACE}" -hostfilter "${DOCKER_INTERFACE_MEMBERSHIP}"

sudo vi /etc/resolver/docker
# add: `nameserver 172.17.0.1`
sudo killall -HUP mDNSResponder

# check
ping docker
```
