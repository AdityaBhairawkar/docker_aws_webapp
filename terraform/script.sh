#!/bin/bash

sudo yum update -y

sudo yum install -y docker

sudo systemctl enable docker

sudo systemctl start docker

sudo docker run -d -p 80:5000 adityabhairawkar/my-flask-app:latest