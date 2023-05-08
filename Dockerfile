FROM --platform=linux/arm64 php:8.0-fpm
RUN docker-php-ext-install mysqli

# Install less for wpcli and vim for modding configs
RUN apt-get update \
    && apt-get install vim strace procps less -y

# Install wpcli because wordpressdevelop/cli does not work consistenly and is AMD only.
RUN curl --output-dir /usr/local/bin -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp-cli.phar \
    && mv /usr/local/bin/wp-cli.phar /usr/local/bin/wp

# Setup xdebug
RUN pecl install xdebug-3.1.6 \
    && docker-php-ext-enable xdebug \
    && touch /var/log/xdebug.log \
    && chgrp www-data /var/log/xdebug.log ; chmod g+w  /var/log/xdebug.log 

# Add user to run wpcli as
RUN useradd wp_php -G www-data \
    && chsh -s /bin/bash wp_php
