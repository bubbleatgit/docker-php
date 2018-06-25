FROM php:7.1-fpm-alpine3.7

LABEL maintainer="tingshow163@gmail.com"
LABEL version="1.0"
LABEL description="FOR CHIANBLOCK STARS"

RUN set -xe \
    && echo -e "https://mirrors.ustc.edu.cn/alpine/v3.7/main\nhttps://mirrors.ustc.edu.cn/alpine/v3.7/community" > /etc/apk/repositories \
    && echo -e "nameserver 119.29.29.29\nnameserver 114.114.114.114" > /etc/resolv.conf \
    && apk update \
    && apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \
    && apk add --no-cache --virtual  .build-deps \
                $PHPIZE_DEPS \
    \
    && apk add --no-cache --virtual .pgsql-deps \
        postgresql-dev \
    \
    && apk add --no-cache --virtual .gd-deps \
                freetype-dev  libpng-dev libwebp-dev \
## install php redis ext
    && curl -LO http://pecl.php.net/get/redis-4.1.0RC1.tgz \
    && tar xzf redis-4.1.0RC1.tgz \
    && cd redis-* \
    && phpize \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && cd ../ \
    && rm -rf redis* \
## install other ext
    && pecl install swoole \
    && docker-php-ext-install -j$(nproc) pdo_pgsql mysqli pdo_mysql pgsql gd \
    && docker-php-ext-enable redis \
    && docker-php-source delete \
    && apk del .build-deps \
    ##&& apk del .gd-deps