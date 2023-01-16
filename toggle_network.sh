#!/bin/bash
#
# Copyright 2021-2022 Fraunhofer Italia Research.
# Authors: Tobit Flatscher <tobit.flatscher@fraunhofer.it>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This bash script can be used to turn the networks in Ubuntu on and off

if [ $# -ne 1 ]
  then
    echo "Error: Wrong number of input arguments provided: 1 required, '$#' provided!"
    echo "Usage: '$ ./toggle_network.sh state'"
    exit 1
fi

arg=$1
if [ "$arg" == "on" ]
  then
    echo "Turning on networking..."
    service network restart
elif [ "$arg" == "off" ]
  then
    echo "Turning off networking..."
    service network stop
else
  echo "Error: Argument '$arg' not recognised: Argument can be either 'on' or 'off' only."
  exit 1
fi

echo "Done!"
