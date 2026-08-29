#!/usr/bin/env bash

if [ ! -d /data/itop/setup ];then
  rsync -aqu /usr/src/itop/ /data/itop/
  mkdir -p /data/itop/{conf,data,log,env-production,env-production-build}
  chown -R 65532:65532 /data/itop/{conf,data,log,env-production,env-production-build}
fi

if [ ! -L /var/www/html ];then
  rm -rf /var/www/html
  ln -sf /data/itop /var/www/html
fi

if [ $1 != "apache2ctl" ];then
  exec $@
else
  install -d -m 755 -o 65532 -g 65532 /var/run/apache2 
  exec gosu 65532:65532 "$@"
fi
