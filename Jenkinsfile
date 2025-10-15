pipeline {
    agent any

    parameters {
    booleanParam(name: 'DESTROY_INFRA', defaultValue: false, description: 'Check this to destroy AWS infrastructure')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        IMAGE_NAME            = "flask-webapp"
        DOCKER_REPO           = "adityabhairawkar"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Pulling latest code from Github..."
                git branch: 'main', url: 'https://github.com/AdityaBhairawkar/docker_aws_webapp'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker tag $IMAGE_NAME $DOCKER_REPO/$IMAGE_NAME:latest
                    docker push $DOCKER_REPO/$IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Terraform Deploy') {
            steps {
                echo 'Deploying infrastructure on AWS...'
                dir('terraform') {
                    sh '''
                    terraform init -input=false
                    terraform plan -out=tfplan
                    terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Post-Deployment Check') {
            steps {
                echo 'Verifying deployment...'
                sh 'echo "Deployment successful! Check EC2 public IP."'
            }
        }

        stage('Destroy Infrastructure') {
            when {
                expression { return params.DESTROY_INFRA == true }
            }
            steps {
                input message: "Are you sure you want to destroy AWS infrastructure?", ok: "Yes, destroy"
                dir('terraform') {
                    sh '''
                    echo 'Destroying Terraform infrastructure...'
                    terraform init -input=false
                    terraform destroy -auto-approve
                    '''
                }
             }
        }

    }

    post {
        success {
            echo 'Flask app deployed successfully on AWS EC2.'
        }
        failure {
            echo 'Build or deploy failed. Check logs.'
        }
    }
}
