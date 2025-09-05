#!/bin/bash

cd terraform

echo "Initializing Terraform..."
terraform init -input=false

echo "Applying Terraform..."
terraform apply -auto-approve

echo "Infrastructure deployed!"