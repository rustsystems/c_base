#!/bin/bash

TIMEOUT=1h 

timeout --foreground --signal=SIGQUIT $TIMEOUT matlab -nodisplay -nodesktop -r 'run scripts/fn_imagestar(48,3);clear;quit'