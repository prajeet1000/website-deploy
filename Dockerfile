# Base image
FROM php:7.4-cli

# Install Git
RUN apt-get update && apt-get install -y git

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/website-deploy.git /usr/src/myapp

# Continue with your remaining instructions, if any

