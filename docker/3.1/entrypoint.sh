#!/usr/bin/env bash

set -e -x

if [ ! -d /data/itop/setup ];then
	unzip -qn -d /data /opt/iTop-3.1.zip "web/*"
	mv /data/web /data/itop
	mkdir -p /data/itop/{conf,data,log,env-production,env-production-build,env-test,env-test-build}
	chown -R www-data.www-data /data/itop/{conf,data,log,env-production,env-production-build,env-test,env-test-build}
	ln -sf /data/itop /var/www/html/itop
fi

exec $@