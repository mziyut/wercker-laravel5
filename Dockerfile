FROM php:8.0.5-cli

# Update repo
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libbz2-dev \
        libcurl3 \
        libcurl3-dev \
        php-pear \
        phpunit \
        curl \
        git \
        sqlite \
        php5-mysql \
        php5-sqlite \
        php5-curl \
        php5-mcrypt \
    && docker-php-ext-install iconv mcrypt pdo_mysql curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install \
    zip \
    bz2 \
    iconv \
    mcrypt \
    mbstring \
    pdo_mysql

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.3.0

# switch defulat shell.
RUN rm /bin/sh \
	&& ln -s /bin/bash /bin/sh

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

CMD ["php"]
