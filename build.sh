#!/usr/bin/env bash
################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

REQUIRED_HUGO_VERSION="0.124.1"

if ! command -v hugo &> /dev/null
then
	echo "Hugo must be installed to run the docs locally"
	echo "Please see docs/README.md for more details"
	exit 1
fi

HUGO_VERSION_OUTPUT=$(hugo version)
HUGO_VERSION=$(echo "${HUGO_VERSION_OUTPUT}" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'  | head -1)
if [[ "${HUGO_VERSION}" != "${REQUIRED_HUGO_VERSION}" ]]
then
	echo "Hugo version ${REQUIRED_HUGO_VERSION} is required, but found ${HUGO_VERSION}"
	echo "Please install Hugo extended v${REQUIRED_HUGO_VERSION}"
	exit 1
fi

if ! echo "${HUGO_VERSION_OUTPUT}" | grep -qi 'extended'
then
	echo "Hugo extended edition is required, but a non-extended version was found"
	echo "Please install Hugo extended v${REQUIRED_HUGO_VERSION}"
	exit 1
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/_utils.sh"

action=$1
if [[ $action = "build" ]]
then
  prepareDocBuild
  hugo --source docs --destination target
  finalizeDocBuild
else
  hugo --source docs --buildDrafts --buildFuture --bind 0.0.0.0 server
fi

