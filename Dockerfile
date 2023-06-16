# Base image
FROM ubuntu

# Install Git and Apache
RUN apt-get update && apt-get install -y git apache2

# Clone the code from GitHub repository
RUN git clone --no-cache https://github.com/prajeet1000/website-deploy.git

# Copy the cloned folder to the Apache web root
RUN cp -r website-deploy/* /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]




