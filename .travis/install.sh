#!/bin/bash

if [ $TRAVIS_OS_NAME = 'osx' ]; then
	brew install opencc
else
	sudo apt install -y libopencc-dev
fi
