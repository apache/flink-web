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

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${SCRIPT_DIR}/_utils.sh"

docker pull jakejarvis/hugo-extended:latest

action=$1
if [[ $action = "build" ]]
then
  prepareDocBuild
  docker run -v $(pwd)/docs:/src -p 1313:1313 jakejarvis/hugo-extended:latest --destination target
  finalizeDocBuild
else
  docker run -v $(pwd)/docs:/src -p 1313:1313 jakejarvis/hugo-extended:latest --buildDrafts --buildFuture --bind 0.0.0.0 server
fi
