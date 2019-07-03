sudo -H sh -c './0-installPrerequisites.sh && 
               ./1-installBazel.sh && 
               ./2-buildAndInstallMVAPICH.sh &&
               ./3-installCUDA.sh &&
               ./4-buildAndInstallTensorFlow.sh'