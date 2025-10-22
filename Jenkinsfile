pipeline {
  agent any
  environment { DOCKER_IMAGE = "yourdocker/tripnest:${env.BUILD_NUMBER}" }
  stages {
    stage('Build') { steps { sh 'docker build -t "$DOCKER_IMAGE" .' } }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub',
                         usernameVariable: 'DOCKERHUB_USER',
                         passwordVariable: 'DOCKERHUB_TOKEN')]) {
          sh '''
            docker login -u "$DOCKERHUB_USER" -p "$DOCKERHUB_TOKEN"
            docker push "$DOCKER_IMAGE"
          '''
        }
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
          sh '''
            kubectl set image deployment/web web="$DOCKER_IMAGE" --namespace default || true
            kubectl rollout status deployment/web --namespace default
          '''
        }
      }
    }
  }
}
