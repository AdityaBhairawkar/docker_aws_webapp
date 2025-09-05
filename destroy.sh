#!/bin/bash

cd terraform

echo "Destroying Terraform resources..."
terraform destroy -auto-approve

echo "Infrastructure destroyed!"