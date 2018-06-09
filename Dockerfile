FROM ubuntu:16.04

LABEL maintainer="vic@minustime.com"

# Install Apache & PHP
ENV PHP_VERSION 7.2
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    	ca-certificates \
        apache2 \
        apache2-utils \
        php${PHP_VERSION} \
   	    php-xml \
   	    php-mbstring \
   	    php-curl \
        libapache2-mod-php${PHP_VERSION} \
        curl \
        wget \
        git \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install Node and NPM 
ENV NODE_VERSION v8.11.2
RUN curl -SLO "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz" \
	&& tar -xzf "node-${NODE_VERSION}-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-${NODE_VERSION}-linux-x64.tar.gz"

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Copy the project's vhost
COPY docker/apache/vhost.conf /etc/apache2/sites-enabled/000-default.conf

# Copy the project's files
COPY www /var/www

# Forward logs to docker log collector, enable Apache mods
RUN a2enmod rewrite \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80/tcp

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
