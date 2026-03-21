FROM alpine:3.23 AS base

SHELL ["/bin/sh", "-c"]
ENV LANG=C.UTF-8

RUN set -eux; \
    apk update \
    && apk add --no-cache \
      ca-certificates less vim \
      tzdata libatomic wget make xz git nginx \
      python3 py3-requests \
      unzip imagemagick-dev jpeg-dev libpng-dev libwebp-dev libpq-dev libzip-dev \
      composer php84-fpm php84-pdo php84-curl php84-mbstring php84-gd php84-pgsql php84-xml php84-dev php84-pear php84-pecl-imagick php84-zip php84-phar php84-iconv php84-dom php84-xmlwriter php84-simplexml php84-tokenizer php84-openssl php84-session php84-ctype php84-fileinfo php84-gmp \
    && ln -sf /usr/sbin/php-fpm84 /usr/sbin/php-fpm

COPY assets/movim.ini /etc/php/conf.d/movim.ini

RUN mkdir -p /etc/php84/conf.d /etc/php84/php-fpm.d \
    && ln -sf /etc/php/conf.d/movim.ini /etc/php84/conf.d/movim.ini \
    && rm -f /etc/php84/php-fpm.d/*.conf \
    && ln -sf /etc/php/pool.d/movim.conf /etc/php84/php-fpm.d/movim.conf
COPY assets/movim-fpm.conf /etc/php/pool.d/movim.conf

COPY assets/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN addgroup -S www-data 2>/dev/null || true \
    && adduser -S -G www-data www-data 2>/dev/null || true \
    && mkdir -p /var/www \
    && chown -R www-data:www-data /var/www \
    && mkdir -p /usr/local/share/movim \
    && chown www-data:www-data /usr/local/share/movim

USER www-data
WORKDIR /usr/local/share/movim

FROM base AS movim

COPY . /usr/local/share/movim
USER root
RUN chown -R www-data:www-data /usr/local/share/movim
USER www-data

RUN composer install \
    && mkdir -p cache log public/cache

USER root
EXPOSE 8080
ENTRYPOINT /usr/local/bin/entrypoint.sh
