# Docker AWS WebApp

This is a **simple Flask web application** containerized with Docker and deployed on an **AWS EC2 instance using Terraform**. The deployment and lifecycle management are automated using **Jenkins CI/CD pipeline**.

---

## Project Structure

```
docker_aws_webapp/
│── app/                  # Flask application
│   └── app.py
│── terraform/            # Terraform configuration (EC2, security groups, key pairs)
│── Dockerfile            # Docker image build instructions
│── requirements.txt      # Python dependencies
│── setup.sh              # Script to deploy app on EC2
│── destroy.sh            # Script to remove resources
│── Jenkinsfile           # CI/CD pipeline: Build, Push, Deploy, Destroy
```

---

## Prerequisites

* AWS account with Access Key & Secret Key
* Docker installed
* Terraform installed
* Git installed
* Jenkins installed with:

  * Docker CLI access
  * AWS CLI
  * Terraform

---

## Steps to Run

1. **Clone the repo**

git clone https://github.com/AdityaBhairawkar/docker_aws_webapp.git
cd docker_aws_webapp

2. **Give permission to scripts**

chmod +x setup.sh destroy.sh

3. **Deploy the app manually (optional)**

./setup.sh

4. **Access the app**

* Get the public IP from Terraform output and open it in your browser.

---

## Jenkins CI/CD Pipeline

The Jenkins pipeline automates the **full lifecycle**:

1. **Build Docker Image**
2. **Push Image to Docker Hub**
3. **Deploy Infrastructure on AWS using Terraform**
4. **Post-Deployment Verification**
5. **Destroy Infrastructure (optional, manual confirmation)**

### How to Run in Jenkins

* Go to your Jenkins job → **Build with Parameters**
* **DESTROY_INFRA** unchecked → runs build & deploy
* **DESTROY_INFRA** checked → runs destroy stage after confirmation

The pipeline ensures **safe deployment and destruction** of AWS resources while demonstrating full CI/CD automation.

---

## Destroy Resources

When done testing:

./destroy.sh

Or trigger the **Destroy stage** in Jenkins.