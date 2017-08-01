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
#

# This script installs all the dependencies required to successfully build
# wren:am 13.5 (sustaining/13.5 branch) in the users local Maven repo.

#Include the commands
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/install_commands.sh"

# Various
install_artifact_plain "org/forgerock/cddl-license/1.0.0/cddl-license-1.0.0.txt" "org.forgerock" "cddl-license" "1.0.0" "txt"
install_artifact "org/forgerock/commons/ui/forgerock-ui-user/13.0.3/forgerock-ui-user-13.0.3" "zip" "www"
install_artifact "org/forgerock/commons/ui/forgerock-ui-commons/13.0.3/forgerock-ui-commons-13.0.3" "zip" "www"

# POM's
install_pom "org/forgerock/commons/ui/forgerock-ui/13.0.3/forgerock-ui-13.0.3.pom"
install_pom "org/forgerock/commons/forgerock-selfservice/20.0.0-alpha-5/forgerock-selfservice-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-jaspi-modules/20.0.0-alpha-5/forgerock-jaspi-modules-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-persistit/4.3.1/forgerock-persistit-4.3.1.pom"
install_pom "org/forgerock/commons/forgerock-bloomfilter/1.0.1/forgerock-bloomfilter-1.0.1.pom"
install_pom "org/forgerock/commons/forgerock-guice/1.1.0/forgerock-guice-1.1.0.pom"
install_pom "org/forgerock/http/forgerock-http-framework-parent/20.0.0-alpha-5/forgerock-http-framework-parent-20.0.0-alpha-5.pom"
install_pom "org/forgerock/forgerock-parent/1.2.0/forgerock-parent-1.2.0.pom"
install_pom "org/forgerock/forgerock-parent/1.2.1/forgerock-parent-1.2.1.pom"
install_pom "org/forgerock/forgerock-parent/1.2.9/forgerock-parent-1.2.9.pom"
install_pom "org/forgerock/forgerock-parent/2.0.3/forgerock-parent-2.0.3.pom"
install_pom "org/forgerock/forgerock-parent/2.0.4/forgerock-parent-2.0.4.pom"
install_pom "org/forgerock/forgerock-parent/2.0.6/forgerock-parent-2.0.6.pom"
install_pom "org/forgerock/forgerock-parent/2.0.7/forgerock-parent-2.0.7.pom"
install_pom "org/forgerock/commons/commons-bom/20.0.0-alpha-5/commons-bom-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-bom/1.0.0/forgerock-bom-1.0.0.pom"
install_pom "org/forgerock/commons/forgerock-bom/3.0.0/forgerock-bom-3.0.0.pom"
install_pom "org/forgerock/commons/forgerock-bom/4.1.1/forgerock-bom-4.1.1.pom"
install_pom "org/forgerock/commons/forgerock-utilities/3.0.2/forgerock-utilities-3.0.2.pom"
install_pom "org/forgerock/commons/forgerock-utilities/20.0.0-alpha-5/forgerock-utilities-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/commons-parent/20.0.0-alpha-5/commons-parent-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-audit/20.0.0-alpha-5/forgerock-audit-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-rest/20.0.0-alpha-5/forgerock-rest-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/i18n-framework/1.4.1/i18n-framework-1.4.1.pom"
install_pom "org/forgerock/commons/i18n-framework/1.4.2/i18n-framework-1.4.2.pom"
install_pom "org/forgerock/commons/forgerock-authz-filter-parent/20.0.0-alpha-5/forgerock-authz-filter-parent-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-auth-filters/20.0.0-alpha-5/forgerock-auth-filters-20.0.0-alpha-5.pom"
install_pom "org/forgerock/commons/forgerock-authn-filter/20.0.0-alpha-5/forgerock-authn-filter-20.0.0-alpha-5.pom"

# No source JAR
install_artifact "org/forgerock/openam/pmd/rules/enforce-timeservice/1.0.0/enforce-timeservice-1.0.0" 
install_artifact "org/forgerock/forgerock-build-tools/1.0.3/forgerock-build-tools-1.0.3"
install_artifact "org/forgerock/commons/forgerock-guice-test/1.1.0/forgerock-guice-test-1.1.0"
install_artifact "org/forgerock/commons/forgerock-jaspi-openid-connect-module/20.0.0-alpha-5/forgerock-jaspi-openid-connect-module-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-selfservice-core/20.0.0-alpha-5/forgerock-selfservice-core-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-selfservice-stages/20.0.0-alpha-5/forgerock-selfservice-stages-20.0.0-alpha-5"

