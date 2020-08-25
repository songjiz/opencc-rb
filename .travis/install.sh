#!/bin/bash

if [ $TRAVIS_OS_NAME = 'osx' ]; then
	brew install opencc
else
  git clone https://github.com/BYVoid/OpenCC
  cd OpenCC
  git checkout ver.1.1.1
  make PREFIX=/usr/local
  sudo make install
fi
