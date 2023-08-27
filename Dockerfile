FROM php:8.2-fpm

RUN apt-get update && apt-get update -y

RUN apt-get install -y git unzip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]