#!/bin/bash

if [ $TRAVIS_OS_NAME = 'linux' ]; then
  git clone https://github.com/BYVoid/OpenCC
  cd OpenCC
  git checkout ver.1.1.2
  make PREFIX=/usr/local
  sudo make install
fi
