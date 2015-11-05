
for i in (cat Generated/block.list); wc -l Generated/$i/*.gates  | grep -o "[0-9][0-9][0-9]*" > Generated/$i/$i.metadata; end

for i in (cat modules.list)
    echo $i
    for j in (cat Data/$i.clist)
        set -l _c (echo $j | cut -d' ' -f1)
        set -l _m (echo $j | cut -d' ' -f2)
        for k in (seq 0 (math $_c-1))
            cp Generated/$_m/$_m.vSyn.gates Generated/$_m/$_m.vSyn.gates.$k
        end
    end
end

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

for i in (seq 0 3); sed -E -i s/"mcu.$i"/(math $i+23)/g cpu.vSyn.gates.0; end

for i in (seq 0 3);
    for j in (cat mcu.clist);
        set -l _c (echo $j | cut -d' ' -f1);
        set -l _n (echo $j | cut -d' ' -f2);
        set -l _s (echo $j | cut -d' ' -f3);
        for k in (seq 0 $_c);
            echo name: $_n.$k (math $_s+23+\($i\*$_c\)+$k+$i);
            set -l _t (math $_s+23+\($i\*$_c\)+$k+$i);
            sed -E -i s/"$_n.$k"/"$_t"/g mcu.vSyn.gates.(math $i+23)
        end
    end
end
