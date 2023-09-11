FROM php:8.2-fpm

RUN apt-get update \
    && apt-get install -y git unzip cron \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean all \
    && apt-get clean

RUN docker-php-ext-install pdo pdo_mysql exif

RUN cd /tmp && \
    git clone https://github.com/xdebug/xdebug.git && \
    cd xdebug && \
    git checkout xdebug_3_2 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install && \
    rm -rf /tmp/xdebug

RUN docker-php-ext-enable xdebug

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["sh", "-c", "service cron start && php-fpm"]
