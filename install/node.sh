#! /usr/bin/env bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
exec -l $SHELL
nvm install v8
npm install typescript ts-node -g
