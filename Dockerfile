# Base image
FROM ubuntu

# Install necessary packages
RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php php-mysql

# Copy website files to the Apache web root

COPY website-deploy/ /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]
