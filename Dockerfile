# Base image
FROM ubuntu

# Install Git
RUN apt-get update && apt-get install -y git

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/website-deploy.git

# Install any dependencies required by your code
RUN apt-get install -y apache2

# Copy any additional configuration files or scripts
COPY . .

# Move the cloned folder to a specific location
RUN mv website-deploy/* /var/www/html/

# Set the working directory to the deployment location
WORKDIR /var/www/html

# Install any dependencies required by your code
RUN apt-get update && service apache2 start