# Source JAR included    
install_artifact "org/apache/httpasyncclient/4.1/httpasyncclient-4.1"
install_artifact "org/forgerock/commons/forgerock-jaspi-jwt-session-module/20.0.0-alpha-5/forgerock-jaspi-jwt-session-module-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-jaspi-runtime/20.0.0-alpha-5/forgerock-jaspi-runtime-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/authz-framework/20.0.0-alpha-5/authz-framework-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/authz-framework-api/20.0.0-alpha-5/authz-framework-api-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-persistit-core/4.3.1/forgerock-persistit-core-4.3.1"
install_artifact "org/forgerock/commons/forgerock-bloomfilter-core/1.0.1/forgerock-bloomfilter-core-1.0.1"
install_artifact "org/forgerock/commons/forgerock-bloomfilter-monitoring/1.0.1/forgerock-bloomfilter-monitoring-1.0.1"
install_artifact "org/forgerock/commons/json-web-token/20.0.0-alpha-5/json-web-token-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-test-utils/20.0.0-alpha-5/forgerock-test-utils-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-util/3.0.2/forgerock-util-3.0.2"
install_artifact "org/forgerock/commons/forgerock-util/20.0.0-alpha-5/forgerock-util-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-core/20.0.0-alpha-5/forgerock-audit-core-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-handler-csv/20.0.0-alpha-5/forgerock-audit-handler-csv-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-handler-elasticsearch/20.0.0-alpha-5/forgerock-audit-handler-elasticsearch-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-handler-jdbc/20.0.0-alpha-5/forgerock-audit-handler-jdbc-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-handler-syslog/20.0.0-alpha-5/forgerock-audit-handler-syslog-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-audit-json/20.0.0-alpha-5/forgerock-audit-json-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/forgerock-guice-core/1.1.0/forgerock-guice-core-1.1.0"
install_artifact "org/forgerock/commons/forgerock-guice-servlet/1.1.0/forgerock-guice-servlet-1.1.0"
install_artifact "org/forgerock/commons/forgerock-guice-test/1.1.0/forgerock-guice-test-1.1.0"
install_artifact "org/forgerock/http/chf-client-apache-async/20.0.0-alpha-5/chf-client-apache-async-20.0.0-alpha-5"
install_artifact "org/forgerock/http/chf-client-apache-common/20.0.0-alpha-5/chf-client-apache-common-20.0.0-alpha-5"
install_artifact "org/forgerock/http/chf-client-apache-sync/20.0.0-alpha-5/chf-client-apache-sync-20.0.0-alpha-5"
install_artifact "org/forgerock/http/chf-http-core/20.0.0-alpha-5/chf-http-core-20.0.0-alpha-5"
install_artifact "org/forgerock/http/chf-http-servlet/20.0.0-alpha-5/chf-http-servlet-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/json-resource/20.0.0-alpha-5/json-resource-20.0.0-alpha-5"
install_artifact "org/forgerock/commons/json-resource-http/20.0.0-alpha-5/json-resource-http-20.0.0-alpha-5" 
install_artifact "org/forgerock/commons/i18n-core/1.4.2/i18n-core-1.4.2"
install_artifact "org/forgerock/commons/i18n-core/1.4.1/i18n-core-1.4.1" # No source of 1.4.1 but 1.4.2 does have source JAR.
install_artifact "org/forgerock/commons/i18n-slf4j/1.4.2/i18n-slf4j-1.4.2"

# OpenDJ depedencies. Sources and artifacts can be supplied by the wren:ds project.
install_pom "org/forgerock/opendj/opendj-server-parent/3.0.0/opendj-server-parent-3.0.0.pom"
install_pom "org/forgerock/opendj/opendj-sdk-parent/3.0.0/opendj-sdk-parent-3.0.0.pom"
install_pom "org/forgerock/opendj/opendj-sdk-bom/3.0.0/opendj-sdk-bom-3.0.0.pom"
install_artifact "org/forgerock/opendj/opendj-core/3.0.0/opendj-core-3.0.0"
install_artifact "org/forgerock/opendj/opendj-cli/3.0.0/opendj-cli-3.0.0"
install_artifact "org/forgerock/opendj/opendj-rest2ldap/3.0.0/opendj-rest2ldap-3.0.0"
install_artifact "org/forgerock/opendj/opendj-config/3.0.0/opendj-config-3.0.0"
install_artifact "org/forgerock/opendj/opendj-grizzly/3.0.0/opendj-grizzly-3.0.0"
install_artifact "org/forgerock/opendj/opendj-server/3.0.0/opendj-server-3.0.0"
install_artifact "org/forgerock/opendj/opendj-server-legacy/3.0.0/opendj-server-legacy-3.0.0"
install_artifact "org/forgerock/opendj/opendj-server-legacy/3.0.0/opendj-server-legacy-3.0.0" "zip"

# Since Google Guava is fully opensource it hasn't been checked which of the Guava modules are really used by the built.
# They were all just added. Also it hasn't been checked which have their sources attached (since Guava is open
# source anyway).
install_pom "org/forgerock/commons/guava/forgerock-guava/18.0.4/forgerock-guava-18.0.4.pom"
install_artifact "org/forgerock/commons/guava/forgerock-guava-annotations/18.0.4/forgerock-guava-annotations-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-base/18.0.4/forgerock-guava-base-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-cache/18.0.4/forgerock-guava-cache-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-collect/18.0.4/forgerock-guava-collect-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-concurrent/18.0.4/forgerock-guava-concurrent-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-escape/18.0.4/forgerock-guava-escape-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-eventbus/18.0.4/forgerock-guava-eventbus-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-hash/18.0.4/forgerock-guava-hash-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-io/18.0.4/forgerock-guava-io-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-math/18.0.4/forgerock-guava-math-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-net/18.0.4/forgerock-guava-net-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-primitives/18.0.4/forgerock-guava-primitives-18.0.4"
install_artifact "org/forgerock/commons/guava/forgerock-guava-reflect/18.0.4/forgerock-guava-reflect-18.0.4"
