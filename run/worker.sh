#!/usr/bin/env bash

echo "### Start shoryuken ###"

mkdir -p ./tmp/pids
# キューの初期化
bundle exec rake shoryuken:initialize_queue

bundle exec shoryuken --rails --config ./config/shoryuken.yml
