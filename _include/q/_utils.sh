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

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="${SCRIPT_DIR}/../../docs/config.toml"

# fatal error handling
export PROCESS_ID=$$
trap 'exit 1' TERM

function extract_parameter() {
  if [[ "$#" != 1 ]]; then
    trigger_fatal_error "Fatal error: No parameter or too many parameters passed: $@"
  fi
  parameter_value="$(awk -F'"' '/'$1'[ ]*=[ ]*"/{print $2}' $CONFIG_DIR)"
  if [ "$parameter_value" = "" ]; then
    trigger_fatal_error "Fatal error: $1 parameter no found valid value."
  fi
  echo ${parameter_value}
}

function trigger_fatal_error() {
  echo $1 >&2
  kill -s TERM $PROCESS_ID
}