
node {
  stage 'checkout'
  checkout scm

  imageName = 'infra/jenkins-pipeline'
  stage 'build'
  dir('image') {
    docker.build(imageName)
    stage 'push'

    docker.withRegistry(env.DOCKER_REG+'/infra', env.DOCKER_REG_CRED_ID) {
      docker.image(imageName).push('latest')
    }
  }
}

