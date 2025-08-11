#!/bin/bash
sudo apt-get update -y

sudo apt-get install docker.io -y
sudo systemctl enable --now docker
sudo systemctl start docker

sudo docker run -d --name backend-app -p 80:80 diogolpievan/test-dreamsquad-backend:latest

