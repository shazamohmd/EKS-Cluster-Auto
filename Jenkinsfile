pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // Change this to your desired region
        ECR_REPO_NAME = 'java/hello-world'         // Your ECR repository name
        IMAGE_TAG = "v${BUILD_NUMBER}"     // Using Jenkins build number for image tag
    }
    
    stages {
        stage('Build and Push to ECR') {
            steps {
                script {
                  withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CRED']]) {
                    
                    // Set ECR repository URL
                    def ECR_REPO_URL = "public.ecr.aws/w1v4n0n8/java/hello-world"
                    
                    // ECR login
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}"
                    
                    dir('Application') {
                        // Build Docker image
                        sh "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
                        
                        // Tag image for ECR
                        sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${ECR_REPO_URL}:${IMAGE_TAG}"
                        sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${ECR_REPO_URL}:latest"
                        
                        // Push image to ECR
                        sh "docker push ${ECR_REPO_URL}:${IMAGE_TAG}"
                        sh "docker push ${ECR_REPO_URL}:latest"
                        
                       
                    }
                  }
                }
            }
        }
   
        // stage('Building the infrastructure') {
        //     steps {
        //           withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CRED']]) { 
        //             sh 'terraform -chdir=terraform/ init -reconfigure'
        //             sh "terraform -chdir=terraform/ apply -auto-approve"
        //         }
        //     }
        // }
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