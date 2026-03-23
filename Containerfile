FROM alpine:3.23 AS base

SHELL ["/bin/sh", "-c"]
ENV LANG=C.UTF-8

RUN set -eux; \
    apk update \
    && apk add --no-cache \
      ca-certificates less grep bash vim \
      tzdata libatomic wget curl make xz git nginx \
      unzip imagemagick-dev jpeg-dev libpng-dev libwebp-dev libpq-dev libzip-dev \
      composer php84-fpm php84-pdo php84-pdo_pgsql php84-opcache php84-curl php84-mbstring php84-gd php84-pgsql php84-xml php84-dev php84-pear php84-pecl-imagick php84-zip php84-phar php84-iconv php84-dom php84-xmlwriter php84-simplexml php84-tokenizer php84-openssl php84-session php84-ctype php84-fileinfo php84-gmp \
    && ln -sf /usr/sbin/php-fpm84 /usr/sbin/php-fpm

COPY assets/movim.ini /etc/php/conf.d/movim.ini

RUN mkdir -p /etc/php84/conf.d /etc/php84/php-fpm.d \
    && ln -sf /etc/php/conf.d/movim.ini /etc/php84/conf.d/movim.ini \
    && rm -f /etc/php84/php-fpm.d/*.conf \
    && ln -sf /etc/php/pool.d/movim.conf /etc/php84/php-fpm.d/movim.conf
COPY assets/movim-fpm.conf /etc/php/pool.d/movim.conf

COPY assets/entrypoint.sh usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY assets/download-streamlinehq-svg.bash assets/replace-material-with-streamlinehq.bash assets/streamlinehq-replace-map.csv /scripts/
RUN chmod +x /scripts/download-streamlinehq-svg.bash /scripts/replace-material-with-streamlinehq.bash

RUN addgroup -S www-data 2>/dev/null || true \
    && adduser -S -G www-data www-data 2>/dev/null || true \
    && mkdir -p /var/www \
    && chown -R www-data:www-data /var/www \
    && mkdir -p /usr/local/share/movim \
    && chown www-data:www-data /usr/local/share/movim

USER www-data
WORKDIR /usr/local/share/movim

COPY ./composer.json ./composer.lock /usr/local/share/movim/
RUN composer install --no-cache

FROM base AS movim

ARG STREAMLINEHQ_API_KEY
ENV STREAMLINEHQ_API_KEY=$STREAMLINEHQ_API_KEY

COPY . /usr/local/share/movim
USER root
RUN chown -R www-data:www-data /usr/local/share/movim \
    && mkdir -p /tmp \
    && chmod 1777 /tmp
USER www-data

RUN mkdir -p cache log public/cache \
    && rm -rf assets/

USER root
EXPOSE 8080
ENTRYPOINT /usr/local/bin/entrypoint.sh
