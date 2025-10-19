#! /bin/bash

# this scripts install common software

# the current script path
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# ---------------------------------------------------------------------------------------
# build vim from source if needed
# https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

# ---------------------------------------------------------------------------------------
# common dev tool
apt install cmake g++ --yes

# ---------------------------------------------------------------------------------------
# common network tool
apt install iproute2 iptables --yes
