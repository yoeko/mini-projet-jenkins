pipeline {
    environment {
        IMAGE_NAME = "static-website"
		IMAGE_TAG = "latest"
        DOCKER_USER = "lyk1719"
		STAGING = "lyk1719-staging"
		PRODUCTION = "lyk1719-production"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        registry = "lyk1719/static-website"
        registryCredential = 'dockerhub'
    }
    agent none
    stages {
        stage("Build image") {
            agent any
            steps {
                script {
                    dockerImage = docker.build registry + ":${IMAGE_TAG}"
                    //sh """docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."""
                }
            }
        }
        stage("Run the container based on the built image") {
            agent any
            steps {
                script {
                    sh """
                    docker run -d --name ${IMAGE_NAME} -p 8081:80 ${IMAGE_NAME}:${IMAGE_TAG}
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
        // stage('Docker login') {
        //     steps {
        //         sh """docker login -u ${DOCKER_USER} --password ${DOCKERHUB_CREDENTIALS} """
        //     }
        // }
        // stage('Push') {
        //     steps {
        //         script {
        //             //sh """docker push ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG}"""
        //             docker.withRegistry( '', registryCredential ) 
        //             dockerImage.push()
        //         }
        //     }
        // }
    }
    // post {
    //     always {
    //         sh 'docker logout'
    //     }
    // }
}