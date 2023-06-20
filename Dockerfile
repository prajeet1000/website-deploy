# Base image
FROM ubuntu

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections


# Install necessary packages
RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php php-mysql

# Copy website files to the Apache web root
COPY website-deploy/ /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]
