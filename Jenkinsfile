pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'prod',
                    url: 'https://github.com/akshataujawane/aws-cicd-pipeline-project.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t shopsphere-app .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker rm -f shopsphere-container || true'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 80:80 --name shopsphere-container shopsphere-app'
            }
        }

    }
}
