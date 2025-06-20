pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // Change this to your desired region
        ECR_REPO_NAME = 'eks-app'         // Your ECR repository name
        IMAGE_TAG = "v${BUILD_NUMBER}"     // Using Jenkins build number for image tag
    }
    
    stages {
        // stage('Build and Push to ECR') {
        //     steps {
        //         script {
        //             // Get AWS account ID
        //             def AWS_ACCOUNT_ID = sh(
        //                 script: "aws sts get-caller-identity --query 'Account' --output text",
        //                 returnStdout: true
        //             ).trim()
                    
        //             // Set ECR repository URL
        //             def ECR_REPO_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPO_NAME}"
                    
        //             // ECR login
        //             sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}"
                    
        //             dir('Application') {
        //                 // Build Docker image
        //                 sh "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
                        
        //                 // Tag image for ECR
        //                 sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${ECR_REPO_URL}:${IMAGE_TAG}"
        //                 sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${ECR_REPO_URL}:latest"
                        
        //                 // Push image to ECR
        //                 sh "docker push ${ECR_REPO_URL}:${IMAGE_TAG}"
        //                 sh "docker push ${ECR_REPO_URL}:latest"
                        
        //                 // Clean up local images
        //                 sh "docker rmi ${ECR_REPO_NAME}:${IMAGE_TAG}"
        //                 sh "docker rmi ${ECR_REPO_URL}:${IMAGE_TAG}"
        //                 sh "docker rmi ${ECR_REPO_URL}:latest"
        //             }
        //         }
        //     }
        // }
   
        stage('Building the infrastructure') {
            steps {
                withAWS(credentials: 'AWS_CRED') { 
                    sh 'terraform -chdir=terraform/ init -reconfigure'
                    sh "terraform -chdir=terraform/ apply -auto-approve"
                }
            }
        }
    }
    
    post {
        success {
            echo "Successfully built and pushed image to ECR"
        }
        failure {
            echo "Failed to build and push image to ECR"
        }
    }
}