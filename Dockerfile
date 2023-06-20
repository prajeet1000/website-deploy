# Base image
FROM php:7.4-cli
RUN docker-php-source extract \
	# do important things \
	&& docker-php-source delete

# Clone the code from GitHub repository
RUN apt install -y git
RUN git clone https://github.com/prajeet1000/website-deploy.git


COPY website-deploy/* /usr/src/myapp

