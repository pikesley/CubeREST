apt:
	sudo apt-get install -y nginx rabbitmq-server

install:
	bundle install

.PHONY: systemd
systemd:
	sudo systemctl enable /home/pi/CubeREST/etc/systemd/cuberest.service
	sudo service cuberest restart

nginx:
	sudo rm /etc/nginx/sites-enabled/default
	sudo ln -s /home/pi/CubeREST/etc/nginx/default /etc/nginx/sites-enabled
	sudo service nginx restart

env:
	@echo QUEUE=queube > /home/pi/.env
