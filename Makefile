#!make
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -euc
MAKEFLAGS += --warn-unexport defined-variables
MAKEFLAGS += --no-builtin-rules

export ENVIRONMENT ?= dev
export AWS_SDK_LOAD_CONFIG=1
export AWS_REGION=eu-west-3


.PHONY: s3-deploy
s3-deploy:
	cd demo/01-s3/
	sls deploy --stage "$(ENVIRONMENT)"

.PHONY: api-deploy
api-deploy:
	cd demo/02-api/
	sls deploy --stage "$(ENVIRONMENT)"
