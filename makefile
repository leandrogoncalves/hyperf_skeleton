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

