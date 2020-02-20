# move to Generated/mcu/ directory before running
# run command:
# fish mcu-instantiate.fish

if test ! -e mcu.vSyn.gates.orig
    echo "Creating a backup of mcu.vSyn.gates"
    command cp mcu.vSyn.gates mcu.vSyn.gates.orig
end

set top_count (cat mcu.metadata)
set offset 0

echo -e Processing mcu\n\tinital offset $offset\n\ttop count $top_count
set offset (math $offset + $top_count)

for i in (cat mcu.clist)
    set -l _data (string split ' ' $i)
    for j in (seq 0 (math $_data[1]-1))
        echo Processing $_data[2].$j\toffset $offset\tcount $_data[3]

        awk -v cmpt="$_data[2].$j.[0-9]+" -v offset=$offset '{
        match($0, cmpt);
        split(substr($0, RSTART, RLENGTH), a, ".");
        gsub(cmpt,a[3]+offset);
        print $0;}' mcu.vSyn.gates > mcu.vSyn.gates.tmp
        command mv mcu.vSyn.gates.tmp mcu.vSyn.gates

        set offset (math $offset + $_data[3])
    end
end

echo Final count is $offset
