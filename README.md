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

CLI утилита вспомогательного назначения для запуска проектов.

## Installation

```
curl -L https://github.com/abak-press/dkit/releases/download/0.1.0/dkit-`uname -s`-`uname -m` > /usr/local/bin/dkit
chmod +x /usr/local/bin/dkit
```

## Usage

```
dkit --help
```

## ssh-agent

Необходим для установки приватных гемов.

```
dkit ssh add
```

## DNS

Поддержка dns зоны `.docker`

```
dkit dns up
```

### Installation

#### Ubuntu

TODO

#### Mac OS X

по мотивам триллера https://github.com/nlf/dlite/pull/110/files

Сделаем так, чтобы докер запускался на нужном нам IP адресе
```
ssh docker@local.docker

vi /etc/default/docker
# add to end of DOCKER_ARGS
--bip=172.17.0.1/24 --dns=172.17.0.1
# save :x

exit
dlite stop && dlite start
```

Добавим адрес ДНС сервера в систему
```
mkdir -p /etc/resolver

sudo vi /etc/resolver/docker
# paste
nameserver 172.17.0.1
# save :x

# Restart system DNS
sudo killall -HUP mDNSResponder
```

Переадресуем всю подсеть в докер (этот блок нужно выполнять после каждой перезагрузки системы)
```
sudo route -n add 172.17.0.0/8 local.docker
DOCKER_INTERFACE=$(route get local.docker | grep interface: | cut -f 2 -d: | tr -d ' ')
DOCKER_INTERFACE_MEMBERSHIP=$(ifconfig ${DOCKER_INTERFACE} | grep member: | cut -f 2 -d: | cut -c 2-4)
sudo ifconfig "${DOCKER_INTERFACE}" -hostfilter "${DOCKER_INTERFACE_MEMBERSHIP}"
```

Check
```
ping dnsdock.docker
```
