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

# This script installs all the dependencies required to successfully build
# Wren:IDM 5.0.0 in the user's local Maven repo.

# Stop on any error we encounter.
set -e

# Installs an Maven artifact in the users local Maven repository (~/.m2/repository)
# without a POM. Only groupid, artifactid and version will be set. All dependency
# information will be lost. 
#
# Use 'install_artifact' instead if you have a POM.
function install_artifact_plain() {
  ARTIFACT_FILE=$1
  GROUP_ID=$2
  ARTIFACT_ID=$3
  VERSION=$4
  PACKAGING=$5
  
  mvn install:install-file -Dfile="repo/${ARTIFACT_FILE}" -DgroupId=${GROUP_ID} -DartifactId=${ARTIFACT_ID} -Dversion=${VERSION} -Dpackaging=${PACKAGING} -DcreateChecksum=true
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

# Various
install_artifact_plain "org/forgerock/cddl-license/1.0.0/cddl-license-1.0.0.txt" "org.forgerock" "cddl-license" "1.0.0" "txt"

# POM files
install_pom "org/forgerock/commons/commons-parent/21.0.0-alpha-23/commons-parent-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/commons-bom/21.0.0-alpha-12/commons-bom-21.0.0-alpha-12.pom"
install_pom "org/forgerock/commons/commons-bom/21.0.0-alpha-23/commons-bom-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/commons-bom/21.0.0-alpha-17/commons-bom-21.0.0-alpha-17.pom"
install_pom "org/forgerock/forgerock-parent/2.0.4/forgerock-parent-2.0.4.pom"
install_pom "org/forgerock/forgerock-parent/2.0.10/forgerock-parent-2.0.10.pom"
install_pom "org/forgerock/forgerock-parent/2.0.3/forgerock-parent-2.0.3.pom"
install_pom "org/forgerock/forgerock-parent/1.2.1/forgerock-parent-1.2.1.pom"
install_pom "org/forgerock/forgerock-parent/1.2.9/forgerock-parent-1.2.9.pom"
install_pom "org/forgerock/forgerock-parent/2.0.7/forgerock-parent-2.0.7.pom"
install_pom "org/forgerock/forgerock-parent/2.0.2/forgerock-parent-2.0.2.pom"
install_pom "org/forgerock/forgerock-parent/1.2.0/forgerock-parent-1.2.0.pom"
install_pom "org/forgerock/openicf/framework/framework/1.5.2.0-SNAPSHOT/framework-1.5.2.0-SNAPSHOT.pom"
install_pom "org/forgerock/openicf/framework/framework/1.5.2.0-SNAPSHOT/framework-1.5.2.0-20160918.142905-6.pom"
install_pom "org/forgerock/opendj/opendj-project/2.6.10/opendj-project-2.6.10.pom"
install_pom "org/forgerock/commons/forgerock-script/4.2.0/forgerock-script-4.2.0.pom"
install_pom "org/forgerock/commons/forgerock-rest/21.0.0-alpha-23/forgerock-rest-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/forgerock-launcher/2.0.4/forgerock-launcher-2.0.4.pom"
install_pom "org/forgerock/commons/forgerock-authn-filter/21.0.0-alpha-23/forgerock-authn-filter-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/forgerock-audit/21.0.0-alpha-23/forgerock-audit-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/forgerock-jaspi-modules/21.0.0-alpha-23/forgerock-jaspi-modules-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/forgerock-selfservice/21.0.0-alpha-23/forgerock-selfservice-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/json-crypto/21.0.0-alpha-23/json-crypto-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/i18n-framework/1.4.2/i18n-framework-1.4.2.pom"
install_pom "org/forgerock/commons/i18n-framework/1.4.1/i18n-framework-1.4.1.pom"
install_pom "org/forgerock/commons/guava/forgerock-guava/18.0.4/forgerock-guava-18.0.4.pom"
install_pom "org/forgerock/commons/forgerock-utilities/21.0.0-alpha-23/forgerock-utilities-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/json-schema/21.0.0-alpha-23/json-schema-21.0.0-alpha-23.pom"
install_pom "org/forgerock/http/forgerock-http-framework-parent/21.0.0-alpha-23/forgerock-http-framework-parent-21.0.0-alpha-23.pom"
install_pom "org/forgerock/commons/ui/forgerock-ui/15.2.4/forgerock-ui-15.2.4.pom"
install_pom "org/forgerock/commons/forgerock-auth-filters/21.0.0-alpha-23/forgerock-auth-filters-21.0.0-alpha-23.pom"

# JAR files
install_artifact "org/forgerock/openicf/connectors/ldap-connector/1.4.3.0/ldap-connector-1.4.3.0"
install_artifact "org/forgerock/openicf/connectors/xml-connector/1.1.0.3/xml-connector-1.1.0.3"
install_artifact "org/forgerock/openicf/connectors/kerberos-connector/1.4.0.0/kerberos-connector-1.4.0.0"
install_artifact "org/forgerock/openicf/connectors/ssh-connector/1.4.0.0/ssh-connector-1.4.0.0"
install_artifact "org/forgerock/openicf/connectors/csvfile-connector/1.5.1.4/csvfile-connector-1.5.1.4"
install_artifact "org/forgerock/openicf/connectors/databasetable-connector/1.1.0.2/databasetable-connector-1.1.0.2"
install_artifact "org/forgerock/openicf/connectors/groovy-connector/1.4.2.1/groovy-connector-1.4.2.1"
install_artifact "org/forgerock/openicf/framework/connector-framework-server/1.5.2.0-SNAPSHOT/connector-framework-server-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-framework-server/1.5.2.0-SNAPSHOT/connector-framework-server-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/connector-framework-rpc/1.5.2.0-SNAPSHOT/connector-framework-rpc-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-framework-rpc/1.5.2.0-SNAPSHOT/connector-framework-rpc-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/connector-framework-protobuf/1.5.2.0-SNAPSHOT/connector-framework-protobuf-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/connector-framework-protobuf/1.5.2.0-SNAPSHOT/connector-framework-protobuf-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-framework-internal/1.5.2.0-SNAPSHOT/connector-framework-internal-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/connector-framework-internal/1.5.2.0-SNAPSHOT/connector-framework-internal-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-test-common/1.5.2.0-SNAPSHOT/connector-test-common-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-test-common/1.5.2.0-SNAPSHOT/connector-test-common-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/icfl-over-slf4j/1.5.2.0-SNAPSHOT/icfl-over-slf4j-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/icfl-over-slf4j/1.5.2.0-SNAPSHOT/icfl-over-slf4j-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/openicf/framework/connector-framework/1.5.2.0-SNAPSHOT/connector-framework-1.5.2.0-SNAPSHOT"
install_artifact "org/forgerock/openicf/framework/connector-framework/1.5.2.0-SNAPSHOT/connector-framework-1.5.2.0-20160918.142905-6"
install_artifact "org/forgerock/opendj/opendj-ldap-sdk/2.6.10/opendj-ldap-sdk-2.6.10"
install_artifact "org/forgerock/commons/json-resource/21.0.0-alpha-23/json-resource-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-selfservice-stages/21.0.0-alpha-23/forgerock-selfservice-stages-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-selfservice-json/21.0.0-alpha-23/forgerock-selfservice-json-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-handler-syslog/21.0.0-alpha-23/forgerock-audit-handler-syslog-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-handler-jms/21.0.0-alpha-23/forgerock-audit-handler-jms-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/json-resource-http/21.0.0-alpha-23/json-resource-http-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-jaspi-jwt-session-module/21.0.0-alpha-23/forgerock-jaspi-jwt-session-module-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/script-groovy/4.2.0/script-groovy-4.2.0"
install_artifact "org/forgerock/commons/i18n-slf4j/1.4.2/i18n-slf4j-1.4.2"
install_artifact "org/forgerock/commons/forgerock-audit-handler-splunk/21.0.0-alpha-23/forgerock-audit-handler-splunk-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/api-descriptor/21.0.0-alpha-23/api-descriptor-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-jaspi-openid-connect-module/21.0.0-alpha-23/forgerock-jaspi-openid-connect-module-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-handler-elasticsearch/21.0.0-alpha-23/forgerock-audit-handler-elasticsearch-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-jaspi-runtime/21.0.0-alpha-23/forgerock-jaspi-runtime-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/i18n-core/1.4.2/i18n-core-1.4.2"
install_artifact "org/forgerock/commons/script-common/4.2.0/script-common-4.2.0"
install_artifact "org/forgerock/commons/forgerock-audit-json/21.0.0-alpha-23/forgerock-audit-json-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/guava/forgerock-guava-math/18.0.4/forgerock-guava-math-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-io/18.0.4/forgerock-guava-io-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-base/18.0.4/forgerock-guava-base-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-cache/18.0.4/forgerock-guava-cache-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-collect/18.0.4/forgerock-guava-collect-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-hash/18.0.4/forgerock-guava-hash-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-net/18.0.4/forgerock-guava-net-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-annotations/18.0.4/forgerock-guava-annotations-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-escape/18.0.4/forgerock-guava-escape-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-primitives/18.0.4/forgerock-guava-primitives-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-concurrent/18.0.4/forgerock-guava-concurrent-18.0.4"
install_artifact "org/forgerock/commons/forgerock-test-utils/21.0.0-alpha-23/forgerock-test-utils-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-selfservice-core/21.0.0-alpha-23/forgerock-selfservice-core-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-handler-json/21.0.0-alpha-23/forgerock-audit-handler-json-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/json-crypto-core/21.0.0-alpha-23/json-crypto-core-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/script-javascript/4.2.0/script-javascript-4.2.0"
install_artifact "org/forgerock/commons/launcher/2.0.4/launcher-2.0.4"
install_artifact "org/forgerock/commons/forgerock-jaspi-openam-session-module/21.0.0-alpha-23/forgerock-jaspi-openam-session-module-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/json-web-token/21.0.0-alpha-23/json-web-token-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/json-schema-core/21.0.0-alpha-23/json-schema-core-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-core/21.0.0-alpha-23/forgerock-audit-core-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/security/21.0.0-alpha-23/security-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-jaspi-iwa-module/21.0.0-alpha-23/forgerock-jaspi-iwa-module-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-audit-handler-csv/21.0.0-alpha-23/forgerock-audit-handler-csv-21.0.0-alpha-23"
install_artifact "org/forgerock/commons/forgerock-util/21.0.0-alpha-23/forgerock-util-21.0.0-alpha-23"
install_artifact "org/forgerock/http/chf-client-apache-async/21.0.0-alpha-23/chf-client-apache-async-21.0.0-alpha-23"
install_artifact "org/forgerock/http/chf-http-servlet/21.0.0-alpha-23/chf-http-servlet-21.0.0-alpha-23"
install_artifact "org/forgerock/http/chf-client-apache-common/21.0.0-alpha-23/chf-client-apache-common-21.0.0-alpha-23"
install_artifact "org/forgerock/http/chf-client-apache-sync/21.0.0-alpha-23/chf-client-apache-sync-21.0.0-alpha-23"
install_artifact "org/forgerock/http/chf-http-core/21.0.0-alpha-23/chf-http-core-21.0.0-alpha-23"
install_artifact "org/forgerock/forgerock-build-tools/1.0.4/forgerock-build-tools-1.0.4"
install_artifact "org/postgresql/postgresql-fr-osgi/9.3-1101-jdbc41/postgresql-fr-osgi-9.3-1101-jdbc41"
install_artifact "org/forgerock/commons/i18n-maven-plugin/1.4.1/i18n-maven-plugin-1.4.1"

# CSS files
install_artifact "org/forgerock/commons/ui/libs/fontawesome-iconpicker/1.0.0/fontawesome-iconpicker-1.0.0" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/qunit/1.15.0/qunit-1.15.0" "css"
install_artifact "org/forgerock/commons/ui/libs/bootstrap-datetimepicker/4.14.30/bootstrap-datetimepicker-4.14.30" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-paginator.min/0.3.5/backgrid-paginator.min-0.3.5" "css"
install_artifact "org/forgerock/commons/ui/libs/titatoggle/1.2.6/titatoggle-1.2.6" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-filter.min/0.3.5/backgrid-filter.min-0.3.5" "css"
install_artifact "org/forgerock/commons/ui/libs/dragula/3.6.7/dragula-3.6.7" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/bootstrap-dialog/1.34.4/bootstrap-dialog-1.34.4" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/xdate/1.2.6/titatoggle-1.2.6" "css" "min"
install_artifact "org/forgerock/commons/ui/libs/selectize/0.12.1/selectize-0.12.1" "css" "bootstrap3"
install_artifact "org/forgerock/commons/ui/libs/bootstrap/3.3.5/bootstrap-3.3.5" "css" "custom"
install_artifact "org/forgerock/commons/ui/libs/backgrid-filter/0.3.5/backgrid-filter.min-0.3.5" "css"

# Js files
install_artifact "org/forgerock/commons/ui/libs/sinon/1.15.4/sinon-1.15.4" "js"
install_artifact "org/forgerock/commons/ui/libs/bootstrap-tabdrop/1.0/bootstrap-tabdrop-1.0" "js"
install_artifact "org/forgerock/commons/ui/libs/qunit/1.15.0/qunit-1.15.0" "js"
install_artifact "org/forgerock/commons/ui/libs/bootstrap/3.3.5/bootstrap-3.3.5" "js" "custom"
install_artifact "org/forgerock/commons/ui/libs/form2js/2.0-769718a/form2js-2.0-769718a" "js"
install_artifact "org/forgerock/commons/ui/libs/less/1.5.1/less-1.5.1" "js" "rhino"
install_artifact "org/forgerock/commons/ui/libs/handlebars/4.0.5/handlebars-4.0.5" "js"
install_artifact "org/forgerock/commons/ui/libs/jquery.placeholder/2.0.8/jquery.placeholder-2.0.8" "js"
install_artifact "org/forgerock/commons/ui/libs/js2form/2.0-769718a/js2form-2.0-769718a" "js"
install_artifact "org/forgerock/commons/ui/libs/jquery-cron/f831f2/jquery-cron-f831f2" "js"
install_artifact "org/forgerock/commons/ui/libs/r/2.1.10/r-2.1.10" "js"

# Minimised Js files
install_artifact "org/forgerock/commons/ui/libs/backgrid.min/0.3.5/backgrid.min-0.3.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/lodash/2.4.1/lodash-2.4.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/lodash/3.10.1/lodash-3.10.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/d3/3.5.5/d3-3.5.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/fontawesome-iconpicker/1.0.0/fontawesome-iconpicker-1.0.0" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/react-dom/15.2.1/react-dom-15.2.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/moment-timezone-with-data/0.5.4/moment-timezone-with-data-0.5.4" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/jquery/2.1.1/jquery-2.1.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-filter/0.3.5/backgrid-filter.min-0.3.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-select-all/0.3.5/backgrid-select-all-0.3.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backbone-relational/0.9.0/backbone-relational-0.9.0" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/jsoneditor/0.7.9/jsoneditor-0.7.9" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/dimple/2.1.2/dimple-2.1.2" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/requirejs/2.1.14/requirejs-2.1.14" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/i18next/1.7.3/i18next-1.7.3" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/ldapjs-filter/2253/ldapjs-filter-2253" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/bootstrap-datetimepicker/4.14.30/bootstrap-datetimepicker-4.14.30" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/jquery.ba-dotimeout/1.0/jquery.ba-dotimeout-1.0" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/jquery-ui/1.11.1/jquery-ui-1.11.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/xdate/2.0.1/spin-2.0.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/xdate/0.8/xdate-0.8" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/moment/2.8.1/moment-2.8.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/selectize/0.12.1/selectize-0.12.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/less/1.5.1/less-1.5.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/bootstrap-dialog/1.34.4/bootstrap-dialog-1.34.4" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-paginator.min/0.3.5/backgrid-paginator.min-0.3.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/contentflow/1.0.2/contentflow-1.0.2" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backbone.paginator.min/2.0.2/backbone.paginator.min-2.0.2" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/spin/2.0.1/spin-2.0.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/titatoggle/2.0.1/spin-2.0.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/dragula/3.6.7/dragula-3.6.7" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backgrid-filter.min/0.3.5/backgrid-filter.min-0.3.5" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/react/15.2.1/react-15.2.1" "js" "min"
install_artifact "org/forgerock/commons/ui/libs/backbone/1.1.2/backbone-1.1.2" "js" "min"

# Zip files
install_artifact "org/forgerock/openicf/connectors/groovy-connector/1.4.2.1/groovy-connector-1.4.2.1" "zip" "samples"
install_artifact "org/forgerock/commons/launcher-zip/2.0.4/launcher-zip-2.0.4" "zip"
install_artifact "org/forgerock/commons/ui/forgerock-ui-user/15.2.4/forgerock-ui-user-15.2.4" "zip" "www"
install_artifact "org/forgerock/commons/ui/libs/CodeMirror/4.10/CodeMirror-4.10" "zip"
install_artifact "org/forgerock/commons/ui/libs/font-awesome/4.5.0/font-awesome-4.5.0" "zip"
install_artifact "org/forgerock/commons/ui/forgerock-ui-commons/15.2.4/forgerock-ui-commons-15.2.4" "zip" "www"

# Less files
install_artifact "org/forgerock/commons/ui/libs/backgrid.min/0.3.5/backgrid.min-0.3.5" "less"
