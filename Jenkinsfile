
pipeline {
   options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
  }

  environment {
    registry = "bandarijp/jenkins-test"
    registryCredential = 'cred-id-docker'
  }
  //agent any
  agent { label 'dumb-slave-name' }

//  tools { nodejs "node" }  //install nodejs plugin ,go to global tool configuration and give name for nodejs as node, check install automatically

  stages {
    stage('printing ENV variables ') {
      steps {
        sh 'env > env.txt' 
        for (String i : readFile('env.txt').split("\r?\n")) {
           println i
         }


      }
    }
    
  }
}
