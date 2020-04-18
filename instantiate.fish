# run command:
# fish instantiate.fish

# create metadata files
if false
    echo "GENERATING METADATA"
    for i in (cat Generated/block.list);
        wc -l Generated/$i/*.gates  | grep -o "[0-9][0-9][0-9]*" > Generated/$i/$i.metadata;
    end
end

## CURRENTLY HARD CODED FOR CPU / TOP LEVEL REPLICATION
## WOULD NEED WORK TO HANDLE MULTIPLE COMPONENTS
#set modules spc mcu cpu
set modules cpu

function _module_replication -d "replicate a file n times"
    echo "Calling _module_replication with $argv[1] $argv[2]"
    set -l _count $argv[1]
    set -l _module $argv[2]
    for k in (seq 0 (math $_count-1))
        command cp Generated/$_module/$_module.vSyn.gates Generated/$_module/$_module.vSyn.gates.$k
    end
    echo $_count $_module (cat Generated/$_module/$_module.metadata) >> Generated/$modules/$modules.clist
end

## Duplicate files to support multiple instantiations of each component
if false
    for i in $modules
        echo "Working on module $i"
        if test -e Generated/$i/$i.clist
            command rm Generated/$i/$i.clist
        end
        # don't forget top level replication
        _module_replication 1 $i
        for j in (cat Data/$i.clist)
            set -l _count (echo $j | cut -d' ' -f1)
            set -l _module (echo $j | cut -d' ' -f2)
            _module_replication $_count $_module
            # echo -e "\tGenerating Component $_module ($_count times)"
            # for k in (seq 0 (math $_count-1))
            #     command cp Generated/$_module/$_module.vSyn.gates Generated/$_module/$_module.vSyn.gates.$k
            # end
            ## check for sub-components
            if test -e Data/$_module.clist
                echo "SUBCOMPONENTS MUST BE REPLICATED $_count times"
                for k in (cat Data/$_module.clist)
                    set -l _kcount (echo $k | cut -d' ' -f1)
                    set -l _kmodule (echo $k | cut -d' ' -f2)
                    _module_replication (math $_kcount \* $_count) $_kmodule
                end
            end
        end
    end
end

## RUN FIXUP FOR SUBMODULE ROUTING
# cd Generated/mcu
# fish mcu-instantiate.fish
# cd ../..
## must do additional fixup for CPU
## There are 4 mcu's in 1 CPU
## there are 23 modules under the MCU (19 unique)

## Figure out where connections need to happen
## DONE AND FILES CHECKED IN, DO NOT RERUN
if false
    # HARDCODED FOR MODULES THAT HAVE 'EM
    #command mv Generated/neededlinks.txt Generated/neededlinks.txt.bak
    for i in cpu mcu spc
        echo "Grepping through $i"
        egrep -o " [[:alnum:]_]*\.[0-9]*" Generated/$i/$i.vSyn.gates | sort -u
    end
end

## fixup multiple instantiations of mcu (4) and spc (8)
## with the caveat that there are multiples subcomponents
## spc: 2 exu
## mcu:
##      2 mcu_fbd_dp
##      2 mcu_l2if_ctl
##      2 mcu_lndskw_dp
##      2 mcu_readdp_dp
## fix to make:
## spc.vSyn.gates.0 has dec.0
## spc.vSyn.gates.1 should have dec.1

if false
    cd Generated/spc
    fish ../../spc-fixup.fish
    cd ../..

    cd Generated/mcu
    fish ../../mcu-fixup.fish
    cd ../..
end

## use router.py to generate cpu.links file
if false
    # for each possbile link
    cd Generated
    for _l in (cat ../cpu.links)
        set -l _route (echo $_l | cut -d' ' -f1)
        set -l _offset (echo $_l | cut -d' ' -f2)
        echo "Performing replacement: $_route -> $_offset"

        # cpu
        sed -E -i '' s/"$_route\."/"$_offset\."/g cpu/cpu.vSyn.gates.0

        # spc
        for i in (seq 0 7)
            sed -E -i '' s/"$_route\."/"$_offset\."/g spc/spc.vSyn.gates.$i
        end

        # mcu
        for i in (seq 0 3)
            sed -E -i '' s/"$_route\."/"$_offset\."/g mcu/mcu.vSyn.gates.$i
        end

    end
    cd ..
end

### STOP!!!!
exit

## Unknown fixup for l2t component
cd Generated/l2t
echo "RUNNING FIXUP FOR L2T"
for x in (seq 0 7)
    echo $x
    if test (cat ../cpu/cpu.vSyn.submodule-constants | grep spc.$x | wc -l) -gt 0
        for i in (cat ../cpu/cpu.vSyn.submodule-constants | grep l2t.$x)
            set -l _g (echo $i | cut -d'.' -f3 | cut -d' ' -f1)
            set -l _v (echo $i | cut -d' ' -f3)
            sed -E -i.BAK s/"^$_g 164 -1"/"$_g 164 #$_v"/ l2t.vSyn.gates.$x
        end
    end
end
cd ../..

## Unknown fixup for cpu component
cd Generated/cpu
echo "RUNNING FIXUP FOR CPU"
for i in (seq 0 3)
    sed -E -i.BAK s/"mcu.$i"/(math $i+23)/g cpu.vSyn.gates.0
end
cd ../..

## Unknown duplication of mcu component
cd Generated/mcu
echo "RUNNING FIXUP FOR MCU"
for i in (seq 0 3);
    for j in (cat mcu.clist);
        set -l _c (echo $j | cut -d' ' -f1);
        set -l _n (echo $j | cut -d' ' -f2);
        set -l _s (echo $j | cut -d' ' -f3);
        for k in (seq 0 $_c);
            echo name: $_n.$k (math $_s+23+\($i\*$_c\)+$k+$i);
            set -l _t (math $_s+23+\($i\*$_c\)+$k+$i);
            sed -E -i.BAK s/"$_n.$k"/"$_t"/g mcu.vSyn.gates.(math $i+23)
        end
    end
end
cd ../..
