pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "server_hello"
        REPO_1_URL = "git@github.com:leomerl/exe1_my-app.git"
        GHCR_REGISTRY = "ghcr.io"
        GHCR_IMAGE = "${GHCR_REGISTRY}/leomerl/${DOCKER_IMAGE}"
        NEXUS_REPO = "https://nexus.yourdomain.com/repository/docker-releases/"
        ECR_REGISTRY = "$(aws ecr get-login --no-include-email --region $(terraform output -raw aws_region))"
        ECR_IMAGE = "${ECR_REGISTRY}/${DOCKER_IMAGE}"
    }

    stages {
        stage('Clone Repository 1') {
            steps {
                git branch: 'main', url: "${env.REPO_1_URL}"
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }

        stage('Push to GHCR') {
            steps {
                script {
                    docker.withRegistry("https://${env.GHCR_REGISTRY}", 'github-credentials-id') {
                        docker.image("${env.DOCKER_IMAGE}").push("latest")
                    }
                }
            }
        }

        stage('Push to Nexus') {
            steps {
                script {
                    docker.withRegistry("${env.NEXUS_REPO}", 'nexus-credentials-id') {
                        docker.image("${env.DOCKER_IMAGE}").push("latest")
                    }
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region $(terraform output -raw aws_region) | docker login --username AWS --password-stdin $(terraform output -raw ecr_url)"
                    docker.image("${env.DOCKER_IMAGE}").push("latest")
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
