# CubeREST

_Super-simple REST wrapper for the [Cube:Bit](https://4tronix.co.uk/blog/?p=1770)_

## Installation

On a fresh, clean [Raspbian](https://www.raspbian.org/) install, you'll first need to follow your preferred route to getting a modern-ish Ruby (and bundler) installed (I favour [rbenv](https://github.com/rbenv/rbenv) but it takes ages; at the time of writing you can `apt install` 2.3, which should be fine for this). Then there are some handy `make` targets:

### `make apt`

* installs `nginx` and `rabbitmq-server`

### `make install`

* does `bundle install` to install the gems

### `make systemd`

* installs the `systemd` start-up script - this target relies on this all being checked-out at `/home/pi/CubeREST` - then starts the service

### `make nginx`

* symlinks the nginx virtual host into place and restarts nginx

### `make env`

Sets up the shared `.env` file with the queue name we'll use for RabbitMQ

## API

There's a single endpoint

### `/lights`

Which accepts a `PATCH` with a JSON payload like

    {
    	"layers": [
    		[
    			[[255, 0, 0], [255, 0, 0], [255, 0, 0]],
    			[[0, 255, 0], [0, 255, 0], [0, 255, 0]],
    			[[0, 0, 255], [0, 0, 255], [0, 0, 255]]
    		],		
    		[
    			[[255, 0, 0], [0, 255, 0], [0, 0, 255]],
    			[[255, 0, 0], [0, 255, 0], [0, 0, 255]],
    			[[255, 0, 0], [0, 255, 0], [0, 0, 255]]
    		],
    		[
    			[[0, 0, 255], [0, 255, 0], [255, 0, 0]],
    			[[0, 0, 255], [0, 255, 0], [255, 0, 0]],
    			[[0, 0, 255], [0, 255, 0], [255, 0, 0]]
    		]
    	]
    }

where that grid of 27 RGB colours represents the three layers of the Cube:Bit, starting at the back-left-bottom, working up to the front-right-top

## RabbitMQ

On its own, this doesn't actually turn the lights on - it pushes the data onto the RabbitMQ queue, where it gets consumed by [Queube](https://github.com/pikesley/Queube)
