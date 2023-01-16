#!/bin/bash
#
# Copyright 2021-2022 Fraunhofer Italia Research.
# Author: Tobit Flatscher <tobit.flatscher@fraunhofer.it>
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
# This bash script can be used to activate realtime optimisations

# Settings: have to be changed manually
cpu_id="4"
nic_device="enp5s0"

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then
    echo "Error: This script has to be run as root '$ sudo ./activate_all'!"
    exit 1
fi

# Call scripts
echo "Turning off Wifi..."
sudo ./toggle_wifi.sh off
echo ""
echo "Isolating IRQs..."
sudo ./isolate_irqs.sh $nic_device $cpu_id
echo ""
echo "Limiting C-states..."
sudo ./limit_cstates.sh all disable
echo ""
echo "Limiting P-states..."
sudo ./limit_pstates.sh all on
echo ""
echo "Done!"
