#!make
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -euc
MAKEFLAGS += --warn-unexport defined-variables
MAKEFLAGS += --no-builtin-rules

export ENVIRONMENT ?= dev
export AWS_SDK_LOAD_CONFIG=1
export AWS_REGION=eu-west-3

node_modules/: package-lock.json
	npm ci
	touch node_modules/

.PHONY: s3-deploy
s3-deploy: node_modules/
	cd demo/01-s3/
	sls deploy --verbose --stage "$(ENVIRONMENT)"

.PHONY: api-deploy
api-deploy:
	cd demo/02-api/
	sls deploy --verbose --stage "$(ENVIRONMENT)"

.PHONY: clean
clean:
	rm -rf node_modules/
	find . -type d -name ".serverless" -exec rm -rf {} \; || true
