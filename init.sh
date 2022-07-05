#!/bin/bash

echo 'started init'
sudo apt-get update
sudo apt install -y docker.io
sudo apt install -y docker-compose
sudo git clone https://github.com/EndL11/cloud-demo.git && cd cloud-demo

sudo docker-compose up -d

echo 'ended init'
