//this is declarative syntax
pipeline{
agent {label "dumb-slave-name"}
	stages{
		stage("jobstarted"){


	steps{
		script{
           stage('creating python script'){
           	//    docker.image('cloudbees/java-build-tools:2.0.0').inside {

        // verify that selenium-standalone-server has been started by the Dockerfile entrypoint /opt/bin/entry_point.sh
        sh "hostnamectl"
        println "executing python script"
        // test with selenium python
        writeFile (
            file: 'remote_test.py', 
            text: 
"""#!/usr/bin/env python 

print("Hello world...!")
""")

        sh "python remote_test.py"

           }
		}
	}
}
stage('calling master branch pipeline'){
	build 'master'
}
}

    }

//this is pipeline regular syntax
/*
node ("dumb-slave-name") {
//    docker.image('cloudbees/java-build-tools:2.0.0').inside {

        // verify that selenium-standalone-server has been started by the Dockerfile entrypoint /opt/bin/entry_point.sh
        sh "hostnamectl"
        
        // test with selenium python
        writeFile (
            file: 'remote_test.py', 
            text: 
"""#!/usr/bin/env python 
print("Hello world...!")
""")

        sh "python remote_test.py"

    }
}
*/