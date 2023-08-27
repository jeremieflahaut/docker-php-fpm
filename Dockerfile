FROM php:8.2-fpm

RUN apt-get update \
    && apt-get install -y git unzip \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean all \
    && apt-get clean

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]