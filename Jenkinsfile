pipeline {
    environment {
        IMAGE_NAME = "static-website"
		IMAGE_TAG = "latest"
        DOCKER_USER = "lyk1719"
		STAGING = "lyk1719-staging"
		PRODUCTION = "lyk1719-production"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    agent none
    stages {
        stage("Build image") {
            agent any
            steps {
                script {
                    sh """docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."""
                }
            }
        }
        stage("Run the container based on the built image") {
            agent any
            steps {
                script {
                    sh """
                    docker run -d --name ${IMAGE_NAME} -p 8081:80 ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 5
                    """
                }
            }
        }
        stage("Test image") {
            agent any
            steps {
                script {
                    sh """
                        curl http://localhost:8081 | grep -q 'Dimension'
                    """
                }
            }
        }
        stage("Clean contaier") {
            agent any
            steps {
                script {
                    sh """
                        docker stop ${IMAGE_NAME}
                        docker rm ${IMAGE_NAME}
                    """
                }
            }
        }
        stage('Docker login') {
            agent any
            steps {
                sh """echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"""
            }
        }
        stage('Push') {
            agent any
            steps {
                script {
                    sh """docker push ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}"""
                }
            }
        }
        stage('Logout') {
            agent any
            steps {
                script {
                    sh """docker logout"""
                }
            }
        }
    }
    post {
        success {
            slackSend (color: '#00FF00', message: "Jules - SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend (color: '#FF0000', message: "Jules - FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}