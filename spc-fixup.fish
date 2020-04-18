for i in (seq 0 7)
    echo "Fixing up spc # $i"
    sed -E -i '' s/"dec\.0\."/"dec\.$i\."/g spc.vSyn.gates.$i

    # there are 2 exu per spc
    set -l j (math "$i * 2")
    set -l k (math "$i *2 +1")
    echo "   j=$j  k=$k"
    sed -E -i '' s/"exu\.0\."/"exu\.$j\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"exu\.1\."/"exu\.$k\."/g spc.vSyn.gates.$i

    sed -E -i '' s/"fgu\.0\."/"fgu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"gkt\.0\."/"gkt\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"ifu_cmu\.0\."/"ifu_cmu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"ifu_ftu\.0\."/"ifu_ftu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"ifu_ibu\.0\."/"ifu_ibu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"lsu\.0\."/"lsu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"mmu\.0\."/"mmu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"pku\.0\."/"pku\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"pmu\.0\."/"pmu\.$i\."/g spc.vSyn.gates.$i
    sed -E -i '' s/"tlu\.0\."/"tlu\.$i\."/g spc.vSyn.gates.$i
end
