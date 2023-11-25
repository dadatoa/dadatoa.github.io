#!/bin/sh
set -e

bundle install --retry 5 --jobs 20

exec "$@"
