#!/bin/bash

set -e

docker-compose run --rm pg psql -h pg -U postgres 