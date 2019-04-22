/*
we can use the groovy pipeline script directly in jenkins job in pipeline script or from git using pipeline script from git
for this create git credentials in jenkins
and give the pipeline script name for script path in job
pipeline syntax & declarative syntax
Ref: https://jenkins.io/doc/book/pipeline/syntax/
https://medium.com/@gustavo.guss/jenkins-starting-with-pipeline-doing-a-node-js-test-72c6057b67d4 
*/
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
        sh 'env > env.txt'} 
        for (String i : readFile('env.txt').split("\r?\n")) {
           println i
         }


      }
    }
    
/* this
   is a
   multi-line comment, this deletes the docker complete data
   stage(‘Docker Purge’) {

steps {

sh ‘docker image prune -fa’

deleteDir()

}

}

    */

// this is a single line comment for jenkins pipeline which uses java and c form of comments
  }

