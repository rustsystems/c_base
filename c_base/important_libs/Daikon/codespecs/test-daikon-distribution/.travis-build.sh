#!/bin/bash -v

# Fail the whole script if any command fails
set -e

curl --fail -O https://raw.githubusercontent.com/codespecs/daikon/master/scripts/test-distribution.sh

sh test-distribution.sh
