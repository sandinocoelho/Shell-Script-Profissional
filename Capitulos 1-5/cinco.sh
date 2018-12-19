#!/bin/bash
# cinco.sh
#
# Conta até 5
# :)
#
#
#
trap read DEBUG
echo $((0+1))
echo $((0+2))
set -xv
echo $((0+3))
set +xv
echo $((0+4))
echo $((0+5))
trap "" DEBUG