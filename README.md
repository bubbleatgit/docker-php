# Dockerfile 介绍

此 Dockerfile 基于 php 官方的 php:7.1-fpm-alpine3.7 镜像制作，添加了一些常用的扩展：

* redis 4.1.0RC1
* freetype
* libpng
* libwebp
* swoole
* pdo_pgsql 
* mysqli 
* pdo_mysql *
* pgsql
* gd

并修改时区为 `Asia/Shanghai` ，修改 alpine 的仓库地址为 `https://mirrors.ustc.edu.cn/alpine/v3.7`

# TODO

* 增加 docker-compose 示例