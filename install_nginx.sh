#!/bin/bash

cpu_core_count=$(cat /proc/cpuinfo | grep processor | wc -l)
nginxVersion="1.24.0"
vtsVersion="0.2.2"
installDir="/usr/local/nginx"

mkdir -p /data && /usr/local/nginx/conf/conf.d && cd /data

apt update && apt -y install vim wget curl git libtool gnupg2 ca-certificates build-essential zlib1g zlib1g-dev libpcre3 libpcre3-dev libssl-dev

wget https://nginx.org/download/nginx-${nginxVersion}.tar.gz && tar -zxvf nginx-${nginxVersion}.tar.gz

wget https://github.com/vozlt/nginx-module-vts/archive/refs/tags/v${vtsVersion}.tar.gz && tar -zxvf ${vtsVersion}.tar.gz

cd nginx-${nginxVersion} || exit

./configure --prefix=/usr/local/nginx --with-stream --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module --add-module=../nginx-module-vts-${vtsVersion} && make -j ${cpu_core_count} && make install && /usr/local/nginx/sbin/nginx

cd ~ && rm -rf /data/*
