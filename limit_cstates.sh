#!/bin/bash
#
# Copyright 2021-2022 Fraunhofer Italia Research.
# Authors: Michael Terzer <michael.terzer@fraunhofer.it>
#          Tobit Flatscher <tobit.flatscher@fraunhofer.it>
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
# This bash script limits the sleep stages, the so called C-states (cpuidle in Linux) of a given computer.
# It copies the corresponding script to 'usr/local/bin/couidle' and launches it with the two given input arguments
# generally either '$ ./limit_cstates.sh all disable' or '$ ./limit_cstates.sh all enable'"
# Alternatively it could by called as a bash script directly.

# Check correct number of input arguments
if [ $# -ne 2 ]
  then
    echo "Error: Wrong number of input arguments provided: 2 required, '$#' provided!"
    echo "Usage: '$ ./limit_cstates.sh all disable'"
    exit 1
fi

# Check if file exists already
file="cpuidle"
src_dir="cpuidle-tools"
dst_dir="/usr/local/bin"

# Check if destination file exists already
src_file="$src_dir/$file"
dst_file="$dst_dir/$file"
if [ -f "$dst_file" ]
  then
    echo "File '$dst_file' found."
else
  echo "Warning: File '$dst_file' not found."
  
  # Check if directory exists
  if [ ! -d "$dst_dir" ]
    then
      echo "Error: Directory '$dst_dir' found."
      exit 1
  fi
  
  # Check if source file exists
  echo "Trying to copy file '$src_file' to '$dst_file'..."
  if [ -f "$src_file" ]
    then
      echo "File '$src_file' found."
      
      # Check if script is run as root
      if [ "$EUID" -ne 0 ]
        then
          echo "Error: In order to copy file '$src_file' to '$dst_file' this script has to be run as root '$ sudo ./limit_cstates.sh all disable'!"
          exit 1
      fi
      
      # Copy the source file to the destination
      sudo cp -p $src_file $dst_file
      sudo chmod +x $dst_file
      echo "File '$src_file' copied to '$dst_file' successfully."
  else
    echo "Error: File '$src_file' not found."
    exit 1
  fi
fi

# Run the script
sudo cpuidle $1 $2 || echo "Error: Could not find the 'cpuidle' tools! Please install them."
echo "Done!"
