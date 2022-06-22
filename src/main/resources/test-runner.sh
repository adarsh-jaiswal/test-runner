#!/bin/bash

REPO_URL=$1
SHA=$2

echo "REPO URL: "$REPO_URL
echo "SHA: "$SHA

echo "Start: Check out graphql-java repository."
git clone $REPO_URL
cd graphql-java
#git reset --hard $SHA
echo "End: Check out graphql-java repository."

echo "Start: Build graphql-java library."
#setting JAVA_HOME might not be needed when writing docker file
export JAVA_HOME=/Library/Java/JavaVirtualMachines/TwitterJDK/Contents/Home
RELEASE_VERSION=test-runner ./gradlew build
echo "End: Build graphql-java library."

echo "Start: Copy graphql-java-test-runner.jar to m2 folder."
#copy graphql-java-test-runner.jar to m2 repository
echo "End: Copy graphql-java-test-runner.jar to m2 folder."

#pull jmh-project code and build it's jar
#run the jmh jar to run all the tests and produce json result file.
