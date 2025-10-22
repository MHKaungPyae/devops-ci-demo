pipeline {
  agent any
  environment {
    DOCKER_IMAGE = "mhkaungpyae/tripnest:${env.BUILD_NUMBER}"   // <-- use your username here
  }
  stages {
    stage('Build') {
      steps { sh 'docker build -t "$DOCKER_IMAGE" .' }
    }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub',
          usernameVariable: 'DOCKERHUB_USER',
          passwordVariable: 'DOCKERHUB_TOKEN'
        )]) {
          sh '''
            echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin
            docker push "$DOCKER_IMAGE"
          '''
        }
      }
    }
    stage('Deploy') {
      steps {
        // keep your deploy logic, or temporarily skip if no K8s yet:
        sh 'echo "Skipping deploy for now"'
      }
    }
  }
}
