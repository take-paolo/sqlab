#!/bin/sh
set -e

# 自分のアプリに合わせて必要なコマンドを修正してください
bin/rails db:migrate
bin/rails samples:handle:data_models
bin/rails db:seed

rm -f tmp/pids/server.pid && bin/rails s
