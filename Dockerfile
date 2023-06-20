# Base image
ARG PHP_VERSION
FROM php:${PHP_VERSION}-apache

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections

# Install required packages
RUN apt-get update && apt-get install -y \
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
