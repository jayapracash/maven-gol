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
	steps{
	build 'master'   //we are invoking pipeline named master
	//Note: if both parent and child pipelines running in same slave then the slave need to configure with no of executors value more than 1 EX: 5
/*
If pipeline is parameterised then
build job: 'myjob/master', parameters: [string(name: 'param1', value:'val1')], wait: false
or
 build job: 'pipeline1', parameters: [string(name: 'param1', value: "value1")]
*/	
}
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