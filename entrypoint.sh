#!/bin/sh
set -e

bundle install

exec "$@"
