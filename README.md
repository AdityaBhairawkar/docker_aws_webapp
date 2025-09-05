# Docker AWS WebApp

This is a simple Flask web application that I containerized with Docker and deployed on an AWS EC2 instance using Terraform.


## Project Structure
docker\_aws\_webapp/
│── app/                # Flask application
│   └── app.py
│── terraform/          # Terraform configuration for EC2, security groups
│── Dockerfile          # Docker image build instructions
│── requirements.txt    # Python dependencies
│── setup.sh            # Script to deploy app on EC2
│── destroy.sh          # Script to remove resources


## Prerequisites
- AWS account with access keys configured
- Terraform installed
- Docker installed
- Git installed


## Steps to Run
1. **Clone the repo**
   git clone https://github.com/AdityaBhairawkar/docker_aws_webapp.git
   cd docker_aws_webapp

2. **Give permission to scripts**
   chmod +x setup.sh destroy.sh

3. **Deploy app**
   ./setup.sh

4. **Get the public IP** (from Terraform output) and open it in your browser.

5. **Destroy resources (when done)**
   ./destroy.sh
