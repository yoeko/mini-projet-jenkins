pipeline {
    environment {
        IMAGE_NAME = "static-website"
		IMAGE_TAG = "latest"
		STAGING = "lyk1719-staging"
		PRODUCTION = "lyk1719-production"
    }
    agent none
    stages {
        stage("Build image") {
            agent any
            steps {
                script {
                    sh """docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."""
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
        // stage("Clean contaier") {
        //     agent any
        //     steps {
        //         script {
        //             sh """
        //                 docker stop ${IMAGE_NAME}
        //                 docker rm ${IMAGE_NAME}
        //             """
        //         }
        //     }
        // }
    }
}