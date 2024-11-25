.ONESHELL:
# Will include both `.env` and '.env-twine' if they exists (-)
-include .env
-include .env-twine
export

.DEFAULT_GOAL := help

SHELL = /bin/bash

help:   ## Show Makefile documentation.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

start:
	docker run -v ${PWD}:/app -p 9501:9501 -it --entrypoint /bin/sh hyperf/hyperf:8.0-alpine-v3.13-swoole

create:
	composer create-project hyperf/hyperf-skeleton app

create-migration:
	docker container exec -it hyperf-skeleton php bin/hyperf.php gen:migration create_users_table

run:
	php bin/hyperf.php start

install-watcher:
	composer require hyperf/watcher --dev
	php bin/hyperf.php vendor:publish hyperf/watcher

run-watch:
	php bin/hyperf.php server:watch

run-migration:
	docker container exec -it hyperf-skeleton php bin/hyperf.php migrate
