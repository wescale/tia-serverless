# tia-serverless

## Description

This repository contains two demos to use the serverless framework to deploy applications on AWS.

## Setup

**Prerequisites** :
* NodeJS 16 LTS
* Python 3.8

Install serverless framework :
```
$ npm ci
$ export PATH=${PATH}:${PWD}/node_modules/.bin/
$ sls --version
```

Create python venv :
```
$ python -m venv .venv
$ source .venv/bin/activate
$ python --version
```

# Deploy demo

Deploy S3 demo :
```
$ make s3-deploy
```

Deploy API demo :
```
$ make api-deploy
```
