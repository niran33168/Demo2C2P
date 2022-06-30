def runRobot(testsuite){
    dir('C:\\Users\\admin\\.jenkins\\workspace\\Jenkins\\payment2c2p') {
		bat "python -m robot -v ENV:${params.Env} --nostatusrc -d C:/Log\\%date:~-4,4%%date:~-10,2%%date:~-7,2% --timestampoutputs TestScript\\${testsuite}.robot"
		
    }
}

pipeline {
    agent any
    parameters {
        choice(name: 'Env', choices: ['sit', 'uat'])
    }
    stages {
		stage('Checkout') {
            steps {
				checkout([$class: 'GitSCM', branches: [[name: '*/develop']], extensions: [], userRemoteConfigs: [[credentialsId: 'bfdfc9c2-0958-43cf-a74e-1e5b52adf929', url: 'https://github.com/niran33168/Demo2C2P.git']]])
            }
        }		
		stage('Run') {
			steps {
			    runRobot ('header')
				runRobot ('validate_Cardtokenization')
				runRobot ('validate_Payment')
			}
		}
		stage('Publish results') {
		steps {
			script {
			step([
					$class              : 'RobotPublisher',
					outputPath          : 'C:/Log',
					outputFileName      : "**/*.xml",
					reportFileName      : '**/*.html',
					logFileName         : '**/*.html',
					disableArchiveOutput: false,
					passThreshold       : 0,
					unstableThreshold   : 0,
					otherFiles          : "*/*.png,*/*.jpg",
				])
				}
			}
		}
    }
}