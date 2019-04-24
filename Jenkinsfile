pipeline{
node ("dumb-slave-name") {
	stages{
		stage("jobstarted"){


	steps{
		script{
           stage('main'){
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
	}
}
}

    }

}