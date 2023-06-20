# Base image
FROM ubuntu

# Set the geographic area and time zone
RUN ln -fs /usr/share/zoneinfo/$(tzselect) /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


# Install necessary packages
RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php php-mysql

# Copy website files to the Apache web root

COPY website-deploy/ /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]
