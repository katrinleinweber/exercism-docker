
IMG_PREFIX=unused
PROJECT=exercism

all: website website/server_identity run

website:
	git clone --origin upstream --branch master git@github.com:exercism/website.git

website/server_identity: website
	echo "host" > website/server_identity

build: website
	docker build -t $(IMG_PREFIX)/$(PROJECT)_rails .

push:
	docker push $(IMG_PREFIX)/$(PROJECT)_rails

init:
	docker-compose -p $(PROJECT) exec rails bin/rails exercism:setup

migrate:
	docker-compose -p $(PROJECT) exec rails bin/rails db:migrate

run:
	docker-compose -p $(PROJECT) up

bash:
	docker-compose -p $(PROJECT) exec rails bash

test:
	docker-compose -p $(PROJECT) exec rails bin/rails test

clean:
	docker-compose -p $(PROJECT) down && docker rmi $(PROJECT)_rails

.PHONY: all setup build init run test clean
