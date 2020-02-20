# run command:
# fish instantiate.fish

# for i in (cat Generated/block.list);
#     wc -l Generated/$i/*.gates  | grep -o "[0-9][0-9][0-9]*" > Generated/$i/$i.metadata;
# end

#set modules spc mcu cpu
set modules mcu

## Duplicate files to support multiple instantiations of each component
for i in $modules
    echo "Working on module $i"
    if test -e Generated/$i/$i.clist
        command rm Generated/$i/$i.clist
    end
    for j in (cat Data/$i.clist)
        set -l _count (echo $j | cut -d' ' -f1)
        set -l _module (echo $j | cut -d' ' -f2)
        echo -e "\tGenerating Component $_module ($_count times)"
        for k in (seq 0 (math $_count-1))
            command cp Generated/$_module/$_module.vSyn.gates Generated/$_module/$_module.vSyn.gates.$k
        end
        echo $_count $_module (cat Generated/$_module/$_module.metadata) >> Generated/$i/$i.clist
    end
end


## RUN FIXUP FOR SUBMODULE ROUTING
cd Generated/mcu
fish mcu-instantiate.fish
cd ../..


## must do additional fixup for CPU
## There are 4 mcu's in 1 CPU
## there are 23 modules under the MCU (19 unique)


## Unknown fixup for l2t component
# for x in (seq 0 7)
#     echo $x
#     if test (cat ../cpu/cpu.vSyn.submodule-constants | grep spc.$x | wc -l) -gt 0
#         for i in (cat ../cpu/cpu.vSyn.submodule-constants | grep l2t.$x)
#             set -l _g (echo $i | cut -d'.' -f3 | cut -d' ' -f1)
#             set -l _v (echo $i | cut -d' ' -f3)
#             sed -E -i.BAK s/"^$_g 164 -1"/"$_g 164 #$_v"/ l2t.vSyn.gates.$x
#         end
#     end
# end

## Unknown fixup for cpu component
#for i in (seq 0 3); sed -E -i s/"mcu.$i"/(math $i+23)/g cpu.vSyn.gates.0; end

## Unknown duplication of mcu component
# for i in (seq 0 3);
#     for j in (cat mcu.clist);
#         set -l _c (echo $j | cut -d' ' -f1);
#         set -l _n (echo $j | cut -d' ' -f2);
#         set -l _s (echo $j | cut -d' ' -f3);
#         for k in (seq 0 $_c);
#             echo name: $_n.$k (math $_s+23+\($i\*$_c\)+$k+$i);
#             set -l _t (math $_s+23+\($i\*$_c\)+$k+$i);
#             sed -E -i s/"$_n.$k"/"$_t"/g mcu.vSyn.gates.(math $i+23)
#         end
#     end
# end
