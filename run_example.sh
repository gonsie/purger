#!/bin/bash

# SETUP

## This example builds the MCU component
## To build the full OpenSPARC T2 use
## cpu below
## Possible options: [spc, mcu, cpu]

COMPONENT=cpu

## All files are put into "Generated" folder
if [ ! -e Generated/ ]; then
    mkdir Generated
    mkdir Generated/lsi_10k
    mkdir Generated/megacell
fi

cat Data/$COMPONENT.clist | cut -d' ' -f 2 > Generated/block.list
mkdir Generated/$COMPONENT
for i in `cat Generated/block.list`; do
    echo Setting up for component $i
    mkdir Generated/$i
done

# LIBRARY AND NETLIST PARSING

## The first time the purger.py script is called
## {lib name}.c/.h will be generated
## library.c/.h in gates model

## parse the netlist for each component
for i in `cat Generated/block.list`; do
	python purger.py $i.vSyn
done
python purger.py $COMPONENT.vSyn

# ROUTING CALCULATION

## Metadata calculation for routing
## Essentially, count the LPs in all instantiations
for i in `cat Generated/block.list`; do
	wc -l Generated/$i/*.gates  | grep -o "[0-9][0-9][0-9]*" > Generated/$i/$i.metadata;
done
wc -l Generated/$COMPONENT/*.gates  | grep -o "[0-9][0-9][0-9]*" > Generated/$COMPONENT/$COMPONENT.metadata

## Generate routing file for component
## routing.c/.h in gates model
python router.py $COMPONENT Generated
