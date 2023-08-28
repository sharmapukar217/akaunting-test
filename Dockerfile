FROM php:fpm-alpine

LABEL maintainer="Pukar Sharma <sharmapukar217@gmail.com>"

# setup app
WORKDIR /var/www/html

# install required dependencies
RUN apk --no-cache add python3 nodejs npm yarn nginx curl make g++ \
    oniguruma-dev libxml2-dev libpq-dev libpng-dev icu-dev libzip-dev

# install nginx package
RUN docker-php-ext-install -j$(nproc) mbstring xml gd bcmath intl zip \
    pgsql pdo_pgsql

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# copy src
COPY . .

# install composer deps
RUN COMPOSER_ALLOW_SUPERUSER=1 && composer install

