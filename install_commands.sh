#!/usr/bin/env bash

#
# The contents of this file are subject to the terms of the Common Development and
# Distribution License (the License). You may not use this file except in compliance with the
# License.
#
# You can obtain a copy of the License at legal/CDDLv1.0.txt. See the License for the
# specific language governing permission and limitations under the License.
# 
# When distributing Covered Software, include this CDDL Header Notice in each file and include
# the License file at legal/CDDLv1.0.txt. If applicable, add the following below the CDDL
# Header, with the fields enclosed by brackets [] replaced by your own identifying
# information: "Portions copyright [year] [name of copyright owner]".
#
# Portions copyright 2017 Jasper Siepkes
# Portions copyright 2017 Filip Smola
#

# This script contains functions to install all the dependencies required to successfully build
# various WrenSec projects in the user's local Maven repo.

# Stop on any error we encounter.
set -e

# Installs an Maven artifact in the users local Maven repository (~/.m2/repository)
# without a POM. Only groupid, artifactid and version will be set. All dependency
# information will be lost. 
# Optionally can have classifier as 6th argument
#
# Use 'install_artifact' instead if you have a POM.
function install_artifact_plain() {
  ARTIFACT_FILE=$1
  GROUP_ID=$2
  ARTIFACT_ID=$3
  VERSION=$4
  PACKAGING=$5
  
  # Handle optional classifier
  if [ ! -z "$6" ]; then
    CLASSIFIER=$6
    mvn install:install-file -Dfile="repo/${ARTIFACT_FILE}" -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=${PACKAGING} -Dclassifier=${CLASSIFIER} -DcreateChecksum=true
  else
    mvn install:install-file -Dfile="repo/${ARTIFACT_FILE}" -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=${PACKAGING} -DcreateChecksum=true
  fi
}

# Install an artifact (usually a JAR) together with it's POM.
# Arguments:
# 1 -> Base file name
#
# Optionally the following arguments can be supplied.
# 2 -> Extension of artifact. When empty JAR is used.
# 3 -> Classifier of artifact. When empty no classifier is used.
function install_artifact() {
  BASE_FILE=$1
  
  # We force the packaging type to 'jar' because some artifacts have a packaging type of 'bundle'
  # specified in their POM. When installed as bundle in the repo Maven can't find the artifact.
  ARTIFACT_EXTENSION="jar"
  ARTIFACT_CLASSIFIER=""
  
  MVN_CMD="mvn install:install-file -DpomFile="repo/${BASE_FILE}.pom" -DcreateChecksum=true"
  
  if [ ! -z  "$2" ]; then
    ARTIFACT_EXTENSION="$2"
        
    if [ ! -z  "$3" ]; then 
      ARTIFACT_CLASSIFIER="$3"
      MVN_CMD="${MVN_CMD} -Dfile=repo/${BASE_FILE}-${ARTIFACT_CLASSIFIER}.${ARTIFACT_EXTENSION} -Dclassifier=${ARTIFACT_CLASSIFIER}"
    else 
      MVN_CMD="${MVN_CMD} -Dfile=repo/${BASE_FILE}.${ARTIFACT_EXTENSION}"
    fi
    
  else
    MVN_CMD="${MVN_CMD} -Dfile=repo/${BASE_FILE}.${ARTIFACT_EXTENSION}"
  fi
    
  MVN_CMD="${MVN_CMD} -Dpackaging=${ARTIFACT_EXTENSION}"

  ${MVN_CMD}
  
  # Install tests if present (for example 'json-resource' needs this).
  if [ -f "repo/${BASE_FILE}-tests.jar" ]; then
    mvn install:install-file -Dfile="repo/${BASE_FILE}-tests.jar" -DpomFile="repo/${BASE_FILE}.pom" -Dpackaging=jar -Dclassifier=tests -DcreateChecksum=true
  fi
  
  # Install sources if present.
  if [ -f "repo/${BASE_FILE}-sources.jar" ]; then
    mvn install:install-file -Dfile="repo/${BASE_FILE}-sources.jar" -DpomFile="repo/${BASE_FILE}.pom" -Dpackaging=jar -Dclassifier=sources -DcreateChecksum=true
  fi
}

# Installs a POM without artifact into the users local Maven repository.
function install_pom() {
  POM_FILE=$1
  
  mvn install:install-file -Dfile="repo/${POM_FILE}" -DpomFile="repo/${POM_FILE}" -DcreateChecksum=true
}
