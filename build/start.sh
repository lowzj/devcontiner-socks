#!/bin/sh

function install() {
  # cp /etc/apk/repositories /etc/apk/repositories.bak
  # sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && apk upgrade
  which redsocks || (apk update && apk add libevent redsocks iptables curl openrc && rm -rf /var/cache/apk/*)
}

function config() {
  cp ./redsocks.conf /etc/redsocks/redsocks.conf
  # ./redsocks-iptables.sh
}

install && config