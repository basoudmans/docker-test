# Docker test image

An image running [ubuntu/18.04](https://hub.docker.com/_/ubuntu/) Linux and [Apache](https://httpd.apache.org/).

## Requirements



## Usage

### Initial Installation

First create a database on your database server, and make sure the container has access to the database, then run a temporary container.

	docker run -it --rm --name Docker_Test -p 80:80 

Please NOTE that there is no database configuration here, this will enable the install process.

When you are done, exit the container (CTRL/CMD-c) and configure the permanent running container.

### Permanent installation

	docker run --restart=always name Docker_Test -d -p 80:80 \
		

Please NOTE that the volume is optional. Only necessary when you have special configuration settings.

## License

MIT / BSD

## Author Information

[Bas Oudmans](http://www.oudmans.nl/)
