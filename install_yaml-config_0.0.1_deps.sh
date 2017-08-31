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
# Portions copyright 2017 Orchitech Solutions s.r.o.
#

# This script installs all the dependencies required to successfully build
# the Orchitech YAML config bundle in the user's local Maven repo.

#Include the commands
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/install_commands.sh"

# POM files
install_pom "org/forgerock/commons/commons-parent/21.0.0-alpha-17/commons-parent-21.0.0-alpha-17.pom"
install_pom "org/forgerock/commons/forgerock-rest/21.0.0-alpha-17/forgerock-rest-21.0.0-alpha-17.pom"
install_pom "org/forgerock/commons/forgerock-utilities/21.0.0-alpha-17/forgerock-utilities-21.0.0-alpha-17.pom"
install_pom "org/forgerock/http/forgerock-http-framework-parent/21.0.0-alpha-17/forgerock-http-framework-parent-21.0.0-alpha-17.pom"

# JAR files
install_artifact "org/forgerock/commons/api-descriptor/21.0.0-alpha-17/api-descriptor-21.0.0-alpha-17"
install_artifact "org/forgerock/commons/forgerock-util/21.0.0-alpha-17/forgerock-util-21.0.0-alpha-17"
install_artifact "org/forgerock/commons/json-resource/21.0.0-alpha-17/json-resource-21.0.0-alpha-17"
install_artifact "org/forgerock/http/chf-http-core/21.0.0-alpha-17/chf-http-core-21.0.0-alpha-17"
