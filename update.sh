#!/bin/bash

patch () {
  apt-get update -y
  apt-get upgrade -y
  apt-get autoremove -y
  apt-get --with-new-pkgs upgrade -y
}

patch

