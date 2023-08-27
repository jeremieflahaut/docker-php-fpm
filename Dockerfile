FROM php:8.2-fpm

RUN apt-get update \
    && apt-get install -y git unzip cron \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean all \
    && apt-get clean

COPY ./crons/laravel /etc/cron.d/laravel

RUN chmod 0644 /etc/cron.d/laravel-cron

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["sh", "-c", "service cron start && php-fpm"]