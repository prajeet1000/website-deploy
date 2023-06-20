version: "2"

services:

  web1804-php7:
    build:
      context: .
      dockerfile: ./1804/Dockerfile
      args:
        - PHP_VERSION=7.4
    environment:
      - MYSQL_ADMIN_PASS=prajeetkumar
    ports:
      - "3000:80"
      - "3001:3306"
    tmpfs:
      - /var/lib/mysql

  web1804-php8:
    build:
      context: .
      dockerfile: ./1804/Dockerfile
      args:
        - PHP_VERSION=8.0
    environment:
      - MYSQL_ADMIN_PASS=prajeet
    ports:
      - "3020:80"
      - "3021:3306"
    tmpfs:
      - /var/lib/mysql

  web2004-php7:
    build:
      context: .
      dockerfile: ./2004/Dockerfile
      args:
        - PHP_VERSION=7.4
    environment:
      - MYSQL_ADMIN_PASS=prajeetkumar
    ports:
      - "3030:80"
      - "3031:3306"
    tmpfs:
      - /var/lib/mysql

  web2004-php8:
    build:
      context: .
      dockerfile: ./2004/Dockerfile
      args:
        - PHP_VERSION=8.0
    environment:
      - MYSQL_ADMIN_PASS=prajeetkumar
    ports:
      - "3040:80"
      - "3041:3306"
    tmpfs:
      - /var/lib/mysql


# Base image
FROM ubuntu:20.04

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections

# Install required packages
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    php libapache2-mod-php php-mysql \
    git

# Set MySQL configuration option to avoid deprecated warnings
RUN echo "[mysqld]" >> /etc/mysql/my.cnf \
    && echo "default_authentication_plugin=mysql_native_password" >> /etc/mysql/my.cnf

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/website-deploy.git
RUN cp -r website-deploy/* /var/www/html/

# Set permissions for Apache web root
RUN chmod -R 755 /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /dev/null
