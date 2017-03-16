#!/bin/bash

if [ ! -e Generated/ ]; then
    mkdir Generated
    mkdir Generated/lsi_10k
    mkdir Generated/megacell
    mkdir Generated/ccx
fi

python purger.py ccx.vSyn
