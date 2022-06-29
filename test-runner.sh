#!/bin/bash

REPO_URL=$1
SHA=$2

echo "REPO URL: "$REPO_URL
echo "SHA: "$SHA

echo "Start: installing git"
apk add --no-cache git
echo "End: installing git"

echo "Start: Check out graphql-java repository."
git clone $REPO_URL
cd graphql-java
git reset --hard $SHA
echo "End: Check out graphql-java repository."

echo "Start: Build graphql-java library."
cd graphql-java/
RELEASE_VERSION=test-runner ./gradlew build
RELEASE_VERSION=test-runner-jmh ./gradlew jmhJar
echo "End: Build graphql-java library."

echo "Start: Jmh tests."
#java -jar build/libs/graphql-java-test-runner-jmh.jar -rf json
echo "End: Jmh tests."
