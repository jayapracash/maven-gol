
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
    stage('Cloning Git') {
      steps {
        git 'https://github.com/jayapracash/maven-gol.git'
      }
    }
    stage ('Build MavenApp'){
    
       steps{
           sh 'pwd'
           sh 'mvn install'
       }
    }
    stage('Test mavneapp'){
      steps{
        dir ('gameoflife-web') {
        sh 'pwd'
        sh 'mvn jetty:run >/dev/null 2>&1 &'
        sh 'ls'
      }
      }
    }
    stage('archieving buildedapp'){
    steps{
    archiveArtifacts 'gameoflife-web/target/gameoflife.war'
    }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }


    stage('Deploy Image') {
      steps{

        script {
          docker.withRegistry( '', registryCredential ) {
           dockerImage.push()
            println "$registry:$BUILD_NUMBER"
      docker.image("$registry:$BUILD_NUMBER").inside{
        stage("commandrun"){sh "curl localhost:9090/gameoflife/"}//sh 'wget "http://localhost:9090/gameoflife/" -O /dev/null'
    }
        }
      }
      }
    
    }
   stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        }
      }
     
  }
    
     
    
}